 /*
    FuzzyDecisionTree.h
 
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
    Boston, MA 021101301, USA.
 */
 
#ifndef FuzzyDTree_h_defined
#define FuzzyDTree_h_defined

#import <Foundation/Foundation.h>
@class FuzzyPredicate;
@class FuzzyDTreeFactory;
@class FuzzyDTreeNode;
@class FuzzyInference;
@class FuzzyVisitor;
@class InferenceAtom;
@class InferenceVariable;
@class InferenceNumber;
@class InferenceCompound;
@class InferenceADT;
@class InferenceManipulator;


@interface FuzzyDTreeFactory : NSObject
{
	FuzzyInference *_inference;		
}
- (FuzzyDTreeFactory*)initInference:(FuzzyInference*)inf;
- (id) makeDTree;
- (id) makeADT:(FuzzyPredicate*)p with:(Class)adt; 
- (id) makeAtom:(FuzzyPredicate*)p; 
- (id) makeVar:(FuzzyPredicate*)p; 
- (id) makeNumber:(FuzzyPredicate*)p; 
- (id) makeCompound:(FuzzyPredicate*)p; 
//_inference wrapper
//- (InferenceManipulator*)createInferenceManipulator;
@end

@interface FuzzyDTreeRoot : NSObject {
	FuzzyDTreeNode *_rootnode;
}
- (id) new; 
-(void)addNode:(FuzzyDTreeNode*)n;
-(void)printTree;
@end
@interface FuzzyDTreeNode : NSObject {
	InferenceADT *_adt;
	NSMutableArray *_cons;
}
- (id) new;
- (FuzzyDTreeNode*) initADT:(InferenceADT*)adt;
- (id) adt;
- (void)addNode:(FuzzyDTreeNode*)n;
-(id)searchTreeFor:(FuzzyPredicate*)ds;
-(void)printTree;
-(void)printTreeRec;
@end
@interface FuzzyDTreeNodeCon : NSObject {
	FuzzyDTreeNode *_node;	
}
- (FuzzyDTreeNodeCon*) initNode:(FuzzyDTreeNode*)node;
- (id)node;
@end
@interface FuzzyDTree : NSObject {
	FuzzyDTreeRoot *_root;		
	FuzzyInference *_inference;		
}
- (id)new;
- (FuzzyDTree*)init:(FuzzyDTreeFactory*)factory with:(FuzzyInference*)inf; 
- (void)accept:(FuzzyVisitor*)v;
- (void) addCompound:(InferenceCompound*)comp;
-(id)searchTreeFor:(FuzzyPredicate*)ds;
-(void) compileAtomToTree:(InferenceAtom*)atom;
-(void) compileNumberToTree:(InferenceNumber*)num;
-(void) compileVariableToTree:(InferenceVariable*)var;
-(void) compileCompoundToTree:(InferenceCompound*)comp;
- (void)addNode:(FuzzyDTreeNode*)n;
-(void)printTree;
@end
#endif
