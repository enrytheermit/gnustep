 /*
    Fuzzy.h
 
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
 
 #ifndef Fuzzy_h_defined
 #define Fuzzy_h_defined
#import <Foundation/Foundation.h>

/*#define IDLEVALUE(x)\
	return 0
*/
 
 @interface FuzzyFunction : NSObject {
 	SEL pf;
 	CGFloat x;
 }
+ (id) new:(SEL) pif; 
- (id)perform:(CGFloat)c;
- (id)perform;
- (CGFloat)x;
- (void)x:(CGFloat)xx;
- (SEL)sel;
 @end
 
 @interface FuzzyFunctionLittle : FuzzyFunction {
 }
 - (id) new; 
 @end
 @interface FuzzyFunctionSlightly : FuzzyFunction {
 }
  -(id) new; 
 @end
 @interface FuzzyFunctionVery : FuzzyFunction {
 }
  -(id) new; 
 @end
 @interface FuzzyFunctionExtremely : FuzzyFunction {
 }
  -(id) new; 
 @end
 @interface FuzzyFunctionVeryVery : FuzzyFunction {
 }
  -(id) new; 
 @end
 @interface FuzzyFunctionMoreorLess : FuzzyFunction {
 }
  -(id) new; 
 @end
 @interface FuzzyFunctionSomewhat : FuzzyFunction {
 }
  -(id) new; 
 @end
 @interface FuzzyFunctionIndeed : FuzzyFunction {
 }
  -(id) new; 
 @end
 @interface FuzzyFunctionIdle : FuzzyFunction {
 }
  -(id) new; 
 @end
 
 @interface Fuzzy : NSObject {
 	
 }
 
 
 @end
 
 #endif
