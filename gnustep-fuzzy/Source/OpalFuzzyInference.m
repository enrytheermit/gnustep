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
#import "../Headers/OpalFuzzyManipulator.h"
#import "../Headers/OpalFuzzyVisitor.h"
 
@implementation InferenceNode
-(id)new:(id)d{
	_data = d;
	return self;
}
-(id)data
{
	return _data;
}
-(NSString*)dataToString
{
	return [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
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
	return self;
}
-(id)node
{
	return _node;
}
-(int)nodeid
{
	return _nodeid;
}
@end

@implementation InferenceAtom
-(id) parse:(OpalFuzzyInference*)inf
{
	if ([[_node dataToString] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node dataToString] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* node predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[[OpalFuzzyPredicate alloc] initWithString:[_node dataToString]]];	
		[inf addAtom:self with:[_node predicate]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
@implementation InferenceVariable
-(id) parse:(OpalFuzzyInference*)inf
{
	if ([[_node dataToString] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node dataToString] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* atom predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[OpalFuzzyPredicate new:[_node dataToString]]];	
		[inf addVariable:self with:[_node predicate]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
@implementation InferenceNumber
-(id) parse:(OpalFuzzyInference*)inf
{
	if ([[_node dataToString] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		_nodeid = [[[_node dataToString] stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
		/* atom predicates get squeezed from "blue 0" to "blue0" */	
		[_node predicate:[OpalFuzzyPredicate new:[_node dataToString]]];	
		[inf addNumber:self with:[_node predicate]];	
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
@implementation InferenceCompound
-(id) parse:(OpalFuzzyInference*)inf
{
	if ([[_node dataToString] isKindOfClass:[NSString class]]) {
		/* FIXME ? this should make a string an integer, always */
		//_nodeid = [[[_node dataToString] UTF8String] intValue];
		//adds compound to (cache) DB
		[_node predicate:[OpalFuzzyPredicate new:[_node dataToString]]];	
		[inf addCompound:self with:[_node predicate]];
			
	} else if ([[_node data] isKindOfClass:[OpalFuzzyPredicate class]]) {
		/* FIXME ? this should make a string an integer, always */
		//_nodeid = [[[_node data] UTF8String] intValue];
		[_node predicate:[OpalFuzzyPredicate new:[_node data]]];	
		//adds compound to (cache) DB
		[inf addCompound:self with:[_node predicate]];
			
	} else {
		/* FIXME stringify [_node data] int _nodeid */
	}
	return self;
}
@end
 
@implementation OpalFuzzyInference 
 
-(id) new 
{
	_atoms = [OpalFuzzyDB new];	
	_vars = [OpalFuzzyDB new];	
	_numbers = [OpalFuzzyDB new];	
	_compounds = [OpalFuzzyDB new];	
	return self; 
}

-(OpalFuzzyDTree*)tree
{
	return _tree;
}

- (void)accept:(OpalFuzzyVisitor*)v
{
	[v visitInference: self];
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
	[_tree compileAtomToTree:a];	
}
-(void)addVariable:(InferenceVariable*)a with:(OpalFuzzyPredicate*)p
{
	[_vars setObject:p forKey:a];		
	[_tree compileVariableToTree:a];	
}
-(void)addNumber:(InferenceNumber*)a with:(OpalFuzzyPredicate*)p
{
	[_numbers setObject:p forKey:a];		
	[_tree compileNumberToTree:a];	
}
-(void)addCompound:(InferenceCompound*)a with:(OpalFuzzyPredicate*)p
{
	[_compounds setObject:p forKey:a];		
	[_tree compileCompoundToTree:a];	
}
@end
