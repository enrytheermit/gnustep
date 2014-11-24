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
#define NIL (0)

#include "XDev.h"
#include "Xmanager.h"
#include "XDevWindow.h"

static double theta = 1.5;
static double theta2 = 2.5;
static double theta3 = 3.5;
int XDev::draw2(Display **dpy, int const& k)
{
	Window w = window->getTitleWindow();
	Window w2 = window->getWindow(); 
	Window w3 = window->getClientWindow(); 
      int blackColor = 128;//BlackPixel(dpyb->dpy, DefaultScreen(dpyb->dpy));
      int whiteColor = 2048;//WhitePixel(dpyb->dpy, DefaultScreen(dpyb->dpy));

  	XSetWindowAttributes attrib_create;
  	unsigned long create_mask = CWBackPixmap | CWBorderPixel |
                              CWOverrideRedirect | CWEventMask;

  	attrib_create.background_pixmap = None;
  	attrib_create.override_redirect = True;
  	attrib_create.event_mask = ButtonPressMask | ButtonReleaseMask |
                             ButtonMotionMask | EnterWindowMask;

	XChangeWindowAttributes(*(dpyb.get_display()),w,create_mask,&attrib_create);
	XChangeWindowAttributes(*(dpyb.get_display()),w2,create_mask,&attrib_create);
	XChangeWindowAttributes(*(dpyb.get_display()),w3,create_mask,&attrib_create);
	XGCValues values;
	values.foreground = 10400;//RedPixel(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));//2048;
	values.background = 2048;
	unsigned long valuemask = GCForeground | GCBackground;
        GC gc = XCreateGC(*(dpyb.get_display()), window->getWindow(), valuemask, &values);
	return 0;
}

int XDev::draw(XDevBase& rmb)
{
	Window w = window->getWindow(); 
        GC gc = XCreateGC(*(dpyb.get_display()), window->getWindow(), 0, NIL);
	return 0;
}
//#include "widget/Button.h"
int XDev::draw3(Display **dpy, int const& k)
{
	//3D rotation code
	theta *= 2;
	theta2 *= 3;
	theta3 *= 8;
	return 0;
}

int XDev::drawsphere(Display **dpy, int const& k)
{
	Window w = window->getWindow(); 
        GC gc = XCreateGC(*(dpyb.get_display()), window->getWindow(), 0, NIL);
	return 0;
}

int XDev::drawdish(Display **dpy, int const& k)
{
	theta *= 2;

	return 0;
}

void XDev::init(DisplayBase<Display **>& dpyb2)
{
	if (dpyb2.get_display() != NULL)
		dpyb = dpyb2;
}
	
XDev::XDev(XDevBase& rmb, DisplayBase<Display **>& dpyb2) : Xmanager(), WindowManager() , XDevBaseVisit() 
{
	if (dpyb2.get_display() != NULL)
		dpyb = dpyb2;
		
  pressed = False;
  motion = False;
  dx= dy = 0;
  window = (XDevWindow *) 0;
  unsigned long gc_mask = 0;
  gc_mask = GCForeground|GCBackground|GCGraphicsExposures|GCLineWidth;
  //tully Pixel back_pix, fore_pix;
  printf("made XMantaRay Server\n");
}

XDev::~XDev() {}

void XDev::initwindow(XDevWindow *w) 
{
  	fontset = createFontSet(dpyb);
	window = w;	
}

XDevWindow& XDev::get_xdev_window()
{
  return *window;
}

void XDev::eventloop(XDevBase& rmb, XEvent *e) 
{
  #define NIL (0)
  int events;
  GC gc;
  gc = XCreateGC(*(dpyb.get_display()), window->getWindow(), 0, NIL);
  const char * test = "X11 - Music Tool and Synth";
  XmbDrawString(*(dpyb.get_display()), window->getTitleWindow(), fontset, gc, 20, 10, test, strlen(test));
  draw(*this);
  
  for (int i = 0; i < 1000; i++) {//calibrator
    if (events = XPending(*(dpyb.get_display()))) { 
      XNextEvent(*(dpyb.get_display()), e);
      printf("got event %d from number of events = %d\n", e->type, events);
	process_event(e);
	XFillRectangle(*(dpyb.get_display()), window->getTitleWindow(), gc,0,0,800,20);
	XFillRectangle(*(dpyb.get_display()), window->getWindow(), gc,0,0,800,600);
	}
	
  }
	XFlush(*(dpyb.get_display()));
}

