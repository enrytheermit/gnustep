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
#ifndef LABELBUTTONMANIPULATOR_H
#define LABELBUTTONMANIPULATOR_H
#include <X11/Xlib.h>

#include "../sound/WavFilename.h"

class LabelButtonManipulator {

public:
  //ctors
  LabelButtonManipulator(sound::WavFilename& fn1, sound::WavFilename& fn2); 
  ~LabelButtonManipulator();

   sound::WavFilename& getinwavfile();
   sound::WavFilename& getoutwavfile();
 private:
   sound::WavFilename _inwavfilename;
   sound::WavFilename _outwavfilename;
};
#endif

