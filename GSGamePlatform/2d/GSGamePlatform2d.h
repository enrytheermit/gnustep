/*
 Copyright (C) 2013 Enry the Ermit
 
 This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#import <UIKit/UIKit.h>

@interface GSGamePlatform2dAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	UIButton *leftButton;
	UIButton *rightButton;
	UIButton *upButton;
	
}

@property (nonatomic,retain) IBOutlet UIButton *leftButton;
@property (nonatomic,retain) IBOutlet UIButton *rightButton;
@property (nonatomic,retain) IBOutlet UIButton *upButton;

- (IBAction)doLeftButton;
- (IBAction)doRightButton;
- (IBAction)doUpButton;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
