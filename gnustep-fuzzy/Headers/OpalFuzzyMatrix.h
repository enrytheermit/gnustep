/*
   OpalFuzzyMatrix.h

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

#ifndef OpalFuzzyMatrix_h_defined
#define OpalFuzzyMatrix_h_defined

#define MAKEMatrixElement(i,j) \
	OpalFuzzyNode * c ## #i#j;

/* FIXME extra handle or not */
#define MAKEMatrix(w, h) \
	typedef struct {
		for (int i = 0; i < h; i++) \
			for (j = 0; j < w; j++) \
				makeMatrixElement(i,j) \
} _OpalMatrix;		

@class _OpalMatrix;

@interface OpalFuzzyMatrix : NSObject {
	long int _w,_h;
	_OpalMatrix *_matrix;	
}

- (id) new;
- (id)setWidth:(long int)w height:(long int)h;
- (BOOL)hasDimensionsBeenSet:(BOOL)b;
- (void) calibrateDimensions;
 
@end

#endif
