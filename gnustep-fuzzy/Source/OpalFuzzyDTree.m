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
#import "../Headers/OpalFuzzyVisitor.h"

#import "../Headers/OpalFuzzyMACROS.h"
 
@implementation InferenceManipulator
- (id)new:(OpalFuzzyDTreeFactory*)fact
{
	_factory = fact;
	return self;
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
	InferenceADT *iadt = [[adt class] new:[InferenceNode new:p]];
	return [[self createInferenceManipulator] parse: iadt];
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
	_nodes = [OpalFuzzyDTreeNode new];
	return self;
}

-(id)searchTreeFor:(NSString*)ds
{
	return [_nodes searchTreeFor:ds];
}

@end

@implementation OpalFuzzyDTreeNode

- (id) new:(InferenceADT*)adt
{
	_adt = adt;
	return self;
}

-(id)searchTreeFor:(NSString*)ds
{
    //greedy search for node which matches ds
    NSEnumerator *enumerator = [_cons keyEnumerator];
    id val;
    while ((val = [enumerator nextObject])) {
	NSString *dds = [[[val node] adt] data];
	if (dds == ds) {
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

- (void)splitForNot:(OpalFuzzyPredicate *)p
{
	[_cons addObject:[OpalFuzzyDTreeNodeCon new:[OpalFuzzyDTreeNode new:[InferenceCompound new:[InferenceNode new:p]]]]];	
} 
- (id)adt
{
	return _adt;
}

@end
@implementation OpalFuzzyDTreeNodeCon

- (id) new:(OpalFuzzyDTreeNode*)node
{
	_node = node;
	return self;
}

-(id)node
{
	return _node;
}

@end

@implementation OpalFuzzyDTree
- (id)init:(OpalFuzzyDTreeFactory*)factory
{
	_inference = [factory createInferenceManipulator];
	_root = [OpalFuzzyDTreeRoot new];
	return [factory makeDTree];
} 

- (void)accept:(OpalFuzzyVisitor*)v
{
	[v visitDTree: self];
}

- (void) addCompound:(InferenceCompound*)comp
{
	[comp parse:_inference]; //NOTE adds compound to _compounds DB
}

-(id)searchTreeFor:(NSString*)ds
{
	return [_root searchTreeFor:ds];
}

-(id) compileCompoundToTree:(InferenceCompound*)comp
{
	/* 
	pack comp data (a string) to without spaces e.g. "not x" becomes "notx"
	*/
	OpalFuzzyPredicate *ps = (OpalFuzzyPredicate*)[[comp node] predicate]; 
	[ps stringByReplacingOccurrencesOfString:@" " withString:@""];
	if ([ps rangeOfString:NOTS].length == 3) {
		/* for speed */
		unsigned int len = [[[comp node] data] length];
		char buffer[len];

		strncpy(buffer, [ps UTF8String], [ps length]); 
		//[ps getCharacters:buffer range:NSMakeRange(3, [ps length])];
		OpalFuzzyDTreeNode *n = [self searchTreeFor:[NSString initWithCharacters:buffer length:len]];
		if (n) {
			/* FIXME kludge, old not nodes are doubled */ 
			[n splitForNot:ps];	
		}	
	}	
/***	if ([[comp data] rangeOfString:ORS] == [ORS length]) {
	}	
	if ([[comp data] rangeOfString:XORS] == [XORS length]) {
	}	
	if ([[comp data] rangeOfString:ANDS] == [ANDS length]) {
	}	
***/
	return self;
}

-(id) compileVariableToTree:(InferenceVariable*)var
{

	return self;
}

-(id) compileNumberToTree:(InferenceNumber*)num
{

	return self;
}

-(id) compileAtomToTree:(InferenceAtom*)atom
{
	if ([[atom node] data] != nil) {
		
	}
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
