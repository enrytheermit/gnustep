
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
/*
Copyright (C) 2012 v-zor

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/


#import "Controller.h"

int main(int argc, const char **argv, char** env)
{
   NSAutoreleasePool *pool;
   NSApplication *app;
   NSMenu *mainMenu;
   NSMenu *menu;
   NSMenuItem *menuItem;
   Controller *controller;

   pool = [NSAutoreleasePool new];
   app = [NSApplication sharedApplication];

   //
   // Create the Menu 
   //

   // Main Menu
   mainMenu = AUTORELEASE ([NSMenu new]);

   // Info SubMenu
   menuItem = (NSMenuItem *)[mainMenu addItemWithTitle: @"Info" 
			action: NULL 
			keyEquivalent: @""];
   menu = AUTORELEASE ([NSMenu new]);
   [mainMenu setSubmenu: menu forItem: menuItem];
   [menu addItemWithTitle: @"Info Panel..." 
	 action: @selector (orderFrontStandardInfoPanel:) 
	 keyEquivalent: @""];
   [menu addItemWithTitle: @"Preferences..." 
	 action: @selector (runPreferencesPanel:) 
	 keyEquivalent: @""];
   [menu addItemWithTitle: @"Help..." 
	 action: @selector (orderFrontHelpPanel:)
	 keyEquivalent: @"?"];

   // Game MenuItem.
   menuItem = (NSMenuItem *)[mainMenu addItemWithTitle: @"New game" 
			action: @selector(newGame:) 
			keyEquivalent: @""];
   
   // Hide MenuItem
   [mainMenu addItemWithTitle: @"Hide" 
	     action: @selector (hide:)
	     keyEquivalent: @"h"];	

   // Quit MenuItem
   [mainMenu addItemWithTitle: @"Quit" 
	     action: @selector (terminate:)
	     keyEquivalent: @"q"];	

   [app setMainMenu: mainMenu];

   controller = [Controller new];
   [app setDelegate: controller];

   NSApplicationMain(argc, argv);

   [[NSUserDefaults standardUserDefaults] synchronize];

   [controller release];
   [pool release]; /* actually useless */
   return 0;
}

