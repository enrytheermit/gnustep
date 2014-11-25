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
#include "SynthWindow.h"
#include <iostream>
#include <cmath>
#include "Callbacks.h"

#define NIL (0)

SynthWindow::SynthWindow(DisplayBase<Display **>& dpyb, Window& w, Window& title) 
  : XDevWidgetWindow(dpyb, w, title), _widgettree(NULL), _inwavfile("./sounds/test.wav"), _outwavfile("./sounds/out.wav")
{

  printf("creating SynthWindow..\n");
}

SynthWindow::~SynthWindow()
{
  printf("SynthWindow destroyed.\n");
}

void SynthWindow::init(DisplayBase<Display**>& dpyb, XDev& xdev0)
{


  WidgetWindowManipulator *wm = createwidgetmanipulator(xdev0);
  
  //Window
  WindowWidget *windowwidget = new WindowWidget(dpyb, wm);

  //init widget tree
  _widgettree = new WidgetTree(windowwidget);
  //Play button
  LabelButtonWidget *playbutton;
  playbutton = new LabelButtonWidget(dpyb, wm, "Play"); 
  playbutton->set_locus(0,32);
  playbutton->set_size(48,48);

  _labelbuttonmanipulator = playbutton->createLabelButtonManipulator(this->getinwavfile(), this->getoutwavfile());
  playbutton->set_manipulator(_labelbuttonmanipulator);

  char *bc = (char *)malloc(256);
  char *tc = (char *)malloc(256);
  sprintf(bc, "%s", "darkblue\0");
  sprintf(tc, "%s", "orange\0");
  playbutton->set_buttoncolor(bc);
  playbutton->set_textcolor(tc);

  playbutton->setCallback(&playcallback);

  _widgettree->addWidget(playbutton);

  //Stop button
  LabelButtonWidget *stopbutton;
  stopbutton = new LabelButtonWidget(dpyb, wm, "Stop"); 
  stopbutton->set_locus(0+50,32);
  stopbutton->set_size(48,48);
  char *bc2 = (char *)malloc(256);
  char *tc2 = (char *)malloc(256);
  sprintf(bc2, "%s", "darkblue\0");
  sprintf(tc2, "%s", "orange\0");
  stopbutton->set_buttoncolor(bc);
  stopbutton->set_textcolor(tc);
  _widgettree->addWidget(stopbutton);

  set_windowwidget(windowwidget);
}

sound::WavFilename& SynthWindow::getinwavfile()
{
	return _inwavfile;
}

sound::WavFilename& SynthWindow::getoutwavfile()
{
	return _outwavfile;
}


void SynthWindow::decorate(DisplayBase<Display**>& dpyb, Window& w, GC gc)
{
  drawline(dpyb.get_display(), w, 50, 0, 400 , 400);
  get_windowwidget()->show(dpyb.get_display(), w);
  //_playbutton->show((dpyb.get_display()), w);
}

/*
void SynthWindow::drawsphere(Window const& w)
{
}
*/
void SynthWindow::drawline(Display **dpy, Window& w, int x1, int y1, int x2 ,int y2)
{
  XGCValues values;
  values.foreground = 10400;//RedPixel(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));//2048;
  values.background = 2048;
  unsigned long valuemask = GCForeground | GCBackground;
  GC gc = XCreateGC(*dpy, w, valuemask, &values);
  

  //GC gc = XCreateGC(*dpy, w, 0, NIL);
  XDrawLine(*dpy,w,gc,x1,y1,x2,y2);
}

void SynthWindow::buttonpress(XButtonEvent &e)
{
  get_windowwidget()->buttonpress(e);
}

void SynthWindow::motion()
{

}
