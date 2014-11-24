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
#ifndef WIDGETTREE_H
#define WIDGETTREE_H
#include <X11/Xlib.h>

#include "Widget.h"

class WidgetTree {

public:
  WidgetTree(Widget *root);
  ~WidgetTree();

  void addWidget(Widget *wi);
  void show(Display **dpy, Window& w);

private:
  Widget *_rootwidget;
};
#endif

