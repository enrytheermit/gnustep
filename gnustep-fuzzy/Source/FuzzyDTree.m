 /*
    FuzzyDecisionTree.m
 
    Copyright (C) 2014 Free Software Foundation, Inc.
 
    Author: Johan Ceuppens <johan@yellowcouch.org>
    Date: Dec 2014 
 
    This file is part of GNUstep.
 
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.
 
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
    License along with this library; see the file COPYING.LIB.
    If not, see <http://www.gnu.org/licenses/> or write to the
    Free Software Foundation, 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
 */
 
#import "../Headers/FuzzyDTree.h"
#import "../Headers/FuzzyPredicate.h"
#import "../Headers/FuzzyInference.h"
#import "../Headers/FuzzyVisitor.h"
#import "../Headers/FuzzyManipulator.h"

#import "../Headers/FuzzyMACROS.h"
 
@implementation FuzzyDTreeFactory
- (id)new
{
	return self;
}

- (id)init:(FuzzyInference*)inf
{
	_inference = inf;
	return self;
}

- (id) makeDTree
{
	return [FuzzyDTree new];
}

- (id) makeADT:(FuzzyPredicate*)p with:(Class)adt
{
	InferenceADT *iadt = [[adt class] new];
	InferenceNode *n = [InferenceNode new];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	return [_inference parse: iadt];
} 

- (id) makeAtom:(FuzzyPredicate*)p
{
	InferenceAtom *iadt = [InferenceAtom new];
	InferenceNode *n = [InferenceNode new];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	NSLog(@"Factory made atom");
	return [_inference parse: iadt];
}

- (id) makeNumber:(FuzzyPredicate*)p
{
	InferenceNumber *iadt = [InferenceNumber new];
	InferenceNode *n = [InferenceNode new];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	return [_inference parse: iadt];
}

- (id) makeVar:(FuzzyPredicate*)p
{
	InferenceVariable *iadt = [InferenceVariable new];
	InferenceNode *n = [InferenceNode new];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	return [_inference parse: iadt];
}

- (id) makeCompound:(FuzzyPredicate*)p
{
	InferenceCompound *iadt = [InferenceCompound new];
	InferenceNode *n = [InferenceNode new];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	NSLog(@"Factory made compound");
	return [_inference parse: iadt];
}

- (id) createInferenceManipulator
{
	return [[InferenceManipulator new] init:self];
}

@end

@implementation FuzzyDTreeRoot

- (id) new
{
	_rootnode = [FuzzyDTreeNode new];
	return self;
}

-(id)searchTreeFor:(FuzzyPredicate*)ds
{
	return [_rootnode searchTreeFor:ds];
}

-(void)printTree
{
	[_rootnode printTree];
}

-(void)addNode:(FuzzyDTreeNode*)n
{
	[_rootnode addNode:n];
}
@end

@implementation FuzzyDTreeNode

- (id) new
{
	_cons = [[NSMutableArray alloc] init];
	return self;
}

- (id) init:(InferenceADT*)adt
{
	_adt = adt;
	return self;
}

- (void)addNode:(FuzzyDTreeNode*)n
{
	NSLog(@"adding node");
	[_cons addObject:[[FuzzyDTreeNodeCon new] init:n]];	
} 

-(id)searchTreeFor:(FuzzyPredicate*)ds
{
    //greedy search for node which matches ds
    NSEnumerator *enumerator = [_cons keyEnumerator];
    id val;
    while ((val = [enumerator nextObject])) {
	NSString *dds = [[[val node] adt] dataToString];
	if ([dds UTF8String] == [ds UTF8String]) {
		return [val node];
	}
    }
    //descend recursively through all connections towards their linked node
    enumerator = [_cons keyEnumerator];
    while ((val = [enumerator nextObject])) {
   	return [[val node] searchTreeFor:ds];
    } 
    return nil;
}

