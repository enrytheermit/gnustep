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
#ifndef LABELBUTTONWIDGET_H
#define LABELBUTTONWIDGET_H
#include <X11/Xlib.h>

#include "Button.h"
#include "../sound/WavFilename.h"
class LabelButtonManipulator;
class LabelButtonWidget : public ButtonWidget {

public:
  //ctors
  LabelButtonWidget(DisplayBase<Display **>& dpyb, WidgetWindowManipulator* wm, char *text); 
  ~LabelButtonWidget();

  //layout adaption : super class
  char *get_textcolor();
  void set_textcolor(char *s);

  LabelButtonManipulator *createLabelButtonManipulator(sound::WavFilename& fn1, sound::WavFilename& fn2);
  //other methods
  void decorate(Display **dpy, Window& w, GC& gc, int x1, int y1, int x2 ,int y2);
  void show(Display **dpy, Window& w);

  void drawString(Display**dpy, Window& w, GC& gc, int xx, int yy);
  XFontSet createFontSet(DisplayBase<Display **>& dpyb);
  void set_manipulator(LabelButtonManipulator* man);

  virtual void buttonpress(XButtonEvent& e);

 private:
  XFontSet fontset;
  char *_text;
  char *_textcolor;
  LabelButtonManipulator *_labelbuttonmanipulator;
};
#endif

