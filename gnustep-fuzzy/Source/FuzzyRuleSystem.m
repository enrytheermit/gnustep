/*
   FuzzyRuleSystem.m

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
#import "../Headers/FuzzyPredicate.h"
#import "../Headers/FuzzyDB.h"
#import "../Headers/FuzzyManipulator.h"
#import "../Headers/FuzzyRuleSystem.h"


@implementation FuzzyRuleSystem

- (id) new
{
	_threshold = 0.001;
	_rules = [FuzzyDB new]; 
	_functions = [FuzzyDB new]; 
	return self;
}

- (void) addRule:(NSString*)r with:(SEL)s
{
	[_rules reinitCapacity];	
	[_rules addSelectorToDict:r :s];
}

- (void) addFunction:(NSString*)r with:(FuzzyFunction*)f
{
	[_functions reinitCapacity];	
	[_functions addObjectToDict:r :f];
}

-(void) parseFor:(FuzzyPredicate*)predicate On:(id)o
{
	[self match:predicate On:o];
}

- (id) match:(FuzzyPredicate*)predicate On:(id)o
{
    NSEnumerator *enumerator = [_rules keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
	/* greedy full match rule search */
	if ([[predicate string] rangeOfString:key].length == 0)
			continue;
	else if ([[predicate string] rangeOfString: key].length > 0) {
		/* if key found, perform fuzzy action on f(x) with x = 0 */
		if ([[[_functions objectForKey:key] perform] x] < _threshold) { 
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
	return [FuzzyManipulator new:self];
}

- (id) createArgumentManipulator
{
	return [FuzzyArgumentManipulator new:self];
}

- (id) createParserManipulator
{
	return [FuzzyManipulator new:self];
}
@end
