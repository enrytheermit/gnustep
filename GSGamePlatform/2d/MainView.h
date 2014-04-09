/*
 Copyright (C) 2013 Enry the Ermit
 
 This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#import <UIKit/UIKit.h>
//#import <EventKitUI/EventKitUI.h>
#import "GameView.h"
#import "GameSubView.h"
#import "EnemySubView.h"
#import "Map.h"
#import "Player.h"
#import "Enemy.h"

#define IPADXOFFSET 200
#define IPADYOFFSET 200

@interface FirstViewController : UIViewController {
    //UIImageView* mImageView;
	GameView* mImageView;
	
	UIImage *mapImages[1024];
	
	GameSubView *subviews[16][16];
	GameSubView *playersubviews[1];
	EnemySubView *enemysubviews[1024];
	int nenemysubviews;
	
	int x,y;
	float fx;
	
	
	int xoffset,yoffset;
	
	Map *map;
	Player *player;
	Enemy *enemy;

	UIButton *leftButton;
	UIButton *rightButton;
	UIButton *upButton;
	UIButton *downButton;
	
	UIButton *interactButton;
	
	//UIWindow *window;
}

- (void) setx:(int)xx y:(int)yy;
- (void)move;

@property (nonatomic,retain) IBOutlet UIWindow *window;

@property (nonatomic,retain) IBOutlet UIButton *leftButton;
@property (nonatomic,retain) IBOutlet UIButton *rightButton;
@property (nonatomic,retain) IBOutlet UIButton *upButton;
@property (nonatomic,retain) IBOutlet UIButton *downButton;
@property (nonatomic,retain) IBOutlet UIButton *interactButton;

- (IBAction)doLeftButton;
- (IBAction)doRightButton;
- (IBAction)doUpButton;
- (IBAction)doDownButton;
- (IBAction)doInteractButton;

@property (nonatomic, retain) IBOutlet GameView* imageView;

- (IBAction)contentModeChanged:(UISegmentedControl*)segmentedControl;

@end
