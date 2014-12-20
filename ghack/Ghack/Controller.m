
#import <time.h>
#import <stdlib.h>
#import <stdio.h>
#import "Controller.h"
/*
Copyright (C) 2013 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

@implementation Controller

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
{
    NSInvocation *inv;

    inv = [NSInvocation 
              invocationWithMethodSignature: 
                  [self methodSignatureForSelector: 
                            @selector(tick)]];
    [inv setSelector:@selector(tick)];
    [inv setTarget:self];
    [inv retain];

    [NSTimer scheduledTimerWithTimeInterval:1.0
             invocation:inv
             repeats:YES];

    window = nil;

////    srand48(time(NULL));

    character = [[Character alloc] initAtRow:10 Col:10];
    xpmcharacter = [[Xpm alloc] initWithRogueCharacter];

    [self makeGameWindow];
    [self newGame:nil];//FIXME delete

}

- makeGameWindow
{
    NSRect frame;
    NSView *view;
    int m = NSTitledWindowMask;
    int row, col;
    NSBox *boardBox;
//    NSRect contentRect;

    view  = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, DIMENSION*SIZEW, DIMENSION*SIZEH)];

    [self genMap];
    [self genCharacterOnMapRow:10 Col:10];
//    [self printMap];

    for(col=0; col<SIZEH; col++){
    	for(row=0; row<SIZEW; row++){
            NSPoint spoint = 
                NSMakePoint(row*DIMENSION, col*DIMENSION);
            Square *field = 
                [[Square alloc] initAtPoint:spoint
                    row:row col:col tileType:map[col][row] controller:self];
            [view addSubview:field];
            fields[col][row] = field;
        }
    }


/*
    int rowc = [character row];
    int colc = [character col];
    NSPoint spoint = NSMakePoint(rowc*DIMENSION, colc*DIMENSION);
    [fields[colc][rowc] dealloc];
    Square *field = [[Square alloc] initAtPoint:spoint row:rowc col:colc tileType:TILE_CHARACTER controller:self];
    fields[colc][rowc] = field;
    [view addSubview:field];
*/   /* markField =
        [[NSTextField alloc]
            initWithFrame:
                NSMakeRect(0, DIMENSION*SIZEW+SEPARATOR,
                           3*DIMENSION, DIMENSION)];
    [markField setEditable:NO];
    [markField setSelectable:NO];
    [markField setBackgroundColor:[NSColor blackColor]];
    [markField setTextColor:[NSColor redColor]];
    [view addSubview:markField];


    timeField =
        [[NSTextField alloc]
            initWithFrame:
                NSMakeRect(DIMENSION*5, DIMENSION*SIZEW+SEPARATOR,
                           3*DIMENSION, DIMENSION)];
    [timeField setEditable:NO];
    [timeField setSelectable:NO];
    [timeField setBackgroundColor:[NSColor blackColor]];
    [timeField setTextColor:[NSColor redColor]];
    [view addSubview:timeField];
*/
    boardBox = 
        [[NSBox alloc] 
            initWithFrame:
                NSMakeRect(0, 0, DIMENSION*SIZEW, DIMENSION*SIZEH)];
    [boardBox setContentView:view];
    [boardBox setContentViewMargins:NSMakeSize(MARGIN, MARGIN)];
    [boardBox setTitle:@"Yondor"];
//    [boardBox setBorderType:NSGrooveBorder];
    [boardBox sizeToFit];

    frame = [NSWindow frameRectForContentRect:[boardBox frame] 
                      styleMask:m];

    window = [[NSWindow alloc] initWithContentRect:frame 
                                styleMask:m			       
                                backing: NSBackingStoreRetained 
                                defer:NO];
    [window setMinSize:frame.size];
    [window setTitle:@"Ghack"];
    [window setDelegate:self];

//    [window setFrame:frame display:YES];
//    [window setMaxSize:frame.size];

    [window setContentView:boardBox];
    [window setReleasedWhenClosed:YES];

    // RELEASE(view);

    [window center];
    [window orderFrontRegardless];
    [window makeKeyWindow];
    [window display];


    return self;
}


