/*
Copyright (C) 2013 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

#import "Views.h"
#import "Controller.h"

#include <stdio.h>

@implementation Square

- initAtPoint:(NSPoint)aPoint row:(int)rval col:(int)cval tileType:(TILE_STATE)tileType controller:(id)theCon
{
    NSRect frame;

    frame.origin = aPoint;
    frame.size.width = frame.size.height = DIMENSION;

    [super initWithFrame:frame];

//    [self setDefaults];

    if (tileType == TILE_WALL1)
	    [self setWall];
    else if (tileType == TILE_GREENGRASS1)
	    [self setGrass1];

    con = theCon;

    row = rval;
    col = cval;

    return self;
}

- (int)row
{
    return row;
}

- (int)col
{
    return col;
}

- setWall
{
    isMine = NO;
    neighbors = 0;
    tileState = TILE_WALL1;//GREENGRASS1;
    marked = NO;

    [self setNeedsDisplay:YES];
    return self;
}

- setGrass1
{
    isMine = NO;
    neighbors = 0;
    tileState = TILE_GREENGRASS1;
    marked = NO;

    [self setNeedsDisplay:YES];
    return self;
}

- setDefaults
{
    isMine = NO;
    neighbors = 0;
    tileState = TILE_WALL1;//GREENGRASS1;
    marked = NO;

    [self setNeedsDisplay:YES];
    return self;
}

- setMine:(BOOL)flag;
{
    if(flag!=isMine){
        [self setNeedsDisplay:YES];
    }

    isMine = flag;
    return self;
}

- setNeighbors:(int)count;
{
    if(count!=neighbors){
        [self setNeedsDisplay:YES];
    }

    neighbors = count;
    return self;
}

- setTileState:(TILE_STATE)aState
{
  //  if(aState!=tileState){
        [self setNeedsDisplay:YES];
  //  }
    tileState = aState;
    return self;
}

- setMarked:(BOOL)flag;
{
    if(flag!=marked){
        [self setNeedsDisplay:YES];
    }

    marked = flag;
    return self;
}

- (BOOL)mine;
{
    return isMine;
}

- (int)neighbors
{
    return neighbors;
}

- (TILE_STATE)tileState
{
    return tileState;
}

- (BOOL)marked
{
    return marked;
}

- (void)drawRect:(NSRect)aRect
{
    PSsetlinewidth(1.0);

    if(tileState==TILE_GREENGRASS1){
/*        if(marked==YES){
            int center = DIMENSION-DIMENSION/3, width = DIMENSION/3+4;

            [[NSColor blackColor] set];
            PSrectfill(center-width/2, 2, width, 4);
            PSrectfill(center-width/2+2, 6, width-4, 3);

            PSmoveto(center, 9);
            PSlineto(center, 5*DIMENSION/6);
            PSstroke();

            [[NSColor redColor] set];
            PSrectfill(center-DIMENSION/2, DIMENSION/2, 
                       DIMENSION/2, 5*DIMENSION/6-DIMENSION/2);
        }
*/
//first solution 
            [[NSColor greenColor] set];
            PSrectfill(0, 0, 16, 16);
	
	    [self drawTileGrass1];	

    }
    else if(tileState==TILE_GREENGRASS2){
            [[NSColor greenColor] set];
            PSrectfill(0, 0, 16, 16);
	
	    [self drawTileGrass2];	
    }
    else if(tileState==TILE_WALL1) {
            [[NSColor darkGrayColor] set];
	    PSrectfill(0,0,16,16);

            [[NSColor grayColor] set];
            PSrectfill(0, 0, 5, 3);
            PSrectfill(10, 0, 3, 5);

            PSrectfill(3, 5, 2, 1);
            PSrectfill(4, 6, 2, 4);

            PSrectfill(10, 7, 13, 3);

            PSrectfill(4, 10, 7, 2);

            PSrectfill(1, 12, 6, 3);

	}
    else if(tileState==TILE_CLICKED){
            [[NSColor blackColor] set];
            PSarc(DIMENSION/2, DIMENSION/2,
                  DIMENSION/2-3, 0, 360);
            PSfill();

            PSgsave();

            PStranslate(DIMENSION/2, DIMENSION/2);

            PSmoveto(-DIMENSION/2, 0);
            PSlineto(DIMENSION/2, 0);
            PSmoveto(0, -DIMENSION/2);
            PSlineto(0, DIMENSION/2);

            PSrotate(45);

            PSmoveto(-DIMENSION/2, 0);
            PSlineto(DIMENSION/2, 0);
            PSmoveto(0, -DIMENSION/2);
            PSlineto(0, DIMENSION/2);

            PSstroke();

            PSgrestore();

            [[NSColor whiteColor] set];
            PSarc(DIMENSION/2-DIMENSION/SIZEW, DIMENSION/2+DIMENSION/SIZEH,
                  DIMENSION/10, 0, 360);
            PSfill();
        
	}
    	else if(tileState==TILE_BLANK){
            [[NSColor blackColor] set];
            PSrectfill(0, 0, 16, 16);
	}
	else if (tileState == TILE_CHARACTER) {
	
            [[NSColor redColor] set];
            PSrectfill(0, 0, 16, 16);
		//[self drawTileGrass1];
		//[self drawCharacter];

	    [self drawRogueCharacter];
		
	}	
	else {
            [[NSColor blackColor] set];
            PSarc(DIMENSION/2-DIMENSION/SIZEW, DIMENSION/2+DIMENSION/SIZEH,
                  DIMENSION/10, 0, 360);

	}
