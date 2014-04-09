/*
 Copyright (C) 2013 Enry the Ermit
 
 This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */
#import "Map.h"


@implementation Map

- (id) ctor
{
	w = 16;
	h = 16;
	//[mapImages addObject: [UIImage imageNamed:@"tile-grass-1-16x16"]];
	mapImages[0] = [UIImage imageNamed:@"tile-grass-1-16x16"];
	mapImages[1] = [UIImage imageNamed:@"tile-grass-2-16x16"];
	mapImages[2] = [UIImage imageNamed:@"tile-grass-3-16x16"];
	
	return self;
}

- (UIImage*) renderx:(int)xx y:(int)yy
{
	switch (((int)map1[yy][xx])) {
	case 1:
		return mapImages[0];
		break;
	case 2:
		return mapImages[1];
		break;
	case 3:
		return mapImages[2];
		break;
	default:
		return mapImages[0];
			break;
	}
	//	}
	//}
	//return [UIImage imageNamed:@"tile-grass-1-16x16"];
}

@end
