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
#ifndef SYNTHWIDGETWINDOW_H
#define SYNTHWIDGETWINDOW_H
#include <X11/Xlib.h>
#include "../widgets/XDevWidgetizedWindow.h"
//#include "WidgetWindowManipulator.h"

#include "../widgets/LabelButton.h"
#include "../widgets/WindowWidget.h"
#include "../widgets/WidgetTree.h"
#include "../widgets/LabelButtonManipulator.h"

class SynthWindow : public XDevWidgetWindow {

public:

  SynthWindow(DisplayBase<Display **>& dpyb, Window& w, Window& title);
  ~SynthWindow();

  //  virtual void set_xdev(XDev& xdev);
  virtual void init(DisplayBase<Display**>& dpyb, XDev& xdev);

  //virtual void drawsphere(Window w); 
  virtual void drawline(Display **dpy, Window& w, int x1, int y1, int x2 ,int y2);
  void decorate(DisplayBase<Display**>& dpyb, Window& w, GC gc);
  virtual void buttonpress(XButtonEvent &e); 
  virtual void motion();

 private:
  WidgetTree *_widgettree;
  LabelButtonManipulator *_labelbuttonmanipulator;

  sound::WavFilename& getinwavfile();
  sound::WavFilename& getoutwavfile();

  sound::WavFilename _inwavfile;
  sound::WavFilename _outwavfile;
  //tully  WindowWidget *_windowwidget;
}; //class XDevWindow
#endif