/*
        if(isMine==NO && marked==YES){
            [[NSColor redColor] set];

            PSgsave();

            PSsetlinewidth(5.0);
            PSmoveto(3, 3);
            PSlineto(DIMENSION-3, DIMENSION-3);
            PSmoveto(3, DIMENSION-3);
            PSlineto(DIMENSION-3, 3);
            PSstroke();

            PSgrestore();
        }

        if(isMine==NO && marked==NO && neighbors>0){
            char str[2] = { '0', 0 };
            float comp = ((float)neighbors)/9.0;
            NSFont *font = 
                [NSFont systemFontOfSize:DIMENSION-6];
            [font set];

            str[0] += neighbors;

            PSsetrgbcolor(1.0-comp, comp, comp);
            PSmoveto(DIMENSION/2-4, DIMENSION/4);
            PSshow(str);
            PSstroke();
        }
    }
*/

/*    [[NSColor blackColor] set];
    PSrectstroke(0, 0, DIMENSION, DIMENSION);
    [[NSColor whiteColor] set];
    PSrectstroke(1, 1, DIMENSION-2, DIMENSION-2);
*/

}


- (void)keyDown:(NSEvent *)theEvent
{
	NSString *characters = [theEvent characters];
	if ([characters length])
		switch ([characters characterAtIndex:0]){
		case NSUpArrowFunctionKey: 
			NSLog(@"keydown up");
		}
	NSLog(@"keydown");
	fprintf(stdout, "keydown!");
}

- (void)mouseDown:(NSEvent *)theEvent
{
	//FIXME update character xy
	int xx = [con getCharacterX]; 
	int yy = [con getCharacterY];
	int mx = [self col];
	int my = [self row];
	//NSPoint        point;

   	//point = [self convertPoint:[theEvent locationInWindow] fromView:self];
	NSLog(@"mouse **** %d,%d", mx,my);
	NSLog(@"self **** %d,%d", xx,yy);

	//NSLog(@"charxx----> %d, %d,mousep.x---> %d, %d\n", xx, yy, point.x, point.y);

	if (mx >= 0 && mx == xx) {
		//do not move
	} else if (mx >= 0 && mx > xx) {
		[con moveRight:self];//also sets char xy
	} else if (mx >= 0 && mx < xx) {
		[con moveLeft:self];
	}
	if (my >= 0 && my == yy) {
		//do not move
	} else if (my >= 0 && my > yy) {
		[con moveUp:self];
	} else if (my >= 0 && my < yy) {
		[con moveDown:self];
	}
}

- (void)rightMouseDown:(NSEvent *)theEvent
{
/*    if(tileState==COV_COVERED){
	if(marked==NO && ![con markCount]){
	    NSBeep();
	    return;
	}

        [self setMarked:(marked==YES ? NO : YES)];
        [con marked:self];
    }
*/
}

- (void)drawTileGrass1
{
/* XPM */
static char * tilegrass1_16x16_xpm[] = {
/*"16 16 5 1",
" 	c None",
".	c #406030",
"+	c #688038",
"@	c #2B471D",
"#	c #80A820",
*/
".+.@.+.+@.+.@.+.",
".++.#+.+@.+#..#.",
"..+.+....+.+.++#",
"+.@...++.#..@..+",
".+.+@.+..+..@...",
".@.+@..@..@+..+.",
"+@@...+.#.@#.++.",
"++.#.#+.+#.+....",
"...+.+.@.+..@.#+",
"+.+.+.@@@...@#++",
"+#+++.#++.+#.+.@",
".+.#+#+.++.+#+.@",
"..@.#+...+..#.#+",
"+#.++.#+@.+.+.+.",
".+.+..+.+@+#.++.",
"..@.+.+.++.+...@"};


	int xi = 0,yi = 0;
	for ( ; yi < 16; yi++ ) {
		for ( ; xi < 16; xi++ ) {
			unsigned char r = 0,g = 0,b = 0;
			unsigned colorCode = 0x00ff00;
			if (tilegrass1_16x16_xpm[yi][xi] == '+') {
				colorCode = 0x688038;
			}
			else if (tilegrass1_16x16_xpm[yi][xi] == '.') {
				colorCode = 0x406030;
			}
			else if (tilegrass1_16x16_xpm[yi][xi] == '@') {
				colorCode = 0x2b471d;
			}
			else if (tilegrass1_16x16_xpm[yi][xi] == '#') {
				colorCode = 0x80a820;
			}
			r = (unsigned char)(colorCode >> 16);
			g = (unsigned char)(colorCode >> 8);
			b = (unsigned char)(colorCode);
            		[[NSColor colorWithCalibratedRed:(float)(r & 0xff)
					green:(float)(g & 0xff)
					blue:(float)(b & 0xff)
					alpha:1.0f] set];
            		PSrectfill(xi, yi, 1, 1);
		}
		xi = 0;
	}
}

