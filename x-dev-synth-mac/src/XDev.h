/*
 Copyright (C) Enry the Ermit 2011-2014

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
#ifndef XDEV_H
#define XDEV_H
#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include "Xmanager.h"
#include "WindowManager.h"
#include "XDevWindow.h"
#include "XDevBaseVisit.h"


class XDev : public Xmanager , public WindowManager, public XDevBaseVisit
{
 private:
  void insert_window(XDevWindow *);
  XDevWindow *search_window(Window, bool);
  void erase_window(XDevWindow * win);
  bool pressed, motion;
  int dx, dy ,x ,y, init_x_root, init_y_root;
  short int window_type; //type of window that got event
 public:
  XDev(XDevBase& rmb, DisplayBase<Display **>& dpyb2);
  virtual ~XDev();
  virtual void init(DisplayBase<Display **>& dpyb2);
  virtual void initwindow(XDevWindow *);
  //tully 
  Pixel GetColor(Display **dpy, char *name);

  virtual void drawString(Display** dpy, Window &w, GC gc, int xx, int yy, const char*text);

  virtual void eventloop(XDevBase& rmb,XEvent *e);
  virtual int process_event(XEvent *);
  virtual void positionWindow(Display **dpy, XDevWindow *);
  virtual int drawdish(Display **dpy, int const& k);
  virtual int draw(XDevBase& rmb);
  virtual int draw2(Display **dpy, int const& k);
  virtual int draw3(Display **dpy, int const& k);
  virtual int drawsphere(Display **dpy, int const& k);
  
  virtual XDevWindow& get_xdev_window();

protected: 
  XDevWindow *window; //window which got last event
  /*static*/ DisplayBase<Display **> dpyb;

}; // class XDev 


struct rect {int x,y,x_right,y_right,w,h,surface;};
int compare_x(const void *, const void *);
#endif
