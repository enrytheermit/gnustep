/*
   OpalFuzzyMatrix.m

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

#import "../Headers/OpalFuzzyMatrix.h"

@implementation OpalFuzzyMatrix

- (id) new
{
	[[super alloc] init];

	_w = 1;
	_h = 1;
	typedef struct {
		EVAL(REPEAT(1,MAKEMatrixElement,1))
	} _OpalMatrix;
	_matrix = (_OpalMatrix*)[_matrix alloc];

	return self;
}

/* FIXME broken */
- (id) setWidth:(int)w height:(int)h
{
       _w = w;
       _h = h;

	if (w > 0 && h > 0) {
	typedef struct {
		/* FIXME EVAL(REPEAT(w,MAKEMatrixElement,h)) */
		EVAL(REPEAT(1,MAKEMatrixElement,1))
	} _OpalMatrix;
	_matrix = (_OpalMatrix*)[_matrix alloc];
	} else {
		NSLog(@"Could not typedef matrix structure as width or height is <= 0, _matrix width==1  and height==1 from new, returning nil");
		return nil;
	}
	
	return self;	
}

- (BOOL)hasDimensionsBeenSet:(BOOL)b
{
       if (!b) {
               if (_w <= 0 || _h <= 0) {
                       [self calibrateDimensions];
                       return NO;
               } else {
                       return YES;
               }
       } else {
               if (_w <= 0 || _h <= 0) {
                       [self calibrateDimensions];
                       return NO;
               } else {
                       return YES;
               }

       }
}

// private methods

- (void) calibrateDimensions
{
       /* FIXME */
       /***
       _w = 1;
       _h = 1;
	typedef struct {
		EVAL(REPEAT(1,MAKEMatrixElement,1))
	} _OpalMatrix;
	_matrix = (_OpalMatrix*)[_matrix alloc];

	***/

}

@end
