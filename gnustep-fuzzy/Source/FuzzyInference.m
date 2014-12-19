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
	if ([[_node dataToString] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node dataToString] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* node predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[[FuzzyPredicate alloc] initWithString:[_node dataToString]]];	
		[inf addAtom:self with:[_node predicate]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
@implementation InferenceVariable
-(id) parse:(FuzzyInference*)inf
{
	if ([[_node dataToString] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node dataToString] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* atom predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[FuzzyPredicate new:[_node dataToString]]];	
		[inf addVariable:self with:[_node predicate]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
@implementation InferenceNumber
-(id) parse:(FuzzyInference*)inf
{
	if ([[_node dataToString] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node dataToString] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* atom predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[FuzzyPredicate new:[_node dataToString]]];	
		[inf addNumber:self with:[_node predicate]];	
			
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
	if ([[_node predicate] isKindOfClass:[FuzzyPredicate class]]) {
		//adds compound to (cache) DB
		NSLog(@"Parsing InferenceCompound as FuzzyPredicate: %s", [[[_node predicate] string] UTF8String]);
		[inf addCompound:self with:[[self node] predicate]];
	} else if ([[_node data] isKindOfClass:[FuzzyPredicate class]]) {
		//adds compound to (cache) DB
		NSLog(@"Parsing InferenceCompound as Predicate: %s", [[[_node predicate] string] UTF8String]);
		[inf addCompound:self with:[[self node] predicate]];
	} else {
	}

	return self;
}
@end
 
@implementation FuzzyInference 
 
-(id) new 
{
	_atoms = [FuzzyDB new];	
	_vars = [FuzzyDB new];	
	_numbers = [FuzzyDB new];	
	_compounds = [FuzzyDB new];	
	_tree = nil;
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
	[adt parse:self]; 
	return adt;
}
-(void)addAtom:(InferenceAtom*)a with:(FuzzyPredicate*)p
{
	[_atoms setObject:p forKey:a];		
	[_tree compileAtomToTree:a];	
}
-(void)addVariable:(InferenceVariable*)a with:(FuzzyPredicate*)p
{
	[_vars setObject:p forKey:a];		
	[_tree compileVariableToTree:a];	
}
-(void)addNumber:(InferenceNumber*)a with:(FuzzyPredicate*)p
{
	[_numbers setObject:p forKey:a];		
	[_tree compileNumberToTree:a];	
}
-(void)addCompound:(InferenceCompound*)a with:(FuzzyPredicate*)p
{
	[_compounds setObject:p forKey:a];		
	[_tree compileCompoundToTree:a];	
	NSLog(@"Compiling compound done.");
}
@end
