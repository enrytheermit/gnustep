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
#ifndef WIDGET_H
#define WIDGET_H
#include <X11/Xlib.h>
#include <vector>

#include "WidgetWindowManipulator.h"
#include "../src/XDevBaseVisit.h"

using namespace std;

class Widget {

public:
  Widget(DisplayBase<Display **>& dpyb, WidgetWindowManipulator* wm);
  ~Widget();

  Pixel GetColor(Display **dpy, Window& w, char *name);

  void addChild(Widget *wi);
  void setParent(Widget *wi);
  void setCallback(void *(*f)(void*, void *));

  virtual void show(Display **dpy, Window& w);
  virtual void buttonpress(XButtonEvent& e);

protected:
   Display **_dpy;

   Widget *_parent;
   vector<Widget *> _children;
   void *(*_callback)(void *, void *);

   WidgetWindowManipulator *_windowsystemadapter;
};
#endif

