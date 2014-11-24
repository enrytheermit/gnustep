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
#include "XDevWindow.h"
#include <iostream>
#include <cmath>
#include "../widgets/WindowWidget.h"
#include "WindowManipulator.h"

XDevWindow::XDevWindow ()
{}

XDevWindow::XDevWindow(Display **dpy, Window& w, Window& title) 
{
  printf("creating XDevWindow..\n");
  created = False;
 frame.x = 40;//attrib.x;
  frame.y = 40;//attrib.y;
  frame.width = 320;//attrib.width;
  frame.height = 200;//attrib.height;
  frame.border_width = 3;//attrib.border_width;
  frame.window = w;
  frame.title = title;
  title_y = 20; //height of the title frame
  lowerborder_y = 7; //height of the lower border

  XMapWindow(*dpy, w);
}

XDevWindow::~XDevWindow()
{
  printf("XDevWindow destroyed.\n");
}

WindowManipulator* XDevWindow::createmanipulator()
{
  return new WindowManipulator(*this);  
}

void XDevWindow::drawsphere(Window const& w)
{
}

void XDevWindow::fillrectangle(Display **dpy, Window const& w, int x1, int y1, int width, int height)
{
  XGCValues values;
  values.foreground = 10400;//RedPixel(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));//2048;
  values.background = 2048;
  unsigned long valuemask = GCForeground | GCBackground;
  GC gc = XCreateGC(*dpy, w, valuemask, &values);

  XFillRectangle(*dpy,w,gc,x1,y1,width,height);
}

void XDevWindow::drawline(Display **dpy, Window const& w, int x1, int y1, int x2 ,int y2)
{
  XGCValues values;
  values.foreground = 10400;//RedPixel(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));//2048;
  values.background = 2048;
  unsigned long valuemask = GCForeground | GCBackground;
  GC gc = XCreateGC(*dpy, w, valuemask, &values);

  XDrawLine(*dpy,w,gc,x1,y1,x2,y2);
}


Window XDevWindow::createTopLevelWindow(int x, int y, unsigned int width,\
				   unsigned int height,\
				   unsigned int borderwidth,Window *w)
{
}

Window XDevWindow::createTopLevelSimpleWindow(int x, int y, unsigned int width,\
				   unsigned int height,\
				   unsigned int borderwidth)
{
}

Window XDevWindow::createChildWindow(Window parent, Cursor cursor) 
{
}

void XDevWindow::decorate_title() 
{
}
//tully
Pixel XDevWindow::GetColor(Display **dpy, char *name)
{
  XColor color;
  XWindowAttributes attributes;

  Window root_window = RootWindow(*dpy, DefaultScreen(*dpy));
  XGetWindowAttributes(*dpy,root_window,&attributes);
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

void XDevWindow::destroy(Display **dpy) 
{
  XUnmapWindow(*dpy, frame.window); //unmaps subwindows
  delete this;
}

void XDevWindow::unmap(Display **dpy)
{
  XUnmapWindow(*dpy, frame.window);
  XFlush(*dpy);
}

void XDevWindow::resize(Display **dpy, int x, int y)
{
  frame.width = frame.width-x;
  frame.height = frame.height-y;
  XResizeWindow(*dpy, frame.window, frame.width, frame.height + lowerborder_y + title_y);
  XResizeWindow(*dpy, window, frame.width, frame.height);
  XResizeWindow(*dpy, frame.title, frame.width, title_y);	      
  XResizeWindow(*dpy, frame.lowerborder, frame.width, lowerborder_y);
  XReparentWindow(*dpy, frame.lowerborder, frame.window, 0, frame.height+title_y);
  decorate_title();
}

void XDevWindow::configure(Display **dpy, XConfigureRequestEvent xcr)
{
      frame.x = xcr.x;
      frame.y = xcr.y;
      frame.width = xcr.width;
      frame.height = xcr.height;
      XResizeWindow(*dpy, window, frame.width, frame.height);
      XMoveResizeWindow(*dpy, frame.window, frame.x, frame.y, frame.width, frame.height+title_y+lowerborder_y); //--FIXME This moves too no check for x,y =(0,0) or something!
      XResizeWindow(*dpy, frame.title, frame.width, title_y);
      XResizeWindow(*dpy, frame.lowerborder, frame.width, lowerborder_y);
      XReparentWindow(*dpy, frame.lowerborder, frame.window, 0, frame.height+title_y);
      decorate_title();
}

void XDevWindow::expose(XExposeEvent& xe)
{
}

void XDevWindow::move(Display **dpy, int new_x, int new_y)
{
  XMoveWindow(*dpy, frame.window, new_x, new_y);
  frame.x = new_x;
  frame.y = new_y;
}

void XDevWindow::buttonpress(XButtonEvent& e)
{
  _windowwidget->buttonpress(e);
}

void XDevWindow::motion()
{

}

void XDevWindow::set_windowwidget(WindowWidget *wi)
{
  _windowwidget = wi;
}

WindowWidget *XDevWindow::get_windowwidget()
{
  return _windowwidget;
}
