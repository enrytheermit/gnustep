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

#include <X11/Xlib.h> // Every Xlib program must include this
#include <assert.h>   // I include this to test return values the lazy way
#include <unistd.h>   // So we got the profile for 10 seconds
#include <vector>
#include <iostream>
#include<cmath> 
#include <X11/Xlib.h>
#include <X11/xpm.h>
#include "src/XDev.h"
#include "src/WindowManager.h"
#include "src/XDev.h"
#include "src/XDevWindow.h"

#define NIL (0)

static Display *dpy;
static DisplayBase<Display **> dpyb;
static XDev xmantaray(xmantaray, dpyb);

void init(Display **dpy, Window *w);
void print_usage();

int main(int argc, char*argv[])
{
	dpy = XOpenDisplay(NIL);
	assert(dpy);
	dpyb = DisplayBase<Display **>(&dpy);
	xmantaray.init(dpyb);	
	if (argc > 1 && (std::string(argv[1]) == std::string("-h") 
		|| std::string(argv[1]) == std::string("-help")
		|| std::string(argv[1]) == std::string("--help"))) {
		print_usage();
		exit(0);
	}

	int blackColor = BlackPixel(dpy, DefaultScreen(dpy));
 	int whiteColor = WhitePixel(dpy, DefaultScreen(dpy));
	
	Window w, titlebarw;
	XSetWindowAttributes attrib_create;
	unsigned long create_mask = CWBackPixmap | CWBorderPixel |
                              CWOverrideRedirect | CWEventMask | CWBackingPixel;

	attrib_create.background_pixmap = None;
	attrib_create.override_redirect = True;
	attrib_create.event_mask = ButtonPressMask | ButtonReleaseMask |
                             ButtonMotionMask | EnterWindowMask;
	XSizeHints theSizeHints;
        XWMHints theWMHints;

	theWMHints.initial_state = NormalState;
        theWMHints.flags = StateHint;

        theSizeHints.flags = PPosition | PSize;
        theSizeHints.x = 0;//x;
        theSizeHints.y = 0;//y;
        theSizeHints.width = 800;//width;
        theSizeHints.height = 600;//height;

  	Window root_window = RootWindow(dpy, DefaultScreen(dpy));
  	int depth = DefaultDepth(dpy, DefaultScreen(dpy));
  	Visual *visual = DefaultVisual(dpy, DefaultScreen(dpy));
	w = XCreateWindow(dpy, root_window, 40, 40, 
			800, 600,
			1, depth, InputOutput,
			visual, create_mask,
			&attrib_create);
  	titlebarw = XCreateWindow(dpy, root_window, 40, 20, 
				800, 20,
				1, depth, InputOutput,
				visual, create_mask,
				&attrib_create);
	XReparentWindow(dpy, titlebarw, w, 0, 0);
	XDevWindow raywindow(&dpy,w,titlebarw);

	XSelectInput(dpy, w, StructureNotifyMask);

	XMapWindow(dpy, titlebarw);
	XMapWindow(dpy, w);

	GC gc = XCreateGC(dpy, w, 0, NIL);

	XSetForeground(dpy, gc, whiteColor);
 
  	xmantaray.initwindow(&raywindow);

	XEvent e;
  for (int k = 0; k < 100000; k++) {
	XFillRectangle(dpy, titlebarw, gc,0,0,800,20);
	XFillRectangle(dpy, w, gc,0,0,800,600);
	xmantaray.eventloop(xmantaray/*,&dpy*/,&e);
	XFlush(dpy);
  }
  sleep(20);

}

void print_usage()
{
	std::cout<<"\tbotchx [OPTIONS]\n"
		   <<std::endl;
} 
