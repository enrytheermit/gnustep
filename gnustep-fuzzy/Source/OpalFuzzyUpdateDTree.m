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
 
#import "../Headers/OpalFuzzyUpdateDTree.h"
 
@implementation OpalFuzzyUpdateDTree

- (id) new
{
	[[super alloc] init]; 
}

- (id)makeUpdateDTreeWithFactory:(OpalFuzzyDTreeFactory*)fact
{
	OpalFuzzyDTree *dtree = [fact makeDTree];

	//make predicates which is an NSString
	OpalFuzzyPredicate *pred = [[OpalFuzzyPredicate alloc] init];
	//initialize it with a string which in this case is multi-worded
	[pred initWithString:@"update full window";
	
	//so it becomes a compound
	//adds comp to _compound DB in _inference ([fact createInferenceManipulator])
	InferenceCompound *comp = [fact makeCompound:pred];
}

@end

