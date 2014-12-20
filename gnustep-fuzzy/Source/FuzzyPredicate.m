 /*
    FuzzyPredicate.m
 
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

#import "../Headers/FuzzyPredicate.h"
#import "../Headers/FuzzyParser.h"
 
 @implementation FuzzyPredicate 
@synthesize stringHolder = stringHolder;
-(id)new
{
	if( (self = [super init]) ) {
    		[self initWithFormat:@""];	
	}	
	return self;
}

- (FuzzyPredicate*)initWithCharactersNoCopy:(unichar *)characters length:(NSUInteger)length freeWhenDone:(BOOL)freeBuffer {
    self = [super init];
    if (self) {
        self.stringHolder = [[NSString alloc] initWithCharactersNoCopy:characters length:length freeWhenDone:freeBuffer];
    }
    return self;
}
-(int)length
{
	return [self length];
}

-(FuzzyPredicate*)init:(NSString*)s
{
	//self = [[NSMutableString alloc] initWithString:s];
	//[self initWithFormat:s arguments:nil];	
	self.stringHolder = s; //KLUDGE FIXME
	return self;
}

-(id)appendString:(NSString*)s
{
	[self appendString:s];
	return self;
}

-(void)unspacify
{
	/////[self stringByReplacingOccurencesOfString:@" " withString:@""];
}

- (NSRange)rangeOfString:(NSString*)s
{
	return [self rangeOfString:s];
}

- (id)compareWithParser:(FuzzyParser*)parser and:(NSString*)rule
{
	return [parser compare:self with:rule];
} 

-(NSString*)nsstring
{
	return self;
}	

-(BOOL)searchFor:(NSString*)key
{
	if ([self rangeOfString:key].length == [key length]) {
		/* FIXME multiple cases count */
		return YES;
	} else {
		return NO;
	}
}

@end