- (void)splitForNot:(FuzzyPredicate *)p
{
	[_cons addObject:[[FuzzyDTreeNodeCon new] init:[[FuzzyDTreeNode new] init:[[InferenceCompound new] init:[[InferenceNode new] init:p]]]]];	
} 
- (void)addForNot:(FuzzyPredicate *)p
{
	NSLog(@"_cons has length %d in node %@", [_cons count], self); 
	//[_cons addObject:[[FuzzyDTreeNodeCon new] init:[[FuzzyDTreeNode new] init:[[InferenceCompound new] init:[[InferenceNode new] init:p]]]]];	
	[_cons addObject:[[FuzzyDTreeNodeCon new] init:self]];	
	NSLog(@"_cons has length %d in node %@", [_cons count], self); 

} 
- (id)adt
{
	return _adt;
}

-(void)printTree
{
	[self printTreeRec];
}

-(void)printTreeRec
{
    //greedy search for node which matches ds
    NSEnumerator *enumerator = [_cons keyEnumerator];
    id val;
    while ((val = [enumerator nextObject])) {
	NSString *dds = [[[val node] adt] dataToString];
    }
    //descend recursively through all connections towards their linked node
    enumerator = [_cons keyEnumerator];
    while ((val = [enumerator nextObject])) {
   	[[val node] printTreeRec];
    } 
}

@end
@implementation FuzzyDTreeNodeCon

- (id) new
{
	return self;
}

- (id) init:(FuzzyDTreeNode*)node
{
	_node = node;
	return self;
}

-(id)node
{
	return _node;
}

@end

@implementation FuzzyDTree

-(id)new
{
	return self;
}

- (id)init:(FuzzyDTreeFactory*)factory with:(FuzzyInference*)inf
{
	_inference = inf; 
	_root = [FuzzyDTreeRoot new];
	return self;
} 

- (void)accept:(FuzzyVisitor*)v
{
	[v visitDTree: self];
}

- (void) addCompound:(InferenceCompound*)comp
{
	[comp parse:_inference]; //NOTE adds compound to _compounds DB
}

-(id)searchTreeFor:(FuzzyPredicate*)ds
{
	return [_root searchTreeFor:ds];
}

-(void) compileCompoundToTree:(InferenceCompound*)comp
{
	NSLog(@"Compiling compound to tree.");
	FuzzyPredicate *ps = [[comp node] predicate]; 
	/* 
	pack comp data (a string) to without spaces e.g. "not x" becomes "notx"
	*/
	//[ps unspacify];
	if ([ps rangeOfString:NOTS].length == 3) {
		/* NOTE : for speed
			unsigned int len = [[[comp node] data] length];
			char buffer[len];
			strncpy(buffer, [ps UTF8String], [ps length]); 
			//or [ps getCharacters:buffer range:NSMakeRange(3, [ps length])];
			FuzzyDTreeNode *n = [self searchTreeFor:[[NSString alloc] initWithCharacters:buffer length:len]];
		*/
		FuzzyPredicate *p = [[FuzzyPredicate new] init:[[ps UTF8String] substringWithRange:NSMakeRange(3,[ps length]-3)]];
		FuzzyDTreeNode *n = [self searchTreeFor:p];
		if (n) {
			NSLog(@"splitting node for not clause");
			[n splitForNot:ps];	
		} else {
			NSLog(@"adding node for not clause = %@", [ps UTF8String]);
			FuzzyDTreeNode *nn = [[FuzzyDTreeNode new] init:comp]; 
			[_root addNode:nn];	
		}	
	}	
/***	if ([[comp data] rangeOfString:ORS] == [ORS length]) {
	}	
	if ([[comp data] rangeOfString:XORS] == [XORS length]) {
	}	
	if ([[comp data] rangeOfString:ANDS] == [ANDS length]) {
	}	
***/
}

-(void) compileVariableToTree:(InferenceVariable*)var
{
}

-(void) compileNumberToTree:(InferenceNumber*)num
{
}

-(void) compileAtomToTree:(InferenceAtom*)atom
{
	if ([[atom node] data] != nil) {
		
	}
	return self;
}

-(void)printTree 
{
	[_root printTree];	
}
@end
