 /*
    GSFuzzy Tests main.m 
 
    Copyright (C) 2014 Free Software Foundation, Inc.
 
    Author: Johan Ceuppens <johan@yellowcouch.org> 
    Date: Dec 2014
 
    This file is part of GNUstep.
 
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.
 
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
    License along with this library; see the file COPYING.LIB.
    If not, see <http://www.gnu.org/licenses/> or write to the
    Free Software Foundation, 51 Franklin Street, Fifth Floor,
    Boston, MA 021101301, USA.
 */

#import "FuzzyUpdateTestDTree.h"
#import "FuzzyPaintTestRules.h"

#import <Foundation/Foundation.h>
///#import <AppKit/AppKit.h>

int main(int argc, const char **argv, char **env)
{
  
   NSAutoreleasePool *pool;

   pool = [NSAutoreleasePool new];

   FuzzyInference *inf = [[FuzzyInference alloc] init];
   FuzzyUpdateDTree *dtree = [[FuzzyUpdateDTree alloc] init]; 
   [dtree init:[[FuzzyDTreeFactory alloc] init] with:inf]; 
   [dtree makeUpdateDTree];

   [pool release];
   return 0;
} 
