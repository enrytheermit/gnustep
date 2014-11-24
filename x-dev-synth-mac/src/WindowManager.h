/*
 Copyright (C) Enry the Ermit 2010-2014
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
#ifndef WINDOWMANAGER_H
#define WINDOWMANAGER_H
#include <stdio.h>
#include <X11/Xlib.h>
#include <list>
class XDevWindow;

class WindowManager {
 protected:
  std::list<XDevWindow *> windows;
  
 public:
  WindowManager();
  ~WindowManager();
}; //class WindowManager


#endif
