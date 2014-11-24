/*
 Copyright (C) Enry the Ermit 2014

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
#include "XDevWidgetizedWindow.h"
#include <iostream>
#include <cmath>
#include "../src/WindowManipulator.h"

XDevWidgetWindow::XDevWidgetWindow ()
{}

XDevWidgetWindow::XDevWidgetWindow(DisplayBase<Display**>& dpyb, Window& w, Window& title) 
  : XDevWindow(dpyb.get_display(), w, title)
{
  printf("creating XDevWidgetWindow..\n");
}

XDevWidgetWindow::~XDevWidgetWindow()
{
  printf("XDevWidgetWindow destroyed.\n");
}

WidgetWindowManipulator *XDevWidgetWindow::createwidgetmanipulator(XDev& xdev0)
{
  return new WidgetWindowManipulator(xdev0);
}


/*
void XDevWidgetWindow::drawsphere(Window const& w)
{
}
*/

void XDevWidgetWindow::drawline(Display **dpy, Window const& w, int x1, int y1, int x2 ,int y2)
{
  XGCValues values;
  values.foreground = 10400;//RedPixel(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));//2048;
  values.background = 2048;
  unsigned long valuemask = GCForeground | GCBackground;
  GC gc = XCreateGC(*dpy, w, valuemask, &values);

  XDrawLine(*dpy,w,gc,x1,y1,x2,y2);
}
/*
void XDevWidgetWindow::buttonpress(XButtonEvent& e)
{
  get_windowwidget()->buttonpress(e);
}
*/
void XDevWidgetWindow::motion()
{

}
