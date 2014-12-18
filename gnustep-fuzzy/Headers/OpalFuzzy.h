 /*
    OpalFuzzy.h
 
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
 
 #ifndef OpalFuzzy_h_defined
 #define OpalFuzzy_h_defined
#import <Foundation/Foundation.h>

/*#define IDLEVALUE(x)\
	return 0
*/
 
 @interface OpalFuzzyFunction : NSObject {
 	SEL pf;
 	CGFloat x;
 }
- (id) new:(SEL) pif; 
- (id)perform:(CGFloat)c;
- (id)perform;
- (CGFloat)x;
- (void)x:(CGFloat)xx;
- (SEL)sel;
 @end
 
 @interface OpalFuzzyFunctionLittle : OpalFuzzyFunction {
 }
 - (id) new; 
 @end
 @interface OpalFuzzyFunctionSlightly : OpalFuzzyFunction {
 }
  -(id) new; 
 @end
 @interface OpalFuzzyFunctionVery : OpalFuzzyFunction {
 }
  -(id) new; 
 @end
 @interface OpalFuzzyFunctionExtremely : OpalFuzzyFunction {
 }
  -(id) new; 
 @end
 @interface OpalFuzzyFunctionVeryVery : OpalFuzzyFunction {
 }
  -(id) new; 
 @end
 @interface OpalFuzzyFunctionMoreorLess : OpalFuzzyFunction {
 }
  -(id) new; 
 @end
 @interface OpalFuzzyFunctionSomewhat : OpalFuzzyFunction {
 }
  -(id) new; 
 @end
 @interface OpalFuzzyFunctionIndeed : OpalFuzzyFunction {
 }
  -(id) new; 
 @end
 @interface OpalFuzzyFunctionIdle : OpalFuzzyFunction {
 }
  -(id) new; 
 @end
 
 @interface OpalFuzzy : NSObject {
 	
 }
 
 
 @end
 
 #endif
