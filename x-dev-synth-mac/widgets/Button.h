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
#ifndef BUTTONWIDGET_H
#define BUTTONWIDGET_H
#include <X11/Xlib.h>

#include "Widget.h"

class ButtonWidget : public Widget {

public:
  //ctors
  ButtonWidget(DisplayBase<Display **>& dpyb, WidgetWindowManipulator* wm); 
  ~ButtonWidget();

  //layout adaption
  virtual void set_size(int width, int height);
  virtual void set_locus(int xx, int yy);
  //other methods
  virtual void decorate(Display **dpy, Window& w, int x1, int y1, int x2 ,int y2);
  virtual void show(Display **dpy, Window& w);
  virtual void buttonpress(XButtonEvent& e);

 protected:
  int get_x();
  int get_y();
  int get_width();
  int get_height();
  char *get_buttoncolor();
 public:
  void set_buttoncolor(char *s);

 private:
  int _x,_y,_width,_height;
  char *_buttoncolor;
};
#endif

