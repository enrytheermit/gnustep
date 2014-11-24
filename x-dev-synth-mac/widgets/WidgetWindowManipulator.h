/*
 Copyright (C) Enry the Ermit 2011-2014

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#ifndef WIDGETWINDOWMANIPULATOR_H
#define WIDGETWINDOWMANIPULATOR_H
#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>

#include "../src/XDevWindow.h"
#include "../src/WindowManipulator.h"

class WidgetWindowManipulator : public WindowManipulator 
{
 public:
  WidgetWindowManipulator(XDev& xdev0);
  virtual ~WidgetWindowManipulator();

 private:
  XDev& xdev;

 public:
  XDev& get_xdev();
}; // class WindowManipulator 


#endif