int XDev::process_event(XEvent *e) 
{

    printf("process eventtype= %d\n", e->type);
  switch (e->type) {
  case MapRequest:{
    printf("maprequest processed: %d windows\n", (int)windows.size());
    XMapWindow(e->xany.display, window->getTitleWindow()); 
    XMapWindow(e->xany.display,window->getWindow()); 
    break;
  }
  case MotionNotify:{
    if (pressed)
      {
	XMotionEvent xm = e->xmotion;
	if (!motion)
	  {
	    x = xm.x; 
	    y = xm.y;
	    printf("x,y=%d, %d\n",xm.x,xm.y);
	  }
	dx = xm.x_root;
	dy = xm.y_root;
	window->move(&(e->xany.display), dx, dy);
	  {
	    window->move(&(e->xany.display), dx-x, dy-y);
	  }
	motion = True;
      }
    printf("motion\n");
    break;
  }
  case ButtonPress:{
    XDevWindow *win = window;//(XDevWindow *) 0;
    XButtonEvent xb = e->xbutton;
    if (xb.y < 20) 
      {
	XRaiseWindow(e->xany.display, win->getWindow());
	XRaiseWindow(e->xany.display, win->getTitleWindow());
	pressed = True;
	  {
	    init_x_root = xb.x_root;
	    init_y_root = xb.y_root;
	  }
      }   
    window->buttonpress(e->xbutton);
    printf("buttonpress\n");
    break;
  }
  case ButtonRelease:{

    if (pressed) {
      
      printf("type = %d\n", window_type);
      pressed = False;
      if (motion) {
	motion = False;
	window->move(dpyb.get_display(), dx-x, dy-y);
      }
     
      printf("buttonrelease\n");
    }

    break;
  }
  default:
    break;
  }//tully
  return 1;
}

