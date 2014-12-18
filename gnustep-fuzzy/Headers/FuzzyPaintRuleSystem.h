/*
   FuzzyPaintRuleSystem.h

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

#ifndef FuzzyPaintRuleSystem_h_defined
#define FuzzyPaintRuleSystem_h_defined

#import <Foundation/Foundation.h>
#import "FuzzyRuleSystem.h"

@class FuzzyRuleSystem;
@class FuzzyParser;
@class FuzzyPredicate;

@interface FuzzyPaintRuleSystem : FuzzyRuleSystem 
{
@private
	id _painter;
	id _parser;
}
- (id) new:(id)painter withParser:(id)parser;
- (void)setPaintSystem:(id)paintsystem;
- (id)painter;
- (void)setParser:(id)parser;
- (id)parser;
- (void)paintOn;

- (void)paintOn:(id)painter;
- (void)paintIdle1SecondOn:(id)painter;


- (id) match:(FuzzyPredicate*)predicate On:(id)o;
/*
 * NOTE :
 * Call the createManipulator method and you can paint on this
 * painter system with rules from the super class.

 * The PaintManipulator then hashes the method paintOn: in the dictionary
 * and paints on the _painter of the dispatched class due to a call
 * of e.g. parseFor:"paint extremely". 
 *
 * The super class parseFor:On: method can also be used as a rule (rules have
 * a NSString key and a SEL in the form of performSelector:withObject:, so
 * only a single argument.
 */ 
- (id) createManipulator;
- (id) createArgumentManipulator;
- (id) createParserManipulator;

@end

#endif
