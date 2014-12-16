/*
   OpalFuzzyManipulator.h

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

#ifndef OpalFuzzyManipulator_h_defined
#define OpalFuzzyManipulator_h_defined

#import <Foundation/Foundation.h>

@interface OpalFuzzyManipulator : NSObject
{
	id _o;
}
- (id) new:(id)o;
- (id) o;
@end

@interface OpalFuzzyArgumentManipulator : NSObject 
{
	id _o;
}
- (id) new:(id)o;
- (id) o;
@end

@interface OpalFuzzyParserManipulator : OpalFuzzyManipulator
{
}

- (id) new:(id)parser;
@end

@interface OpalFuzzyScreenManipulator : OpalFuzzyArgumentManipulator
{
}

- (id) new:(id)screen;
@end

@interface OpalFuzzyPaintManipulator : OpalFuzzyManipulator
{
}

- (id) new:(id)painter;
@end


#endif
