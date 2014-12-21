 /*
    FuzzyInference.m
 
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
#import "../Headers/FuzzyPredicate.h"
#import "../Headers/FuzzyPredicateSet.h"
#import "../Headers/FuzzyDB.h"
#import "../Headers/FuzzyInference.h"
#import "../Headers/FuzzyManipulator.h"
#import "../Headers/FuzzyDTree.h"
#import "../Headers/FuzzyVisitor.h"
 
@implementation InferenceNode
-(id)new
{
	return self;
}

-(id)initNode:(FuzzyPredicate*)p{
	_data = nil;
	_predicate = p;
	return self;
}
-(id)data
{
	return _data;
}
-(NSString*)dataToString
{
	NSLog(@"dataToString");
	return [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
}
-(void)data:(id)d
{
	_data = d;
}
-(FuzzyPredicate*)predicate
{
	return _predicate;
}
-(FuzzyPredicate*)pred
{
	return _predicate;
}
-(void)predicate:(FuzzyPredicate*)p
{
	_predicate = p;
}
@end

@implementation InferenceADT
- (id) new
{
	return self;
}
-(id)node
{
	return _node;
}
-(void)node:(InferenceNode*)n
{
	_node = n;
}
-(int)nodeid
{
	return _nodeid;
}
-(void)nodeid:(int)n
{
	_nodeid = n;
}
-(id) parse:(FuzzyInference*)inf
{
	NSLog(@"InferenceADT subclass responsibility");
	return self;
}
@end

@implementation InferenceAtom
-(id) parse:(FuzzyInference*)inf
{
	//////if ([[_node predicate] isKindOfClass:[FuzzyPredicate class]]) {
	NSLog(@"Atom");//"Parsing InferenceCompound as FuzzyPredicate: %@", [[self node] predicate]);
	[inf addAtom:self with:[[self node] pred]];
	return self;
}
@end
@implementation InferenceVariable
-(id) parse:(FuzzyInference*)inf
{
	if ([[_node pred] isKindOfClass:[FuzzyPredicate class]]) {
		NSLog(@"Parsing InferenceVariable as FuzzyPredicate: %@", [[_node pred] UTF8String]);
		[inf addVariable:self with:[[self node] pred]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
@implementation InferenceNumber
-(id) parse:(FuzzyInference*)inf
{
	if ([[_node pred] isKindOfClass:[FuzzyPredicate class]]) {
		NSLog(@"Parsing InferenceNumber as FuzzyPredicate: %@", [[_node pred] UTF8String]);
		[inf addNumber:self with:[[self node] pred]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
@implementation InferenceCompound
- (id) new
{
	self = [super new];
	return self;
}
-(id) parse:(FuzzyInference*)inf
{
	/////if ([[_node pred] isKindOfClass:[NSString class]]) {
	NSLog(@"BAR");//"Parsing InferenceCompound as FuzzyPredicate: %@", [[self node] pred]);
	[inf addCompound:self with:[[self node] pred]];
	return self;
}
@end
 
@implementation FuzzyInference 
 
-(id) new 
{
	return self; 
}

-(id) init:(int)caps
{
	_atoms = [FuzzyDB new];	
	[_atoms initDB];	
	_vars = [FuzzyDB new];	
	[_vars initDB];	
	_numbers = [FuzzyDB new];	
	[_numbers initDB];	
	_compounds = [FuzzyDB new];	
	[_compounds initDB];
	_threshold = 0.01;	
	//_tree = nil;
	NSLog(@"Constructed inference engine");
	return self;
}

-(FuzzyDTree*)tree
{
	return _tree;
}

- (void)accept:(FuzzyVisitor*)v
{
	[v visitInference: self];
}

-(id) setTree:(FuzzyDTree*)dt
{
	_tree = dt;
	return self;
}

-(id) parse:(InferenceADT*)adt
{
	NSLog(@"Parsing ADT..");
	[adt parse:self]; 
	return adt;
}
-(void)addAtom:(id)a with:(FuzzyPredicate*)p
{
	[_atoms setObject:a forKey:[p nsstring]];		
	NSLog(@"Added atom to rules DB");
	//[_tree compileAtomToTree:a];	
}
-(void)addVariable:(InferenceVariable*)a with:(FuzzyPredicate*)p
{
	[_vars setObject:a forKey:[p nsstring]];		
	//[_tree compileVariableToTree:a];	
}
-(void)addNumber:(InferenceNumber*)a with:(FuzzyPredicate*)p
{
	[_numbers setObject:a forKey:[p nsstring]];		
	//[_tree compileNumberToTree:a];	
}
-(void)addCompound:(id)a with:(FuzzyPredicate*)p
{
	NSLog(@"Init Added compound to rules DB");
	[_compounds setObject:a forKey:[p nsstring]];		
	//[_tree compileCompoundToTree:a];	
	NSLog(@"Added compound to rules DB");
}

-(void)compileTree
{
	NSLog(@"Compiling Tree...");
    /*
     * construct weights i.e. count / numberOfAtoms
     */
	NSMutableArray *weights = [self weightAtoms];	
	FuzzyDTreeNode *rn;
    /*
     * Atoms with the biggest weight in compounds get put at
     * the fore of the connections in the treeroot node
     */
	CGFloat max = 0.0;
	int idx = 0;
	int i;
	/* root atom predicate is at front of array, start from 1 not 0 */
	for (i = 1; i < [weights count]; i++) {
		if ([[weights objectAtIndex:i] intValue] > max) {
			max = [[weights objectAtIndex:i] floatValue];
			idx = i;
		}
		i++;
	}
	rn = [[FuzzyDTreeNode new] initADT:[[_atoms dictionary] objectForKey:
		[weights objectAtIndex:0]]]; 
    	[weights removeObjectAtIndex:idx];
	/* atom predicate is at front of array */
    	NSEnumerator *enumerator = [[_atoms dictionary] keyEnumerator];
    	id atomp;
	FuzzyDTreeNode *n = rn;
    	while ((atomp = [enumerator nextObject])) {
		FuzzyDTreeNode *n2 = [[FuzzyDTreeNode new] initADT:[[_atoms dictionary] objectForKey:atomp]];
		max = 0.0;
		idx = 0.0;
		/* root atom predicate is at front of array, start from 1 not 0 */
		for (i = 1; i < [weights count]; i++) {
			if ([[weights objectAtIndex:i] intValue] > max) {
				max = [[weights objectAtIndex:i] floatValue];
				idx = i;
			}
			i++;
		}
    		[weights removeObjectAtIndex:idx];
		[n addNode:n2];//gives the root node's node a connection with n at the end	
   		n = n2;
	} 
    
	[_tree addToRootNode:rn];//adds the root node a connection with n at the end	
  

	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[_compounds dictionary]];
	FuzzyPredicateSet *set = [FuzzyPredicateSet new];
	NSMutableDictionary *entropies = [[NSMutableDictionary alloc] init]; 
 	NSEnumerator *cenumerator = [dict keyEnumerator];
    	id compp;
    	while ((compp = [cenumerator nextObject])) {
	  	NSEnumerator *cenumerator2 = [dict keyEnumerator];
    		id compp2;
		// create a set
		int i = 0;
		//choose lower and upper bound to choose entropy function values
		int lowerBound = arc4random() % [dict count];
		int upperBound = arc4random() % [dict count];
		int rnd = lowerBound + arc4random() % (upperBound - lowerBound);
    		while ((compp2 = [cenumerator2 nextObject])) {
			if (i >= rnd) break;
			if (arc4random() % 1 == 0 && i++)
				[set addObject:compp2];	
		}
		//generate the entropy for this set of classes and pack
		NSNumber *ee = [NSNumber numberWithFloat:[set entropyForAtoms:[_atoms dictionary]]];
		[entropies setObject:set forKey:ee];
		[dict removeObjectForKey:compp];	
 		cenumerator = [dict keyEnumerator];
	}
 	NSEnumerator *eenumerator = [entropies keyEnumerator];
    	id eatoms;
    	while ((eatoms = [eenumerator nextObject])) {
		//search for an entropy ~= 0
		if ([eatoms floatValue] < _threshold) {
			FuzzyPredicateSet *sett = [entropies objectForKey:eatoms];	
			for (FuzzyPredicate*fp in [sett set])
				//compile in compounds in the set with above 
				//entropy
				[_tree compileCompoundToTree:[[_compounds dictionary] objectForKey:fp]];
			
			}
	}
	
}

-(NSMutableArray*)weightAtoms
{
	int natoms = [[_atoms dictionary] count];
	NSMutableArray *weights = [[NSMutableArray alloc] init];
    	NSEnumerator *enumerator = [[_compounds dictionary] keyEnumerator];
    	id compoundkey;
	int idx = 0;
    	while ((compoundkey = [enumerator nextObject])) {
    		NSEnumerator *enumerator2 = [[_atoms dictionary] keyEnumerator];
    		id atomkey;
		int wn = 0;
		/* insert atom predicate at head of array */
		[weights insertObject:atomkey atIndex:idx];
    		while ((atomkey = [enumerator2 nextObject])) {
			if ([[compoundkey pred] searchFor:atomkey]) {
				wn++;	
			}		
		}
		[weights insertObject:[NSNumber numberWithFloat:wn / natoms] atIndex:idx++];
	}
	return weights;
}
@end
