#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
/*
Copyright (C) 2013 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

//typedef int[] 

//you can also use memcpy and friends for storing struct data in symboltables
@interface Xpm : NSObject 
{
    int row, col, ncolors;
    //color symbols (characters) sorted as encounteredf in xpm file data
    int *symboltable;//256 colors
    char *symboldata;
}

- (id)initWithRogueCharacter;
- (id)init:(char *[])xpmfiledata;
- (char *)getWord:(char *)linedata atIndex:(int*)idx;
- (void)skipChar:(char)cd data:(char *)data atIndex:(int*)idx;
- (int)hexStringToNumber:(char *)hexstr;
- (void)addColorSymbol:(char)symbol Color:(int)color atIndex:(int)i;
- (int)getColor:(char)symbol;
- (char*)getSymbolData;
- (int)row;
- (int)col;
- (int)ncolors;
- (void)setRow:(int)r;
- (void)setCol:(int)c;
- (void)setNColors:(int)nc;

@end

