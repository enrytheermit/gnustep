 /*
    OpalFuzzyInference.m
 
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
#import "../Headers/OpalFuzzyPredicate.h"
#import "../Headers/OpalFuzzyDB.h"
#import "../Headers/OpalFuzzyInference.h"
 
@implementation InferenceNode
-(id)new:(id)d{
	_data = d;
}
-(id)data
{
	return _data;
}
-(void)data:(id)d
{
	_data = d;
}
-(id)predicate
{
	return _predicate;
}
-(void)predicate:(OpalFuzzyPredicate*)p
{
	_predicate = p;
}
@end

@implementation InferenceADT
- (id) new:(InferenceNode*)n
{
	_node = n;
	_nodeid = -1; // FIXME #define this constant
}
@end

@implementation InferenceAtom
-(id) parse:(OpalFuzzyInference*)inf
{
	if ([[_node data] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node data] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* node predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[[_node data] UTF8String]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	[inf addAtom:_nodeid withId:[_node predicate]];	
	[inf compileToTree:self];	
	return self;
}
@end
@implementation InferenceVariable
-(id) parse:(OpalFuzzyInference*)inf
{
	if ([[_node data] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node data] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* atom predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[[_node data] UTF8string]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	[inf addVar:_nodeid withId:[_node predicate]];	
	[inf compileToTree:self];	
	return self;
}
@end
@implementation InferenceNumber
-(id) parse:(OpalFuzzyInference*)inf
{
	if ([[_node data] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node data] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* atom predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[[_node data] UTF8string]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	[inf addNumber:_nodeid withId:[_node predicate]];	
	[inf compileToTree:self];	
	return self;
}
@end
@implementation InferenceCompound
-(id) parse:(OpalFuzzyInference*)inf
{
	if ([[_node data] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node data] UTF8String] intValue];
		[_node predicate:[[_node data] UTF8String]];	
			
	} else if ([[_node data] isKindOfClass:[OpalFuzzyPredicate class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node data] UTF8String] intValue];
		[_node predicate:[[_node data] UTF8String]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	//adds compound to (cache) DB
	[inf addCompound:_nodeid withId:[_node predicate]];

	[inf compileToTree:self];	
	return self;
}
@end
 
@implementation OpalFuzzyInference 
 
-(id) new 
{
 	[[super alloc] init];
	_atoms = [OpalFuzzyDB new];	
	_vars = [OpalFuzzyDB new];	
	_numbers = [OpalFuzzyDB new];	
	_compounds = [OpalFuzzyDB new];	
	return self; 
}

- (void)accept:(OpalFuzzyVisitor*)v
{
	[v visitDTree: self];
}

-(id) setTree:(OpalFuzzyDTree*)dt
{
	_tree = dt;
	return self;
}

-(id) parse:(InferenceADT*)adt
{
	[adt parse:self]; 
	return adt;
}
-(void)addAtom:(InferenceAtom*)a with:(OpalFuzzyPredicate*)p
{
	[_atoms setObject:p forKey:a];		
}
-(void)addVar:(InferenceVariable*)a with:(OpalFuzzyPredicate*)p
{
	[_vars setObject:p forKey:a];		
}
-(void)addNumber:(InferenceNumber*)a with:(OpalFuzzyPredicate*)p
{
	[_numbers setObject:p forKey:a];		
}
-(void)addCompound:(InferenceCompound*)a with:(OpalFuzzyPredicate*)p
{
	[_compounds setObject:p forKey:a];		
}
@end
