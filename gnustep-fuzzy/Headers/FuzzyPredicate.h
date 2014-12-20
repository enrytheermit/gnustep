 /*
    FuzzyPredicate.h
 
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
 
 #ifndef FuzzyPredicate_h_defined
 #define FuzzyPredicate_h_defined

#import <Foundation/Foundation.h>

@class FuzzyParser;
 
 @interface FuzzyPredicate : NSString {
 }
- (id)new;
- (int)length;
-(id)appendString:(NSString*)s;
- (id)init:(NSString*)s;
- (id)compareWithParser:(FuzzyParser*)parser and:(NSString*)rule;
-(void)unspacify;
- (NSRange)rangeOfString:(NSString*)s;
-(NSString*)nsstring; 
-(BOOL)searchFor:(NSString*)key;
 
@end
 
 #endif