- newGame:(id)sender
{
    //int row, col, mrow, mcol, index;
    int row, col;

    for(col=0; col<SIZEH; col++){
    	for(row=0; row<SIZEW; row++){
		[fields[col][row] setTileState:map[col][row]];
//            [fields[row][col] setDefaults];
        }
    }
/*
    for(index=0; index<10; index++){
        do {
            mrow = lrand48()%SIZEW;
            mcol = lrand48()%SIZEH;
        }
        while([fields[mrow][mcol] mine]==YES);
        [fields[mrow][mcol] setMine:YES];
    }

    for(row=0; row<SIZEW; row++){
        for(col=0; col<SIZEH; col++){
            int sx, sy, nb;
            nb = 0;
            for(sx=-1; sx<=1; sx++){
                for(sy=-1; sy<=1; sy++){
                    int cx = row+sx, cy = col+sy;
                    if(!(sx==0 && sy==0) &&
                       (0<=cx && cx<SIZEW) &&
                       (0<=cy && cy<SIZEH)){
                        if([fields[cx][cy] mine]==YES){
                            nb++;
                        }
                    }
                }
            }

            if(nb>0){
                [fields[row][col] setNeighbors:nb];
            }
        }
    }

    [markField setIntValue:10];
    [timeField setStringValue:@""];

    untileState = 0;
    atStart = YES;
*/
    return self;
}


- uncoverRegion:(Square *)item
{
//    int row, col, sx, sy, cx, cy;
/*
    if([item tileState]!=COV_COVERED || [item marked]==YES){
        return self;
    }
*/
    [item setTileState:TILE_BLANK];
//FIXMENOTE    [item setCovered:TILE_CLICKED];
/*    untileState++;

    if([item neighbors]>0){
        return self;
    }

    row = [item row]; col = [item col];
    for(sx=-1; sx<=1; sx++){
        for(sy=-1; sy<=1; sy++){
            cx = row + sx; cy = col + sy;
            if(!(sx==0 && sy==0) &&
               (0<=cx && cx<SIZEW) &&
               (0<=cy && cy<SIZEH)){
                [self uncoverRegion:fields[cx][cy]];
            }
        }
    }
*/
    return self;
}

- uncoverAll:(Square *)item
{
    int row, col;
    for(col=0; col<SIZEH; col++){
    	for(row=0; row<SIZEW; row++){
            Square *other = fields[col][row];
            if(other!=item){
                [other setTileState:TILE_CLICKED];
            }
        }
    }
    
    atStart = YES;

    return self;
}

- untileState:(Square *)item
{

	[self uncoverRegion:item];

/*    BOOL win;

    [self start];

    if(![item neighbors] && [item mine]==NO){
        [self uncoverRegion:item];
    }
    else if([item mine]==NO){
        untileState++;
    }

    win = ((untileState==(64-10) && ![markField intValue]) ? YES : NO);

    if([item mine]==YES || win==YES){
        [self uncoverAll:item];
    }

    if([item mine]==YES){
        NSRunAlertPanel(@"Game over.", @"You lose.",
                        @"Ok", nil, nil);
    }
    else if(win==YES){
        NSRunAlertPanel(@"Congratulations!", @"You win.",
                        @"Ok", nil, nil);
    }
*/
    return self;
}

- marked:(Square *)item
{
    BOOL win;
    int marks = [markField intValue];
    [markField setIntValue:marks+([item marked]==YES ? -1 : 1)];

    [self start];

    win = ((untileState==(64-10) && ![markField intValue]) ? YES : NO);
    if(win==YES){
        [self uncoverAll:nil];
        NSRunAlertPanel(@"Congratulations!", @"You win.",
                        @"Ok", nil, nil);
    }

    return self;
}

- (int)markCount
{
    return [markField intValue];
}


