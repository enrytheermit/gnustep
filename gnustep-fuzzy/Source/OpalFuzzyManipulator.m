/*
   OpalFuzzyManipulator.m

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

#import "../Headers/OpalFuzzyManipulator.h"


@implementation OpalFuzzyParserManipulator

- (id) new:(id)parser
{
	[super new];
	_o = parser; 
	return self;
}

@end

@implementation OpalFuzzyScreenManipulator

- (id) new:(id)screen
{
	[super new];
	_o = screen; 
	return self;
}

@end

@implementation OpalFuzzyArgumentManipulator

- (id) new:(id)o
{
	[[super alloc] init];
	_o = o;
	return self;
}

- (id)o
{
	return _o;
}
@end

@implementation OpalFuzzyPaintManipulator

- (id) new:(id)painter
{
	[super new];
	_o = painter;
	return self;
}

@end

@implementation OpalFuzzyManipulator

- (id) new:(id)o
{
	[[super alloc] init];
	_o = o;
	return self;
}

- (id)o
{
	return _o;
}
@end