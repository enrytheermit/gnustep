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
#include "WidgetTree.h"
#include <iostream>
#include <cmath>
#include <cstdio>

using namespace std;

WidgetTree::WidgetTree(Widget *root) 
  : _rootwidget(root)
{
  printf("creating WidgetTree..\n");
}

WidgetTree::~WidgetTree()
{
  printf("WidgetTree destroyed.\n");
}

void WidgetTree::addWidget(Widget *wi)
{
  _rootwidget->addChild(wi);
}

void WidgetTree::show(Display **dpy, Window& w)
{
  _rootwidget->show(dpy, w);
}