- start
{
    if(atStart==YES){
        startDate = [NSDate date];
        [startDate retain];
        atStart = NO;
    }
    
    return self;
}

- tick
{
    if(atStart==NO){
        int delta = -[startDate timeIntervalSinceNow];
        NSString *timeStr = 
            [NSString stringWithFormat:@"%06d:%02d", 
                      delta/60, delta%60];
        [timeField setStringValue:timeStr];
    }

    return self;
}


- (void)genMap
{
	int xi = 0, yi = 0;
	for ( ; yi < SIZEH; yi++) {
		for ( ; xi < SIZEW; xi++) {
				map[yi][xi] = TILE_BLANK;
		}
		xi = 0;
	} 

	//initialize w,h of starter room
	int rw = rand();//in [0,RAND_MAX]
	int rh = rand();//in [0,RAND_MAX]
	int maxw = 15;
	int maxh = 15;
	int w = rw % maxw;
	int h = rh % maxh;
	w = w<0?5:w+5;
	h = h<0?5:h+5;

	//initialize x,y of starter room
	int rx = rand();//in [0,RAND_MAX]
	int ry = rand();//in [0,RAND_MAX]
	int x = (rx % SIZEW)-w-1;
	int y = (ry % SIZEH)-h-1;
	x = x<0?0:x;
	y = y<0?0:y;

	//fprintf(stdout,"w=%d h=%d\n",w+5,h+5);
	xi = x; yi = y;
	for ( ; yi < y+h; yi++) {
		for ( ; xi < x+w; xi++) {
			if (xi == x || xi == x+w-1 || yi == y || yi == y+h-1) {
				map[yi][xi] = TILE_WALL1;
				//fprintf(stdout,"made wall1 x=%d y=%d\n",xi,yi);
			}
		}
		xi = x;
	}

	int rr = rand()%3;//in [0,RAND_MAX]
	NSMutableString *weststate = [[NSMutableString new] initWithString:@"none"];
	NSMutableString *eaststate = [[NSMutableString new] initWithString:@"none"];
	NSMutableString *northstate = [[NSMutableString new] initWithString:@"none"];
	NSMutableString *southstate = [[NSMutableString new] initWithString:@"none"];

	//setting exits of first room
	if (x < SIZEW / 2 && w > 10) {//first region
		[weststate setString: @"west"];
		if (y < SIZEH / 2 && w > 10) {//first region
			[northstate setString: @"north"];
		} 

	}

	if (y < SIZEH / 2 && h > 10) {//first region
		[northstate setString: @"north"];
//		if (x < SIZEW / 2 && w > 10) {//first region
//			weststate = "west";
//		} 

	}
	if (y > SIZEH / 2 && h > 10) {//first region
		[southstate setString: @"south"];
	}

	int rri,holex=x,holey=y;
	NSMutableString *holestate[rr];//size == rr !
	holestate[0] = [[NSMutableString new] initWithString: @"none"];
	holestate[1] = [[NSMutableString new] initWithString: @"none"];
	holestate[2] = [[NSMutableString new] initWithString: @"none"];
	//printf("number of holes (rr=)%d\n",rr);
	for ( rri = 0; rri < rr; rri++) {


		if (rri > 0) {//after first exit, do not make exits here and there
			//here we set the states according to the previous
			//encountered holestates :
			if ([holestate[rri-1] compare: @"west"])
				[weststate setString: @"west"];
			else if ([holestate[rri-1] compare: @"east"])
				[eaststate setString: @"east"];
			else if ([holestate[rri-1] compare: @"north"])
				[northstate setString: @"north"];
			else if ([holestate[rri-1] compare: @"south"])
				[southstate setString: @"south"];
		}
		

		int face = rand() % 4;//choose facing of hole exit

		//if there is at least one hole on a wall, we cannot set a 
		//further hole there :

		//north
		if (face == 0 && ![northstate compare: @"north"] && ![weststate compare: @"west"]) {
			NSLog(@"made NORTH hole exit");
			holex += rand()%w;
			holex = holex==x?holex+1:holex;
			holex = holex==x+w?holex-1:holex;
			[holestate[rri] setString: @"north"];
		}
		//south
		else if (face == 1 && ![southstate compare: @"south"]) {
			NSLog(@"made SOUTH hole exit");
			//fprintf(stdout, "holex=%d, holey=%d\n",holex,holey);
			holey += h;
			holex += rand()%w;
			holex = holex==x?holex+1:holex;
			holex = holex==x+w?holex-1:holex;
			//fprintf(stdout, "holex=%d, holey=%d\n",holex,holey);
			[holestate[rri] setString: @"south"];
		}
		//west
		else if (face == 2 && ![weststate compare: @"west"]) {
			NSLog(@"made WEST hole exit");
			holey += rand()%h;
			holey = holey==y?holey+1:holey;
			holey = holey==y+w?holey-1:holey;
			[holestate[rri] setString: @"west"];
		}
		//east
		else if (face == 3 && ![eaststate compare: @"east"]) {
			NSLog(@"made EAST hole exit");
			holex += w;
			holey += rand()%h;
			holey = holey==y?holey+1:holey;
			holey = holey==y+h?holey-1:holey;
			[holestate[rri] setString: @"east"];
		}

		map[holey][holex] = TILE_BLANK;
	}	
}

