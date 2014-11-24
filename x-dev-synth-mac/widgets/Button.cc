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
#include "Button.h"
#include <iostream>
#include <cmath>
#include <cstdio>

using namespace std;

ButtonWidget::ButtonWidget(DisplayBase<Display **>& dpyb, WidgetWindowManipulator* wm) 
  : Widget(dpyb, wm), _buttoncolor(NULL)
{
  printf("creating ButtonWidget..\n");
  /*char *str = (char *)malloc(sizeof(6));
  sprintf(str, "%s", "black\0");
  _buttoncolor = str;
  */}

ButtonWidget::~ButtonWidget()
{
  //if (_buttoncolor != NULL)
  //  free(_buttoncolor);

  printf("ButtonWidget destroyed.\n");
}

void ButtonWidget::set_size(int width, int height)
{
  _width = width;
  _height = height;
}

void ButtonWidget::set_locus(int xx, int yy)
{
  _x = xx;
  _y = yy;
}

void ButtonWidget::set_buttoncolor(char *s)
{
  _buttoncolor = s;
}

void ButtonWidget::decorate(Display **dpy, Window& w, int x1, int y1, int x2 ,int y2)
{
  //show(dpy,w,x1,y1,x2,y2);
}

void ButtonWidget::show(Display **dpy, Window& w)
{
  XGCValues values;
  values.foreground = GetColor(dpy, w, _buttoncolor);//RedPixel(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));//2048;
  values.background = 2048;
  unsigned long valuemask = GCForeground | GCBackground;
  GC gc = XCreateGC(*dpy, w, valuemask, &values);
  

  //GC gc = XCreateGC(*dpy, w, 0, NIL);
  XFillRectangle(*dpy,w,gc,_x,_y,_width,_height);

}

void ButtonWidget::buttonpress(XButtonEvent& e)
{
  printf("pressed button!");
}


int ButtonWidget::get_x()
{ 
  return _x;
}

int ButtonWidget::get_y()
{
  return _y;
}

int ButtonWidget::get_width()
{
  return _width;
}

int ButtonWidget::get_height()
{
  return _height;
}

char *ButtonWidget::get_buttoncolor()
{
  return _buttoncolor;
}

