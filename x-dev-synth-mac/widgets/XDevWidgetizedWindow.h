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
#ifndef WIDGETWINDOW_H
#define WIDGETWINDOW_H
#include <X11/Xlib.h>
#include "../src/XDevWindow.h"
#include "WidgetWindowManipulator.h"


class XDevWidgetWindow : public XDevWindow {

public:

  XDevWidgetWindow();
  XDevWidgetWindow(DisplayBase<Display **>& dpyb, Window& , Window&);
  ~XDevWidgetWindow();

  WidgetWindowManipulator *createwidgetmanipulator(XDev& xdev0);

  //virtual void drawsphere(Window const& w); 
  void drawline(Display **dpy, Window const& w, int x1, int y1, int x2 ,int y2);

  //void set_windowwidget(WindowWidget *wi);
  
  //  virtual void buttonpress(XButtonEvent& e); 
  virtual void motion();


}; //class XDevWindow
#endif