- (void)printMap
{
	int xi,yi;
	for (yi =0; yi < SIZEH; yi++) {
		for (xi =0; xi < SIZEW; xi++) {
			fprintf(stdout,"%d",map[yi][xi]);
		}
		fprintf(stdout,"\n");
	}
}


- (void)genCharacterOnMapRow:(int)rr Col:(int)cc
{
	prevTileState = map[cc][rr];
	int r = rr;
	int c = cc;
	map[c][r] = TILE_CHARACTER;
	[character dealloc];
    	character = [[Character alloc] initAtRow:r Col:c];
	
}

-(void)moveRight:(Square*)item
{
    //delete character tile to blank
//    [item setCovered:TILE_BLANK];
    int r = [character row];
    int c = [character col];
    map[c][r] = prevTileState; 
    [fields[c][r] setTileState:prevTileState];
    [self genCharacterOnMapRow:r Col:c+1];
    [fields[c+1][r] setTileState:TILE_CHARACTER];
}

-(void)moveLeft:(Square*)item
{
    //delete character tile to blank
//    [item setCovered:TILE_BLANK];
    int r = [character row];
    int c = [character col];
    map[c][r] = prevTileState; 
    [fields[c][r] setTileState:prevTileState];
    [self genCharacterOnMapRow:r Col:c-1];
    [fields[c-1][r] setTileState:TILE_CHARACTER];
}

-(void)moveDown:(Square*)item
{
    //delete character tile to blank
//    [item setCovered:TILE_BLANK];
    int r = [character row];
    int c = [character col];
    map[c][r] = prevTileState; 
    [fields[c][r] setTileState:prevTileState];
    [self genCharacterOnMapRow:r+1 Col:c];
    [fields[c][r+1] setTileState:TILE_CHARACTER];
}

-(void)moveUp:(Square*)item
{
    //delete character tile to blank
//    [item setCovered:TILE_BLANK];
    int r = [character row];
    int c = [character col];
    map[c][r] = prevTileState; 
    [fields[c][r] setTileState:prevTileState];
    [self genCharacterOnMapRow:r-1 Col:c];
    [fields[c][r-1] setTileState:TILE_CHARACTER];
}

- (char *)getCharacterXpmData
{
	return [xpmcharacter getSymbolData];
}

- (int)getColor:(char)symbol
{
	return [xpmcharacter getColor:symbol];
}
- (int)getCharacterX
{
	return [character row];
}

- (int)getCharacterY
{
	return [character col];
}

- (void)setCharacterX:(int)r
{
	[character setRow:r];
}

- (void)setCharacterY:(int)c
{
	[character setCol:c];
}


@end


