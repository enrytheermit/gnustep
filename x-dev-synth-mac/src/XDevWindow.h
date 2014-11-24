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
#ifndef WINDOW_H
#define WINDOW_H
#include <X11/Xlib.h>
#include "XDev.h"

class WindowManipulator;

//tully #include "../widgets/WindowWidget.h"
class WindowWidget;

class XDevWindow {
 private:
  int title_y, lowerborder_y;
  Window window;
  GC gc;
  struct frame {
    Pixmap titlebar, destroy_button, lowerborder;
    int x, y, x_root, y_root;
    unsigned int  width, height, border_width;
    Window window, /*application_window,*/ title/*, destroy*/;
  } frame;
  bool created;
 protected:
  Window createChildWindow(Window parent, Cursor cursor);
  void decorate_title();
//tully  
   Pixel GetColor(Display **dpy, char *name);
 public:

  WindowManipulator* createmanipulator();

  virtual void drawsphere(Window const& w);
  virtual void fillrectangle(Display **dpy, Window const& w, int x1, int y1, int width, int height);
  virtual  void drawline(Display **dpy, Window const& w, int x1, int y1, int x2 ,int y2);
  //void drawline(int x1, int y1, int x2 ,int y2);
  Window createTopLevelWindow(int , int , unsigned int ,unsigned int ,unsigned int, Window *w);
  Window createTopLevelSimpleWindow(int x, int y, unsigned int width,unsigned int height,unsigned int borderwidth);
  XDevWindow();
  XDevWindow(Display **dpy, Window& , Window&);
  ~XDevWindow();
  inline Window getTitleWindow() { return frame.title; }
  inline Window getWindow() { return frame.window; }
  inline Window getClientWindow() { return window; }
  inline Window getLowerborderWindow() { return frame.lowerborder; }
  inline int getx() { return frame.x; }
  inline int gety() { return frame.y; }
  inline Window getWidth() { return frame.width; }
  inline Window getHeight() { return (frame.height+title_y+lowerborder_y); }
  void destroy(Display **dpy);
  void unmap(Display **dpy);
  void resize(Display **dpy, int, int);
  void configure(Display **dpy, XConfigureRequestEvent);
  void expose(XExposeEvent&);
  virtual void buttonpress(XButtonEvent& e);
  virtual void motion();
  void move(Display * *dpy, int ,int );

  void set_windowwidget(WindowWidget *wi);
  WindowWidget *get_windowwidget();
 private:
  WindowWidget *_windowwidget;

}; //class XDevWindow
#endif
