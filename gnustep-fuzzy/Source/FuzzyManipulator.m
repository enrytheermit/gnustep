/*
   FuzzyManipulator.m

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

#import "../Headers/FuzzyManipulator.h"
#import "../Headers/FuzzyDTree.h"

@implementation InferenceManipulator
@end
@implementation FuzzyParserManipulator

- (id) init { 
	if ( self = [super init] ) {
		_o = nil;
	}
	 return self; 
}
- (FuzzyParserManipulator*) initM:(id)o
{
	_o = o;
	return self;
}
@end

@implementation FuzzyScreenManipulator

- (id) new
{
	return self;
}
- (FuzzyScreenManipulator*) initM:(id)o
{
	_o = o;
	return self;
}

@end

@implementation FuzzyArgumentManipulator

- (id) new
{
	return self;
}
- (FuzzyArgumentManipulator*) initM:(id)o
{
	o = _o;
	return self;
}

- (NSObject*)o
{
	return _o;
}
@end

@implementation FuzzyPaintManipulator

- (id) new
{
	return self;
}
- (FuzzyPaintManipulator*) initM:(id)o
{
	o = _o;
	return self;
}
@end

@implementation FuzzyManipulator

- (id) new
{
	return self;
}
- (FuzzyManipulator*) initM:(id)o
{
	_o = o;
	return self;
}

- (NSObject*)o
{
	return _o;
}
@end
