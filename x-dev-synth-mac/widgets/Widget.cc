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
#include "Widget.h"
#include <iostream>
#include <cmath>
#include <cstdio>

using namespace std;

#define NIL (0)

Widget::Widget(DisplayBase<Display **>& dpyb, WidgetWindowManipulator* wm) 
  : _dpy(dpyb.get_display()), _windowsystemadapter(wm), _callback(NULL)
{
  printf("creating Widget..\n");
}

Widget::~Widget()
{
  printf("Widget destroyed.\n");
}

void Widget::addChild(Widget *wi)
{
  _children.push_back(wi);
}

void Widget::setParent(Widget *wi)
{
  _parent = wi;
}

void Widget::setCallback(void *(*f)(void*, void *))
{
  _callback = f;
}

void Widget::show(Display **dpy, Window& w)
{
  
}

void Widget::buttonpress(XButtonEvent& e)
{
  
}

Pixel Widget::GetColor(Display **dpy, Window& w, char *name)
{
  XColor color;
  XWindowAttributes attributes;

  XGetWindowAttributes(*dpy, w,&attributes);
  color.pixel = 0;
   if (!XParseColor (*dpy, attributes.colormap, name, &color)) 
     {
       printf("parse no color");
     }
   else if(!XAllocColor (*dpy, attributes.colormap, &color)) 
     {
       printf("parse no color");
     }
  return color.pixel;
}


