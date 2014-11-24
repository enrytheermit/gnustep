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
#include "WindowWidget.h"
#include <iostream>
#include <cmath>
#include <cstdio>

using namespace std;


WindowWidget::WindowWidget(DisplayBase<Display **>& dpyb, WidgetWindowManipulator* wm) 
  : Widget(dpyb,wm)
{
  printf("creating WindowWidget..\n");
}

WindowWidget::~WindowWidget()
{
  printf("WindowWidget destroyed.\n");
}

void WindowWidget::show(Display **dpy, Window& w)
{
//printf("showing widgets in windowwidget...");
  for (vector<Widget*>::iterator vi = _children.begin();
       vi != _children.end(); vi++) {
    (*vi)->show(dpy, w);
  }

/*
  XGCValues values2;
  values2.foreground = GetColor(dpy, w, get_buttoncolor());
  values2.background = 2048;
  unsigned long valuemask2 = GCForeground | GCBackground;
  GC gc2 = XCreateGC(*dpy, w, valuemask2, &values2);
  XFillRectangle(*dpy, w, gc2, get_x(), get_y(), get_width(), get_height());

  XGCValues values;
  values.foreground = GetColor(dpy, w, get_textcolor());
  values.background = 2048;
  unsigned long valuemask = GCForeground | GCBackground;
  GC gc = XCreateGC(*dpy, w, valuemask, &values);

  drawString(dpy, w, gc, get_x(), get_y());
*/
}

void WindowWidget::buttonpress(XButtonEvent &e)
{
  printf("buttonpressing in windowwidget : %d,%d", e.x, e.y);
 
  for (vector<Widget*>::iterator vi = _children.begin();
       vi != _children.end(); vi++) {
    (*vi)->buttonpress(e);
  }
}

