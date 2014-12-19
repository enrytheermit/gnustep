 /*
    FuzzyInference.h
 
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
 
 #ifndef FuzzyInference_h_defined
 #define FuzzyInference_h_defined

#import <Foundation/Foundation.h>
@class FuzzyDB;
@class FuzzyPredicate;
@class FuzzyInference;
@class FuzzyDTree;
@class FuzzyVisitor;

@interface InferenceNode : NSObject
{
	NSData *_data;
	FuzzyPredicate *_predicate;
}
-(id)new;
-(id)init:(FuzzyPredicate*)p;
-(id)data;
-(NSString*)dataToString;
-(void)data:(id)d;
-(FuzzyPredicate*)predicate;
-(void)predicate:(FuzzyPredicate*)d;
@end

@interface InferenceADT : NSObject
{
	InferenceNode* _node;
	int _nodeid;
}
- (id)new;
-(id)node;
-(void)node:(InferenceNode*)n;
-(int)nodeid;
-(void)nodeid:(int)n;
@end

@interface InferenceAtom : InferenceADT
{
}
-(id) parse:(FuzzyInference*)inf;
@end
@interface InferenceVariable : InferenceADT
{
}
-(id) parse:(FuzzyInference*)inf;
@end
@interface InferenceNumber : InferenceADT
{
}
-(id) parse:(FuzzyInference*)inf;
@end
@interface InferenceCompound : InferenceADT
{
}
- (id)new;
-(id) parse:(FuzzyInference*)inf;
@end
 
@interface FuzzyInference : NSObject {
	FuzzyDB *_atoms;	
	FuzzyDB *_vars;	
	FuzzyDB *_numbers;	
	FuzzyDB *_compounds;	
 
	FuzzyDTree *_tree;
}
- (id) new;
- (FuzzyDTree*) tree;
-(id) parse:(InferenceADT*)adt;
- (void)accept:(FuzzyVisitor*)v;

- (id) setTree:(FuzzyDTree*)dt;
- (id) parse:(InferenceADT*)adt;
-(void)addAtom:(InferenceAtom*)a with:(FuzzyPredicate*)p;
-(void)addNumber:(InferenceNumber*)a with:(FuzzyPredicate*)p;
-(void)addVariable:(InferenceVariable*)a with:(FuzzyPredicate*)p;
-(void)addCompound:(InferenceCompound*)a with:(FuzzyPredicate*)p;
@end
 
 #endif
