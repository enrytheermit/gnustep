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

@implementation InferenceAtom
- (id) new:(InferenceNode*)d
{
	_atom = d;
}
-(id)node
{
	return _atom;
}
-(void) parse:(OpalFuzzyInference*)inf
{
	[inf addAtom:_atom with:[_atom predicate]];	
}
@end
@implementation InferenceVariable
- (id) new:(InferenceNode*)d
{
	_var = d;
}
-(id)node
{
	return _var;
}
@end
@implementation InferenceNumber
- (id) new:(InferenceNode*)d
{
	_number = d;
}
-(id)node
{
	return _number;
}
@end
@implementation InferenceCompound
- (id) new:(InferenceNode*)d
{
	_compound = d;
}
-(id)node
{
	return _compound;
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

-(id) parseNode:(InferenceNode*)node
{
	[node parse:self]; 
}
-(void)addAtom:(InferenceAtom*)a with:(OpalFuzzyPredicate*)p
{
	[_atoms setObject:p forKey:a];		
}
-(void)addVar:(InferenceVariable*)a with:(OpalFuzzyPredicate*)p
{
	[_atoms setObject:p forKey:a];		
}
-(void)addNumber:(InferenceNumber*)a with:(OpalFuzzyPredicate*)p
{
	[_atoms setObject:p forKey:a];		
}
-(void)addCompound:(InferenceCompound*)a with:(OpalFuzzyPredicate*)p
{
	[_atoms setObject:p forKey:a];		
}
@end
