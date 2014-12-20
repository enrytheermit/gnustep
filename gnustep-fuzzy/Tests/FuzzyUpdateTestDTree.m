 /*
    FuzzyUpdateDecisionTree.m
 
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
 
#import "FuzzyUpdateTestDTree.h"
#import "../Headers/FuzzyPredicate.h"
#import "../Headers/FuzzyDTree.h"
#import "../Headers/FuzzyVisitor.h"
#import "../Headers/FuzzyInference.h"
 
@implementation FuzzyUpdateDTree

- (id) new
{
	return self; 
}

-(id)init:(FuzzyDTreeFactory*)fact with:(FuzzyInference*)inf
{
	_factory = fact;
	_inference = inf;
	return self;
}
- (id)makeUpdateDTree
{
	[_inference setTree:self];
	[_factory initInference:_inference];
	NSLog(@"FOO");
	FuzzyPredicate *pred = [FuzzyPredicate new];
	NSLog(@"FOO");
	[pred init:[@"not x" retain]];
	NSLog(@"FOO");
	[_factory makeCompound:pred];
	NSLog(@"FOO");
	FuzzyPredicate *pred2 = [FuzzyPredicate new];
	[pred2 init:[@"x" retain]];
	NSLog(@"FOO");
	[_factory makeAtom:pred2];

	[_inference compileTree];
	[self printTree];
	return self;
}

@end

