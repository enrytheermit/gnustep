/*
 Copyright (C) Enry the Ermit 2011

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
#ifndef XMANAGER_H
#define XMANAGER_H

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/xpm.h>
class XDev;
template <class D> class DisplayBase;
class Xmanager {
 protected:
  
  int depth, screen;
  Visual *visual;
  Window root_window;
  XFontSet fontset;

 public:
  Xmanager();
  void init(DisplayBase<Display * *>& dpyb);
  ~Xmanager();
  XFontSet createFontSet(DisplayBase<Display **>& dpyb);
  inline int getScreen() {return screen;}
  inline Window getRootWindow() { return root_window; }
  inline int getDepth() { return depth; }
  inline Visual *getVisual() { return visual; }
  inline XFontSet getFontSet() { return fontset; }
}; //class Xmanager

static const char *getFontElement(const char *pattern, char *buf, int bufsiz, ...);
static const char *getFontSize(const char *pattern, int *size);
#endif
