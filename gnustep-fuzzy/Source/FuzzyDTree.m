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

- (id) init { 
	if ( self = [super init] ) {
		_inference = nil;
	}
	 return self; 
}

- (void)setInference:(FuzzyInference*)inf
{
	_inference = inf;
	return self;
}

- (id) makeDTree
{
	return [[FuzzyDTree alloc] init];
}

- (id) makeADT:(FuzzyPredicate*)p with:(Class)adt
{
	InferenceADT *iadt = [[[adt class] alloc] init];
	InferenceNode *n = [[InferenceNode alloc] init];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	return [_inference parse: iadt];
} 

- (id) makeAtom:(FuzzyPredicate*)p
{
	InferenceAtom *iadt = [[InferenceAtom alloc] init];
	InferenceNode *n = [[InferenceNode alloc] init];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	NSLog(@"Factory made atom");
	return [_inference parse: iadt];
}

- (id) makeNumber:(FuzzyPredicate*)p
{
	InferenceNumber *iadt = [[InferenceNumber alloc] init];
	InferenceNode *n = [[InferenceNode alloc] init];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	return [_inference parse: iadt];
}

- (id) makeVar:(FuzzyPredicate*)p
{
	InferenceVariable *iadt = [[InferenceVariable alloc] init];
	InferenceNode *n = [[InferenceNode alloc] init];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	return [_inference parse: iadt];
}

- (id) makeCompound:(FuzzyPredicate*)p
{
	InferenceCompound *iadt = [[InferenceCompound alloc] init];
	InferenceNode *n = [[InferenceNode alloc] init];
	//[n data:p];
	[n predicate:p];
	[iadt node:n];
	NSLog(@"Factory made compound");
	return [_inference parse: iadt];
}
/***
- (InferenceManipulator*) createInferenceManipulator
{
	return [[[InferenceManipulator alloc] init] init:_inference];
}
***/
@end

@implementation FuzzyDTreeRoot

- (id) init 
{
	_rootnode = [[FuzzyDTreeNode alloc] init];
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


- (void) setADT:(InferenceADT*)adt
{
	//FIXME random alloc
	_cons = [[NSMutableArray alloc] init];
	_adt = adt;
}

- (void)addToRootNode:(FuzzyDTreeNode*)n
{
	NSLog(@"adding to root node");
	FuzzyDTreeNodeCon *c = [[FuzzyDTreeNodeCon alloc] init];
	[c initNode:n];
	[_cons addObject:c];	
} 

- (void)addNode:(FuzzyDTreeNode*)n
{
	NSLog(@"adding node");
	FuzzyDTreeNodeCon *c = [[FuzzyDTreeNodeCon alloc] init];
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
	FuzzyDTreeNodeCon *c = [[FuzzyDTreeNodeCon alloc] init];
	InferenceCompound *ic = [[InferenceCompound alloc] init];
	InferenceNode *in = [[InferenceNode alloc] init];
	[in initNode:p];
	[ic node:in];
	FuzzyDTreeNode * tn = [[FuzzyDTreeNode alloc] init];
	[tn setADT:ic];
	[c initNode:tn];
	[_cons addObject:c];	
} 
- (void)addForNot:(FuzzyPredicate *)p
{
	//NSLog(@"_cons has length %d in node %@", [_cons count], self); 
	FuzzyDTreeNodeCon *c = [[FuzzyDTreeNodeCon alloc] init];
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

- (id) init 
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

-(id) init
{
	return self;
}

- (FuzzyDTree*)init:(FuzzyDTreeFactory*)factory with:(FuzzyInference*)inf
{
	_inference = inf; 
	_root = [[FuzzyDTreeRoot alloc] init];
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
	//[ps unspacify];
	*/
	if ([ps rangeOfString:NOTS].length == 3) {
		FuzzyPredicate *p = [[FuzzyPredicate alloc] init];
		//search for a node with the negated value p
		[p init:[ps substringWithRange:NSMakeRange(3,[ps length]-3)]];
		FuzzyDTreeNode *n = [self searchTreeFor:p];
		if (n) {
			NSLog(@"splitting node for not clause");
			[n splitForNot:ps];	
		} else {
		//if node not found, this is should be impossible as atoms
		//are all already in the tree
		//other compound clauses are compiled further
			/////FuzzyDTreeNode *nn = [[[FuzzyDTreeNode alloc] init] setADT:comp]; 
			////[_root addNode:nn];	
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
