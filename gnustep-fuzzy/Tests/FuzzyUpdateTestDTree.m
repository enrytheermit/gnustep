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

- (id) new:(FuzzyDTreeFactory*)fact
{
	_factory = fact;
	return self; 
}

//another example :
	//FuzzyInference *inf = [FuzzyInference new];
	//FuzzyDTree *dtree = [_factory makeDTree];
- (id)makeUpdateDTree
{
	FuzzyInference *inf = [FuzzyInference new];
	FuzzyDTree *dtree = [FuzzyDTree new];
	FuzzyConstructVisitor *visi = [FuzzyConstructVisitor new];
	[dtree accept:visi];
	[inf accept:visi];
	FuzzySetVisitor *visiset = [FuzzySetVisitor new];
	[dtree accept:visiset];
	[inf accept:visiset];
	//make predicates which is an NSString
	//initialize it with a string which in this case is multi-worded
	FuzzyPredicate *pred = [[FuzzyPredicate alloc] initWithString:@"update full window"];
	
	//so it becomes a compound, which gets parsed and 
	//adds comp to _compound DB in _inference ([fact createInferenceManipulator])
	[_factory makeCompound:pred];

	return dtree;
}

@end

