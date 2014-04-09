/*
 Copyright (C) 2013 Enry the Ermit
 
 This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#import "MainViewController.h"
#import "GameSubView.h"
#include <pthread.h>
#include <assert.h>
#include <stdlib.h>
#include <time.h>

@implementation MainViewController
@synthesize imageView = mImageView;

@synthesize window;
@synthesize redButton,greenButton,blueButton,alphaButton,interactButton;

void *routine2(void *data) {
	int xx = 0,yy = 0;
	struct timespec ts;
	ts.tv_sec = 0;
	ts.tv_nsec = 100000000;
	
	int t = 0;
	
	int r  = rand();
		
	if (r < RAND_MAX/4)
		xx += 32;
	else if (r < RAND_MAX/2)
		xx -= 32;
	else if (r < RAND_MAX/4*3)
		yy += 32;
	else if (r < RAND_MAX)
		yy -= 32;
	else {
		xx += 32;
	}

	[data moveEnemyx:xx y:yy];
	
	return NULL;						 
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	fx = 0.0;
	nenemysubviews = 0;
	
	map = [[Map new] ctor];
	player = [[Player new] ctor];
	enemy = [[Enemy new] ctor];
	
	x = 0;
	y = 0;
	xoffset = x;
	yoffset = y;
	[[UIColor redColor] set];
	self.imageView.backgroundColor = [UIColor redColor];
	
	int i = 0, j = 0;
	for ( ; i < 16; i++) {
		for ( ; j < 16; j++) {
			GameSubView* subview = [[GameSubView alloc] initWithFrame:CGRectMake(j*16+IPADXOFFSET, i*16+IPADYOFFSET, 16, 16)];
			
			subview.image = [map renderx:j y:i];
			
			subview = [subview initx:j*16 y:i*16 w:16 h:16 controller:self];
			
			[self.imageView addSubview:subview];
			[self.imageView addSubviewToArray:subview];
			subviews[i][j] = subview;
			
		}
		j = 0;
	}

	GameSubView* subview = [[GameSubView alloc] initWithFrame:CGRectMake(7*16+IPADXOFFSET, 7*16+IPADYOFFSET, 32, 32)];
	subview = [subview initx:7*16+IPADXOFFSET y:7*16+IPADYOFFSET w:32 h:32 controller:self];
	subview.image = [player render:1];
	playersubviews[0] = subview;
	[self.imageView addSubview:subview];
	
	EnemySubView* subview2 = [[EnemySubView alloc] initWithFrame:CGRectMake(0*16+IPADXOFFSET, 0*16+IPADYOFFSET, 32, 32)];
	subview2 = [subview2 initx:0*16+IPADXOFFSET y:0*16+IPADYOFFSET w:32 h:32];
	subview2.image = [enemy render:1];
	enemysubviews[nenemysubviews++] = subview2;
	[self.imageView addSubview:subview2];
	

	NSString *filename = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"lisp"];
	
	ArmLispCompiler *armlispcompiler = [[ArmLispCompiler alloc] ctor:HAVE_MACHINE_ARMASM];
	[armlispcompiler compilablesource:filename];
	
	int ii = 0;
	while (ii < nenemysubviews) {
		enemysubviews[ii].center = CGPointMake(xoffset+IPADXOFFSET, yoffset+IPADYOFFSET);
		[enemysubviews[ii] drawRect:CGRectMake((int)[enemysubviews[ii] getx],(int)[enemysubviews[ii] gety],16,16)];
		[enemysubviews[ii] setNeedsDisplay];
		ii++;
	}
	
	
	
}

- (UIImageView*)getImageView
{
	return self.imageView;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload
{
    self.imageView = nil;
    [super viewDidUnload];
}


- (void)dealloc
{
    [mImageView release];
    [super dealloc];
}

- (IBAction)contentModeChanged:(UISegmentedControl *)segmentedControl
{
	
	switch(segmentedControl.selectedSegmentIndex)
    {
			
		self.imageView.backgroundColor = [UIColor blackColor];
			
        case 0:{
			
            break;
		}
        case 1:
            break;
        case 2:
            break;
    }
}

- (void)move
{
	self.imageView.backgroundColor = [UIColor blackColor];

	int i = 0, j = 0;
	for ( ; i < 16; i++) {
		for ( ; j < 16; j++) {
		
		
		}
		j = 0;
	}
}


- (void) setx:(int)xx y:(int)yy
{
	x = xx;
	y = yy;
}

- (void)setImage:(UIImage*)img
{
	self.imageView.image = img;
}

- (IBAction)doLeftButton{ 
	[player setDirection:@"left"];
	playersubviews[0].image = [player render:1];
	int offset = 10;
	x += offset;
	self.imageView.backgroundColor = [UIColor blackColor]; 
	int i = 0, j = 0;
	for ( ; i < 16; i++) {
		for ( ; j < 16; j++) {
		
			subviews[i][j].center = CGPointMake(j*16+x+IPADXOFFSET, i*16+y+IPADYOFFSET);
			
		}
		j = 0;
	}
	
	int ii = 0;
	while (ii < nenemysubviews) {
		int ex = [enemysubviews[ii] getx];
		int ey = [enemysubviews[ii] gety];
		[enemysubviews[ii] setNeedsDisplay];
		[enemysubviews[ii] setx:ex+offset y:ey];
		ii++;
	}
}

- (IBAction)doRightButton{
	[player setDirection:@"right"];
	playersubviews[0].image = [player render:1];
	int offset = 10;
	x -= offset;
	self.imageView.backgroundColor = [UIColor redColor]; 
	int i = 0, j = 0;
	for ( ; i < 16; i++) {
		for ( ; j < 16; j++) {
			
			subviews[i][j].center = CGPointMake(j*16+x+IPADXOFFSET, i*16+y+IPADYOFFSET);
			
		}
		j = 0;
	}
	int ii = 0;
	while (ii < nenemysubviews) {
		int ex = [enemysubviews[ii] getx];
		int ey = [enemysubviews[ii] gety];
		[enemysubviews[ii] setNeedsDisplay];
		[enemysubviews[ii] setx:ex-offset y:ey];
		ii++;
	}
}

- (IBAction)doUpButton{ 
	[player setDirection:@"up"];
	playersubviews[0].image = [player render:1];
	int offset = 10;
	y += offset;
	self.imageView.backgroundColor = [UIColor redColor]; 
	int i = 0, j = 0;
	for ( ; i < 16; i++) {
		for ( ; j < 16; j++) {
			
			subviews[i][j].center = CGPointMake(j*16+x+IPADXOFFSET, i*16+y+IPADYOFFSET);
			
		}
		j = 0;
	}
	int ii = 0;
	while (ii < nenemysubviews) {
		int ex = [enemysubviews[ii] getx];
		int ey = [enemysubviews[ii] gety];
		[enemysubviews[ii] setNeedsDisplay];
		[enemysubviews[ii] setx:ex y:ey+offset];
		ii++;
	}
}

- (IBAction)doDownButton{ 
	[player setDirection:@"down"];
	playersubviews[0].image = [player render:1];
	int offset = 10;
	y -= offset;
	self.imageView.backgroundColor = [UIColor redColor]; 
	int i = 0, j = 0;
	for ( ; i < 16; i++) {
		for ( ; j < 16; j++) {
			
			subviews[i][j].center = CGPointMake(j*16+x+IPADXOFFSET, i*16+y+IPADYOFFSET);
			
		}
		j = 0;
	}
	int ii = 0;
	while (ii < nenemysubviews) {
		int ex = [enemysubviews[ii] getx];
		int ey = [enemysubviews[ii] gety];
		[enemysubviews[ii] setNeedsDisplay];
		[enemysubviews[ii] setx:ex y:ey-offset];
		ii++;
	}
}


- (IBAction)doInteractButton
{
	int ii = 0;
	while (ii < nenemysubviews) {
		
		int xx = [enemysubviews[ii] getx];
		int yy = [enemysubviews[ii] gety];
		int px = [playersubviews[0] getx];
		int py = [playersubviews[0] gety];
		if (abs(xx - px) < 100 && abs(yy - py) < 300)
				  [self interact];
		ii++;	
	}
}

- (void)interact
{
	exit(0);
}

-(void)moveEnemies
{
	NSRunLoop* loop = [NSRunLoop currentRunLoop];
	
	NSDate *futureDate = [NSDate dateWithTimeIntervalSinceNow:1];
	NSTimer *timer = [[NSTimer alloc] initWithFireDate:futureDate interval:0.1 target:self selector:@selector(myDoFireTimer:) userInfo:nil repeats:YES];
	
	[loop addTimer:timer forMode:NSDefaultRunLoopMode];
	
	int count = 1;
	do {
		
		int ii = 0;
		while (ii < nenemysubviews) {
			enemysubviews[ii].center = CGPointMake(xoffset+IPADXOFFSET, yoffset+IPADYOFFSET);
			[enemysubviews[ii] drawRect:CGRectMake((int)[enemysubviews[ii] getx],(int)[enemysubviews[ii] gety],16,16)];
			[enemysubviews[ii] setNeedsDisplay];
			ii++;
		}
		
	} while (count--);
}

- (int)moveEnemyx:(int)xx y:(int)yy 
{ 
	int ii = 0;
	while (ii < nenemysubviews) {
		enemysubviews[ii].center = CGPointMake(xoffset+IPADXOFFSET, yoffset+IPADYOFFSET);
		ii++;
	}
	return 0;
}

@end
