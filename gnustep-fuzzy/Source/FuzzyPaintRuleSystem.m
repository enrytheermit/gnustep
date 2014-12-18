/*
   FuzzyPaintRuleSystem.m

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

#import "../Headers/Fuzzy.h"
#import "../Headers/FuzzyDB.h"
#import "../Headers/FuzzyManipulator.h"
#import "../Headers/FuzzyPaintRuleSystem.h"
#import "../Headers/FuzzyPaintParser.h"
#import "../Headers/FuzzyPredicate.h"

@implementation FuzzyPaintRuleSystem

- (id) new:(id)painter withParser:(id)parser
{
	_painter = painter;
	_parser = parser;
	return self;
}

- (void) setPaintSystem:(id)paintsystem
{
	_painter = paintsystem;
}

-(id)painter
{
	return _painter;
}

- (void) setParser:(id)parser
{
	_parser = parser;
}

-(id)parser
{
	return _parser;
}

- (void) paintOn
{
	/* NOTE : painting procedures without dispatch, use a pattern */
}

- (void) paintOn:(id)painter
{
	
}

- (void) paintIdle1SecondOn:(id)painter
{
	//thread or sleep(1);	
}

- (id) match:(FuzzyPredicate*)predicate On:(id)o
{
    NSEnumerator *enumerator = [_rules keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
	/* greedy full match rule search */
	if ([predicate rangeOfString:key].length == 0)
			continue;
	else if ([[predicate compareWithParser:[self parser] and: key] length] > 0) {
		/* if key found, perform fuzzy action and set arg with x:
		 before */
		if ([(FuzzyFunction*)[[_functions objectForKey:key] perform] x] < _threshold) { 
		//if ([[_functions objectForKey:key] perform] != nil) { 
			[self performSelector:(SEL)[_rules objectForKey:key] withObject:o];
			return key;
		}
	} else {
		return nil;
	}	
     }	
	return nil;
}	

- (id) createManipulator
{
	return [FuzzyPaintManipulator new:self];
}

- (id) createArgumentManipulator
{
	return [FuzzyScreenManipulator new:_painter];
}

- (id) createParserManipulator
{
	return [FuzzyParserManipulator new:_parser];
}

@end
