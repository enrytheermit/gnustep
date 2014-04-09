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
#ifndef __BASE_H_H
#define __BASE_H_H
#include <X11/Xlib.h>

struct XDevBase {
	virtual void eventloop(XDevBase&,XEvent *e) = 0;
  	virtual int process_event(XEvent *) = 0;
//derive	virtual void visit(DisplayBase<> dpyb) = 0; 
};
template <class T>
class DisplayBase {
public:
	DisplayBase() { dpy = NULL; }
	DisplayBase(T dpy2) { dpy = dpy2; }
	virtual ~DisplayBase() {}
	inline virtual T get_display() { return dpy; }
//derive	void accept(XDevBase rmb) { rmb.visit(this); }
protected:
	T dpy;
};

class XDevBaseVisit;
class DisplayBaseVisit : public DisplayBase<Display **> {

	virtual void accept(XDevBaseVisit& rmb);
};

struct XDevBaseVisit : public XDevBase {

	//virtual void draw
	virtual void visit(DisplayBase<Display **>& dpyb); 
};
	
#endif