- (void)drawTileGrass2
{
/* XPM */
static char * tilegrass2_16x16_xpm[] = {
/*"16 16 8 1",
" 	c None",
".	c #406030",
"+	c #688038",
"@	c #2B471D",
"#	c #80A820",
"$	c #E0F830",
"%	c #C0B060",
"&	c #908040",
*/".+.@.+.+@.+.@.+.",
".+#.+#.+@.+##.+.",
"..##+.#+.+.#+.+#",
"+..#@.+#.#.#$%.+",
".+.+#@.#.+.#%&..",
".@.$$@.+#.@+.@+.",
"+@@$%..+#.@@.@+.",
"++.@@+@..@.@@...",
"...#.+.@.+..@.#+",
"+..+#.@@@..#+.++",
"+++++.+++.++.+.@",
".+..+#++.##+.+.@",
"..@..+.#.@$%..#+",
"+#.@@@++.@%&@.+.",
".+.+..+..@+@.++.",
"..@.+.+.@+.+...@"};
	int xi = 0,yi = 0;
	for ( ; yi < 16; yi++ ) {
		for ( ; xi < 16; xi++ ) {
			unsigned char r = 0,g = 0,b = 0;
			unsigned colorCode = 0x00ff00;
			if (tilegrass2_16x16_xpm[yi][xi] == '+') {
				colorCode = 0x688038;
			}
			else if (tilegrass2_16x16_xpm[yi][xi] == '.') {
				colorCode = 0x406030;
			}
			else if (tilegrass2_16x16_xpm[yi][xi] == '@') {
				colorCode = 0x2b471d;
			}
			else if (tilegrass2_16x16_xpm[yi][xi] == '#') {
				colorCode = 0x80a820;
			}
			else if (tilegrass2_16x16_xpm[yi][xi] == '$') {
				colorCode = 0xe0f830;
			}
			else if (tilegrass2_16x16_xpm[yi][xi] == '%') {
				colorCode = 0xc0b060;
			}
			else if (tilegrass2_16x16_xpm[yi][xi] == '&') {
				colorCode = 0x908040;
			}
			r = (unsigned char)(colorCode >> 16);
			g = (unsigned char)(colorCode >> 8);
			b = (unsigned char)(colorCode);
            		[[NSColor colorWithCalibratedRed:(float)(r/0xff)
					green:(float)(g/0xff)
					blue:(float)(b/0xff)
					alpha:1.0] set];
            		PSrectfill(xi, yi, 1, 1);
		}
		xi = 0;
	}
}

- (void) drawRogueCharacter
{

        [[NSColor brownColor] set];
	PSrectfill(0,0,16,16);

	char *data = [con getCharacterXpmData];
	int i = 0, j = 0;
	for ( ; i < DIMENSION; i++) {//FIXME DIMENSION, xpm w,h
		for ( ; j < DIMENSION; j++) {//FIXME DIMENSION, xpm w,h

			char colorsymbol = data[i*row+j];
			int colorCode = [con getColor:colorsymbol];
			float r = (float)(colorCode >> 16);
			float g = (float)(colorCode >> 8);
			float b = (float)(colorCode);
            		[[NSColor colorWithCalibratedRed:(float)(r)
					green:(float)(g)
					blue:(float)(b)
					alpha:1.0f] set];
			PSrectfill(j,i, 1,1);			
	
		}		
	}
/****above	for ( ; i < DIMENSION; i++) {//FIXME DIMENSION, xpm w,h
		for ( ; j < DIMENSION; j++) {//FIXME DIMENSION, xpm w,h

			char colorsymbol = data[i*row+j];
			int colorCode = [con getColor:colorsymbol];
			unsigned char r = (unsigned char)(colorCode >> 16);
			unsigned char g = (unsigned char)(colorCode >> 8);
			unsigned char b = (unsigned char)(colorCode);
            		[[NSColor colorWithCalibratedRed:(float)(r/0xff)
					green:(float)(g/0xff)
					blue:(float)(b/0xff)
					alpha:1.0] set];
			PSrectfill(j,i, 1,1);			
	
		}
	}
***/	free(data);	

}

- (int) extractRed:(int)rgb 
{
	return ((rgb >> 16) & 0xFF);
}

- (int) extractGreen:(int)rgb 
{
	return ((rgb >> 8) & 0xFF);
}

- (int) extractBlue:(int)rgb 
{
	return (rgb & 0xFF);
}

@end

