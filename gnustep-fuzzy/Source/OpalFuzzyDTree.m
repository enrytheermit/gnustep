 /*
    OpalFuzzyDecisionTree.m
 
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
 
#import "../Headers/OpalFuzzyDTree.h"
#import "../Headers/OpalFuzzyInference.h"
 
@implementation InferenceManipulator
- (id)new:(OpalFuzzyDTreeFactory*)fact
{
	_factory = fact;
}
@end

@implementation OpalFuzzyDTreeFactory
- (id)new:(OpalFuzzyInference*)inf
{
	_inference = inf;
}

- (id) makeDTree
{
	return [OpalFuzzyDTree new];
}

- (id) makeADT:(OpalFuzzyPredicate*)p with:(Class)adt
{
	InferenceADT * iadt = [[adt class] new];
	[iadt data:(id)p];
	return [[self createManipulator] parse: iadt];
} 

- (id) makeAtom:(OpalFuzzyPredicate*)p
{
	return [self makeADT:p with:@encode(InferenceAtom)];
}

- (id) makeNumber:(OpalFuzzyPredicate*)p
{
	return [self makeADT:p with:@encode(InferenceNumber)];
}

- (id) makeVar:(OpalFuzzyPredicate*)p
{
	return [self makeADT:p with:@encode(InferenceVariable)];
}

- (id) makeCompound:(OpalFuzzyPredicate*)p
{
	return [self makeADT:p with:@encode(InferenceCompound)];
}

- (id) createInferenceManipulator
{
	return [InferenceManipulator new:self];
}

@end

@implementation OpalFuzzyDTreeRoot

- (id) new
{
	[[super alloc] init]; 
	return self;
}

@end

@implementation OpalFuzzyDTreeNode

- (id) new
{
	[[super alloc] init]; 
	return self;
}

@end

@implementation OpalFuzzyDTree
- (id)init:(OpalFuzzyDTreeFactory*)factory
{
	_inference = [factory createInferenceManipulator];
	return [factory makeDTree];
} 

- (void)accept:(OpalFuzzyVisitor*)v
{
	[v visitInference: self];
}

- (void) addCompound:(InferenceCompound*)comp
{
	[comp parse:_inference]; //NOTE adds compound to _compounds DB
}

/*
 * NOTE : the Tree construction mechanism after all addX: have been done.
 */
-(id) compileToTree:(InferenceADT*)adt
{
	if ([adt isKindOfClass:[InferenceCompound class]]) {

		[self compileCompoundToTree:adt];

	}
	else if ([adt isKindOfClass:[InferenceVariable class]]) {

		[self compileVariableToTree:adt];

	}
	else if ([adt isKindOfClass:[InferenceNumber class]]) {

		[self compileNumberToTree:adt];

	}
	else if ([adt isKindOfClass:[InferenceCompound class]]) {

		[self compileAtomToTree:adt];

	}
	return self;
}	

-(id) compileCompoundToTree:(InferenceCompound*)comp
{

	return self;
}

-(id) compileVariableToTree:(InferenceVariable*)comp
{

	return self;
}

-(id) compileNumberToTree:(InferenceNumber*)comp
{

	return self;
}

-(id) compileAtomToTree:(InferenceAtom*)comp
{

	return self;
}

/* other method for compiling tree */
/******

-(id) compileDTree000
{
    NSEnumerator *enumerator = [_compounds keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
	InferenceCompound *comp = key;
	OpalFuzzyPredicate *pred = [_compounds objectForKey:key];
	[self compileCompound:pred];
    }	
}	

- (void) compileCompound:(OpalFuzzyPredicate*)pred
{
	//class check
	if ([pred isKindOfClass:[OpalFuzzyPredicate class]]) {
		unsigned int len = [pred length];
		char buffer[len];

		strncpy(buffer, [pred UTF8String]);

		if ([pred getCharacters:buffer range:NSMakeRange(0, 3)] == @"not") {
			if ([pred getCharacters:buffer range:NSMakeRange(0, 4)] == @"not ") {
			//if ([self nodeAlreadyInTree:[pred getCharacters:buffer range:NSMakeRange(4, len)]]) 
    			NSEnumerator *enumerator = [_numbers keyEnumerator];
    			id key;
    			while ((key = [enumerator nextObject])) {
				OpalFuzzyPredicate *p = [_numbers objectForKey:key];
					
			}		
		}	
	}	
}
*********/

@end
