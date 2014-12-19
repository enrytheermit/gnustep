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
#import "../Headers/FuzzyDB.h"
#import "../Headers/FuzzyInference.h"
#import "../Headers/FuzzyManipulator.h"
#import "../Headers/FuzzyVisitor.h"
 
@implementation InferenceNode
-(id)new
{
	return self;
}

-(id)init:(FuzzyPredicate*)p{
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
@end

@implementation InferenceAtom
-(id) parse:(FuzzyInference*)inf
{
	//////if ([[_node predicate] isKindOfClass:[FuzzyPredicate class]]) {
	NSLog(@"Atom");//"Parsing InferenceCompound as FuzzyPredicate: %@", [[self node] predicate]);
	[inf addAtom:self with:[[self node] predicate]];
	return self;
}
@end
@implementation InferenceVariable
-(id) parse:(FuzzyInference*)inf
{
	if ([[_node predicate] isKindOfClass:[FuzzyPredicate class]]) {
		NSLog(@"Parsing InferenceVariable as FuzzyPredicate: %@", [[_node predicate] UTF8String]);
		[inf addVariable:self with:[[self node] predicate]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
@implementation InferenceNumber
-(id) parse:(FuzzyInference*)inf
{
	if ([[_node predicate] isKindOfClass:[FuzzyPredicate class]]) {
		NSLog(@"Parsing InferenceNumber as FuzzyPredicate: %@", [[_node predicate] UTF8String]);
		[inf addNumber:self with:[[self node] predicate]];	
			
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
	/////if ([[_node predicate] isKindOfClass:[NSString class]]) {
	NSLog(@"BAR");//"Parsing InferenceCompound as FuzzyPredicate: %@", [[self node] predicate]);
	[inf addCompound:self with:[[self node] predicate]];
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
	_atoms = [FuzzyDB allocDB];	
	_vars = [FuzzyDB allocDB];	
	_numbers = [FuzzyDB allocDB];	
	_compounds = [FuzzyDB allocDB];	
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
    NSEnumerator *enumerator = [_atoms keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
	[_tree addNode:[_atoms objectForKey:key]];	
    }	
}

@end
