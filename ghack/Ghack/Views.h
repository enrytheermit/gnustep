#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#include "MonsterInfo.h"

/*
Copyright (C) 2013 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

#define DIMENSION   16 

#define SEPARATOR    0
#define MARGIN       0 
#define SIZEW		30	
#define SIZEH	        30	

typedef enum {
    TILE_GREENGRASS1 = 0,
    TILE_GREENGRASS2 = 10,
    TILE_WALL1 = 20,
    TILE_BLANK = 30,
    TILE_CHARACTER = 40,
	__struct_MonsterTypeInfo = 50,
    TILE_CLICKED = 1000
} TILE_STATE;

@interface Square : NSView
{
    int row, col;

    BOOL isMine;
    int neighbors;
    TILE_STATE tileState;
    BOOL marked;

    id con;
}

- initAtPoint:(NSPoint)aPoint row:(int)rval col:(int)cval tileType:(TILE_STATE)tileType controller:(id)theCon;

- (int)row;
- (int)col;

- setDefaults;
- setWall;
- setGrass1;

- setMine:(BOOL)flag;
- setNeighbors:(int)count;
- setTileState:(TILE_STATE)aState;
- setMarked:(BOOL)flag;

- (BOOL)mine;
- (int)neighbors;
- (TILE_STATE)tileState;
- (BOOL)marked;

- (void)drawRect:(NSRect)aRect;

- (void)keyDown:(NSEvent *)theEvent;
- (void)mouseDown:(NSEvent *)theEvent;
- (void)rightMouseDown:(NSEvent *)theEvent;

- (void)drawTileGrass1;
- (void)drawTileGrass2;
- (void)drawRogueCharacter;
- (int) extractRed:(int)rgb; 
- (int) extractGreen:(int)rgb; 
- (int) extractBlue:(int)rgb; 

@end

