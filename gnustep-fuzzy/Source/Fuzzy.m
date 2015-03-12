 /*
    Fuzzy.m
 
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
 
 @implementation FuzzyFunction
 
- (id) init { 
	if ( self = [super init] ) {
		pf = nil;
	}
	 return self; 
}

 - (id)initFunc:(SEL)pif
 {
 	pf = pif;
 	x = .0;	
 	return self;
 } 
 
 -(id)perform:(CGFloat)c
 {
	x = c;
 	return [self performSelector:pf];
 }
 
 -(id)perform
 {
 	return [self performSelector:pf];
 }
 
 - (CGFloat)x
 {
 	return x;
 }
 
 - (void)x:(CGFloat)xx
 {
 	x = xx;
 }
 
 - (SEL)sel
 {
	return pf;
 }
 @end
 
 @implementation FuzzyFunctionLittle
 
 -(CGFloat) littlef
 {
 	return sqrt(x) / 1.3;
 }
 
 -(id) new 
 {
 	[self initFunc:@selector(littlef)];
	return self; 
}
 
 @end
 
 @implementation FuzzyFunctionSlightly
 
 -(CGFloat) slightlyf
 {
 	return sqrt(x) / 1.7;
 }
 
 -(id) new 
 {
 	[self initFunc:@selector(slightlyf)];
	return self; 
 }
 
 @end
 
 @implementation FuzzyFunctionVery
 
 -(CGFloat) veryf
 {
 	return x * x;
 }
 
 -(id) new 
 {
 	[self initFunc:@selector(veryf)];
	return self; 
 }
 
 @end
 
 @implementation FuzzyFunctionExtremely
 
 -(CGFloat) extremelyf
 {
 	return x * x * x;
 }
 
 -(id) new 
 {
 	[self initFunc:@selector(extremelyf)];
	return self; 
 }
 
 @end
 
 @implementation FuzzyFunctionVeryVery
 
 -(CGFloat) veryveryf
 {
 	return x * x * x * x;
 }
 
 -(id) new 
 {
 	[self initFunc:@selector(veryveryf)];
	return self; 
 }
 
 @end
 
 @implementation FuzzyFunctionMoreorLess
 
 -(CGFloat) moreorlessf
 {
 	return sqrt(x);
 }
 
 -(id) new 
 {
 	[self initFunc:@selector(moreorlessf)];
	return self; 
 }
 
 @end
 
 @implementation FuzzyFunctionIndeed
 
 -(CGFloat) indeedf
 {
 	return 2 * x * x;
 }
 
 -(id) new 
 {
 	[self initFunc:@selector(indeedf)];
	return self; 
 }
 
 @end
 
 @implementation FuzzyFunctionIdle
 
 -(CGFloat) idlef
 {
 	return .0; //IDLEVALUE(x);
 }
 
 -(id) new 
 {
 	[self initFunc:@selector(idlef)];
	return self; 
 }
 
 @end
 
 
