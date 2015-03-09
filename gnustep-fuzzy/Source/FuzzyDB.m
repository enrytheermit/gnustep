 /*
    FuzzyDB.m
 
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
#import "../Headers/FuzzyDB.h"
 
@implementation FuzzyDB 

- (id) init { 
	if ( self = [super init] ) {
	}
	 return self; 
}

 - (void)addSelectorToDict:(NSString*)key :(SEL)pif
 {
 
	[self setObject:[NSValue valueWithPointer:pif] forKey:key];
 }

-(void)setObject:(id)value forKey:(NSString*)s
{
	[_dictionary setObject:value forKey:s];
}	
 
 - (id)getWithKey:(NSString*)key
 {
 	return [_dictionary objectForKey:key];	
 }
 
 - (id)objectForKey:(NSString*)key
 {
 	return [_dictionary objectForKey:key];	
 }
 
- (void)reinitCapacity
{
}

-(NSMutableDictionary*)dictionary
{
	return _dictionary;
}
@end
