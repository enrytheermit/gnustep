/*
 Copyright (C) 2013 Enry the Ermit
 
 This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#import "GameSubView.h"
#import "MainView.h"

@implementation GameSubView

- (id) alloc
{
	[super alloc];
	[self setNeedsDisplay:YES];

	return self;
}

- (id) initx:(int)xx y:(int)yy w:(int)ww h:(int)hh controller:(UIViewController*)p
{

	controller = p;
	
	x = xx;
	y = yy;
	w = ww;
	h = hh;
	
	return self;
}

- (void)drawRect:(CGRect)rect
{
	x += 4;
	self.center = CGPointMake(x+IPADXOFFSET, y+IPADYOFFSET);
	
		struct timespec ts;
		ts.tv_sec = 0;
		ts.tv_nsec = 500000000;
	nanosleep(&ts,NULL);
	
	CGContextRef *context = UIGraphicsGetCurrentContext();
	
	NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(moveEnemies2) object:nil];
	[thread start];
	
}

-(void)moveEnemies2
{
		[self drawRect:CGRectMake((int)[self getx],(int)[self gety],16,16)];
		[self setNeedsDisplay];
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

@end
