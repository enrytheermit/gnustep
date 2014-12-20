#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "Views.h"
#import "Character.h"
#import "Xpm.h"
/*
Copyright (C) 2013-2014 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

@interface Controller : NSObject
{
    NSWindow *window;
    NSTextField *timeField, *markField;
    Square *fields[SIZEW][SIZEH];

    TILE_STATE map[SIZEW][SIZEH];
    TILE_STATE prevTileState;//FIXME make array
    Character *character;

    Xpm *xpmcharacter;

    int untileState;

    BOOL atStart;
    NSDate *startDate;
}

- (int)getCharacterX;
- (int)getCharacterY;

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;

- makeGameWindow;

- newGame:(id)sender;

- uncoverRegion:(Square *)item;

- uncoverAll:(Square *)item;

- untileState:(Square *)item;
- marked:(Square *)item;
- (int)markCount;

- start;
- tick;

- (void)genMap;
- (void)printMap;
- (void)genCharacterOnMapRow:(int)rr Col:(int)cc;

- (char *)getCharacterXpmData;

- (void)setCharacterX:(int)r;
- (void)setCharacterY:(int)c;

@end


