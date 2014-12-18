 /*
    FuzzyUpdateDecisionTree.h
 
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
    Boston, MA 021101301, USA.
 */
 
#ifndef FuzzyUpdateDTree_h_defined
#define FuzzyUpdateDTree_h_defined

#import <Foundation/Foundation.h>
@class FuzzyPredicate;
@class FuzzyDTreeFactory;

@interface FuzzyUpdateDTree
{
	FuzzyDTreeFactory *_factory;
}
- (id) new:(FuzzyDTreeFactory*)fact;
- (id) makeUpdateDTree;
@end
#endif