void XDev::positionWindow(Display **dpy, XDevWindow *win)
{
  if (!windows.empty())
    {
      
      struct rect *free_rects[512]; //calculate size here instaed of 512
      struct rect *window_rects[windows.size()]; //was struct rect* but bugged could be that sorting doesnt work right
      
      int display_width = DisplayWidth(*(dpyb.get_display()),screen);
      int display_height = DisplayHeight(*(dpyb.get_display()), screen);
      int win_x = win->getx();
      int win_y = win->gety();
      int win_width = win->getWidth();
      int win_height = win->getHeight();
      
      std::list<XDevWindow *>::iterator first = windows.begin();
      std::list<XDevWindow *>::iterator last = windows.end();
      for (int i = 0; first != last; i++)
	{
	  std::list<XDevWindow *>::iterator next = first;
	  ++next;
	  window_rects[i] = (struct rect *) malloc(sizeof(struct rect));
	  window_rects[i]->x = (*first)->getx();
	  window_rects[i]->y = (*first)->gety();
	  window_rects[i]->w = (*first)->getWidth();
	  window_rects[i]->h = (*first)->getHeight();
	  window_rects[i]->x_right = window_rects[i]->x + window_rects[i]->w;
	  window_rects[i]->y_right = window_rects[i]->y + window_rects[i]->h;
	  window_rects[i]->surface = (*first)->getWidth()*(*first)->getHeight();
	  first= next;
	  printf("x=%d of %p  ",(int)window_rects[i]->x, &(window_rects[i]->x));
	}
      //sort the windows so that they appear from left to right
      qsort(&window_rects, windows.size(), sizeof(struct rect *), &compare_x);//maybe need also a y sort
      
      //get free rects ..      
      printf("\nsorted:");
      int j = 0;      
      free_rects[j] = (struct rect *) malloc(sizeof(struct rect));
      for(int k = 0; k < windows.size(); k++)
	{
	  printf("x=%d ",window_rects[k]->x);
	  //..left of the window
	  if (window_rects[k]->x != 0)
	    {
	      for (int l = 0; l < k; l++)
		{
		  if ( k == 0) //leftmost window
		    {
		      free_rects[j]->x = 0;
		      free_rects[j]->y = 0;
		      free_rects[j]->w = window_rects[k]->x;
		      free_rects[j]->h = display_height;
		      free_rects[j]->x_right = window_rects[k]->x;
		      free_rects[j]->y_right = display_height;
		      j +=1;
		      free_rects[j] = (struct rect *) malloc(sizeof(struct rect));
		     
		    }
		  else  // not overlapping
		    {
		      int rightmost_x = 0;
		      //doesnt' take into account yet: windows who have their m->y_right between k->y k->y_right which would create 2 free rects
		      for (int m = 0; m < k; m++) //what about <= ?
			{//check if there's a window to the left
			  if (window_rects[m]->x_right > rightmost_x  && 
			      window_rects[m]->x_right < window_rects[k]->x &&
			      window_rects[m]->y_right > window_rects[k]->y)
			    {rightmost_x = window_rects[m]->x_right; }
			}
		      free_rects[j]->x = rightmost_x; 
		      free_rects[j]->w = window_rects[k]->x - rightmost_x;
		      free_rects[j]->x_right = free_rects[j]->x + free_rects[j]->w;
		      int lowest_y = 0;
		      for (int m = 0; m < k; m++)
			{//check if there is any window in between above
			  if (window_rects[m]->x_right > rightmost_x &&
			      window_rects[m]->y_right < window_rects[k]->y)
			    {
			      lowest_y = window_rects[m]->y_right;
			    }
			}
		      free_rects[j]->y = lowest_y;
		      int height = display_height;
		      for (int m = 0; m < k; m++)
			{//check if there is any window in between below 
			  if (window_rects[m]->x_right > rightmost_x &&
			      window_rects[m]->y > window_rects[k]->y_right &&
			      window_rects[m]->y < height)
			    {
			      height = window_rects[m]->y;
			    }
			}
		      free_rects[j]->h = height;
		      free_rects[j]->y_right = free_rects[j]->y + free_rects[j]->h;
		    }
		  
		  }
	    }
	  //..above the window 
	  //..under the window
	  //..right of the window
	}
      // insert win in the first (make it smallest) free rectangle
      for (int m = 0; m <= j; m++)
	{
	  printf("h = %d w = %d ", free_rects[m]->h, free_rects[m]->w);
	  if (free_rects[m]->h >= win_height && free_rects[m]->w >= win_width)
	    {
	      win->move(dpyb.get_display(), free_rects[m]->x, free_rects[m]->y);
	      return;
	    }
	}
      
    }
}

void XDev::drawString(Display** dpy, Window &w, GC gc, int xx, int yy, const char*text)
{
  //  GC gc;
  //gc = XCreateGC(*(dpyb.get_display()), window->getWindow(), 0, NIL);
  //const char * text0 = text;
  
  XmbDrawString(*(dpyb.get_display()), window->getTitleWindow(), fontset, gc, xx, yy, text, strlen(text));
}


// tully
Pixel XDev::GetColor(Display **dpy, char *name)
{
  XColor color;
  XWindowAttributes attributes;

  XGetWindowAttributes(*(dpyb.get_display()),getRootWindow(),&attributes);
  color.pixel = 0;
   if (!XParseColor (*(dpyb.get_display()), attributes.colormap, name, &color)) 
     {
       printf("parse no color");
     }
   else if(!XAllocColor (*(dpyb.get_display()), attributes.colormap, &color)) 
     {
       printf("parse no color");
     }
  return color.pixel;
}


int compare_x(const void * a, const void * b)
{
  printf("compare_x a.x %d ",*((int *)((struct rect *)a)->x));
  
  if (*((int *)((struct rect *)a)->x) < *((int *)((struct rect *)b)->x))
    {return -1;}
  else if (*((int *)((struct rect *)a)->x) > *((int *)((struct rect *)b)->x))
    {return 1;}
  else
    {return 0;}
  
}

