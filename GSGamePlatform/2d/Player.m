/*
 Copyright (C) 2013 Enry the Ermit
 
 This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#import "Player.h"


@implementation Player

- (id) ctor
{
	direction = @"down";
	playerImages[0] = [UIImage imageNamed:@"player-left-1-32x32"];
	playerImages[1] = [UIImage imageNamed:@"player-right-1-32x32"];
	playerImages[2] = [UIImage imageNamed:@"player-up-1-32x32"];
	playerImages[3] = [UIImage imageNamed:@"player-down-1-32x32"];
	
	return self;
}

-(void) setDirection:(NSString*)d
{
	direction = d;
}

- (UIImage*) render:(int)r
{
	
	if ([direction compare:@"left"] == 0)
		return playerImages[0];
	else if ([direction compare:@"right"] == 0)
		return playerImages[1];
	else if ([direction compare:@"up"] == 0)
		return playerImages[2];
	else if ([direction compare:@"down"] == 0)
		return playerImages[3];
	else {
		return playerImages[0];
	}

/*	switch (r) {
	case 1:
		return playerImages[0];
		break;
	case 2:
		return playerImages[0];
		break;
	case 3:
		return playerImages[0];
		break;
	case 4:
		return playerImages[0];
		break;
	default:
		return playerImages[0];
			break;
	}
	//	}
	//}
	//return [UIImage imageNamed:@"tile-grass-1-16x16"];
*/
}

@end
