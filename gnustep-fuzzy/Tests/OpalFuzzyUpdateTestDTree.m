 /*
    OpalFuzzyUpdateDecisionTree.m
 
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
 
#import "OpalFuzzyUpdateTestDTree.h"
#import "../Headers/OpalFuzzyPredicate.h"
#import "../Headers/OpalFuzzyDTree.h"
#import "../Headers/OpalFuzzyVisitor.h"
#import "../Headers/OpalFuzzyInference.h"
 
@implementation OpalFuzzyUpdateDTree

- (id) new:(OpalFuzzyDTreeFactory*)fact
{
	_factory = fact;
	return self; 
}

//another example :
	//OpalFuzzyInference *inf = [OpalFuzzyInference new];
	//OpalFuzzyDTree *dtree = [_factory makeDTree];
- (id)makeUpdateDTree
{
	OpalFuzzyInference *inf = [OpalFuzzyInference new];
	OpalFuzzyDTree *dtree = [OpalFuzzyDTree new];
	OpalFuzzyConstructVisitor *visi = [OpalFuzzyConstructVisitor new];
	[inf accept:visi];
	[dtree accept:visi];
	OpalFuzzySetVisitor *visiset = [OpalFuzzySetVisitor new];
	[inf accept:visiset];
	[dtree accept:visiset];
	//make predicates which is an NSString
	//initialize it with a string which in this case is multi-worded
	OpalFuzzyPredicate *pred = [[OpalFuzzyPredicate alloc] initWithString:@"update full window"];
	
	//so it becomes a compound, which gets parsed and 
	//adds comp to _compound DB in _inference ([fact createInferenceManipulator])
	[_factory makeCompound:pred];

	return dtree;
}

@end

