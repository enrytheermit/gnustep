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

- (FuzzyDTreeFactory*)initInference:(FuzzyInference*)inf
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
/***
- (InferenceManipulator*) createInferenceManipulator
{
	return [[InferenceManipulator new] init:_inference];
}
***/
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

-(void)addToRootNode:(FuzzyDTreeNode*)n
{
	[_rootnode addToRootNode:n];
}
-(void)addNode:(FuzzyDTreeNode*)n
{
	[_rootnode addNode:n];
}
@end

@implementation FuzzyDTreeNode

- (id) new
{
	return self;
}

- (FuzzyDTreeNode*) initADT:(InferenceADT*)adt
{
	_cons = [[NSMutableArray alloc] init];
	_adt = adt;
	return self;
}

- (void)addToRootNode:(FuzzyDTreeNode*)n
{
	NSLog(@"adding to root node");
	FuzzyDTreeNodeCon *c = [FuzzyDTreeNodeCon new];
	[c initNode:n];
	[_cons addObject:c];	
} 

- (void)addNode:(FuzzyDTreeNode*)n
{
	NSLog(@"adding node");
	FuzzyDTreeNodeCon *c = [FuzzyDTreeNodeCon new];
	[c initNode:n];
	[_cons addObject:c];	
} 

-(id)searchTreeFor:(FuzzyPredicate*)ds
{
    //greedy search for node which matches ds

	for (FuzzyDTreeNodeCon *con in _cons)
	{
		NSString *dds = [[[con node] adt] dataToString];
		if ([dds UTF8String] == [ds UTF8String]) {
		return [con node];
		}
    	}
    //descend recursively through all connections towards their linked node
	for (FuzzyDTreeNodeCon *con in _cons)
	{
   		return [[con node] searchTreeFor:ds];
    	}	 
    return nil;
}

- (void)splitForNot:(FuzzyPredicate *)p
{
	FuzzyDTreeNodeCon *c = [FuzzyDTreeNodeCon new];
	InferenceCompound *ic = [InferenceCompound new];
	InferenceNode *in = [InferenceNode new];
	[in initNode:p];
	[ic node:in];
	[c initNode:[[FuzzyDTreeNode new] initADT:ic]];
	[_cons addObject:c];	
} 
- (void)addForNot:(FuzzyPredicate *)p
{
	//NSLog(@"_cons has length %d in node %@", [_cons count], self); 
	FuzzyDTreeNodeCon *c = [FuzzyDTreeNodeCon new];
	[c initNode:self];
	[_cons addObject:c];	
	//NSLog(@"_cons has length %d in node %@", [_cons count], self); 

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
	for (FuzzyDTreeNodeCon* con in _cons) {
		//NSString *dds = [[[con node] adt] dataToString];
    	}
    //descend recursively through all connections towards their linked node
	for (FuzzyDTreeNodeCon* con in _cons) {
   		[[con node] printTreeRec];
    	}	 
}

@end
@implementation FuzzyDTreeNodeCon

- (id) new
{
	return self;
}

- (FuzzyDTreeNodeCon*) initNode:(FuzzyDTreeNode*)node
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

- (FuzzyDTree*)init:(FuzzyDTreeFactory*)factory with:(FuzzyInference*)inf
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
-(void)addToRootNode:(FuzzyDTreeNode*)n
{
	[_root addToRootNode:n];
}

-(void)addNode:(FuzzyDTreeNode*)n
{
	[_root addNode:n];
}

-(id)searchTreeFor:(FuzzyPredicate*)ds
{
	return [_root searchTreeFor:ds];
}

-(void) compileCompoundToTree:(InferenceCompound*)comp
{
	NSLog(@"Compiling compound to tree.");
	FuzzyPredicate *ps = [[comp node] pred]; 
	/* 
	pack comp data (a string) to without spaces e.g. "not x" becomes "notx"
	*/
	//[ps unspacify];
	if ([ps rangeOfString:NOTS].length == 3) {
		FuzzyPredicate *p = [FuzzyPredicate new];
		[p init:[ps substringWithRange:NSMakeRange(3,[ps length]-3)]];
		FuzzyDTreeNode *n = [self searchTreeFor:p];
		if (n) {
			NSLog(@"splitting node for not clause");
			[n splitForNot:ps];	
		} else {
			NSLog(@"adding node for not clause = %@", [ps UTF8String]);
			FuzzyDTreeNode *nn = [[FuzzyDTreeNode new] initADT:comp]; 
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
}

-(void)printTree 
{
	[_root printTree];	
}
@end
