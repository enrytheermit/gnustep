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
#ifndef ESDCAT_H
#define ESDCAT_H

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>

#include <string>

using namespace std;

#include "ESDCache.h"

namespace sound
{
class ESDCat
{
 public:
  ESDCat();
  virtual ~ESDCat();
 
  void addSample(string filename);

  void playSample(char *buffer);
  void playSampleFilename(string filename);
  void playSampleNumber(int n);
  void esdcat(string filename);
 private:
  ESDCache _cache;
};

}//namespace sound
#endif
