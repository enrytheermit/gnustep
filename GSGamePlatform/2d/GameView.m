/*
 Copyright (C) 2013 Enry the Ermit
 
 This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#import "GameView.h"
#import "GameSubView.h"
#import "MainView.h"

@implementation GameView

@synthesize leftButton,rightButton,upButton;//The GameView is the first responder for these buttons

- (id) alloc
{
	[super alloc];
	[self setNeedsDisplay:YES];
	
	return self;
}

- (id) init
{
	x = 0;
	y = 0;
	w = 16*16;
	h = 16*16;
	
	[[UIColor redColor] set];
	self.backgroundColor = [UIColor redColor];
	
	UIImage *image = [UIImage imageNamed:@"KinkakuJi"];
	self.image = image;
}
- (void)drawRect:(CGRect)rect
{
	CGContextRef *context = UIGraphicsGetCurrentContext();
	
	[[UIColor redColor] set];
	self.backgroundColor = [UIColor redColor];

	UIImage *image = [UIImage imageNamed:@"KinkakuJi"];
	self.image = image;
	
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{}


- (int) getx
{
	return x;
}

-(int) gety
{
	return y;
}

- (IBAction)doLeftButton{ 
	
	int i = 0, j = 0;
	for ( ; i < 16; i++) {
		for ( ; j < 16; j++) {
			
			subviews[i][j].center = CGPointMake(0,0);//j*16+x, i*16+y);
			[subviews[i][j] initWithImage: [UIImage imageNamed:@"tile-grass-3-16x16"]];
			[subviews[i][j] setNeedsDisplay:YES];
			
		}
		j = 0;
	}
	
}
-(void)addSubviewToArray:(GameSubView*)v
{
	subviews[((int)[v getx])%16][((int)[v gety])%16] = v;
}

- (IBAction)doRightButton{  
}

- (IBAction)doUpButton{
}

@end
