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

/*
 From esdcat.c from esound
*/

//tully #include "XDev.h"
#include "ESDCache.h"
#include "../esound/esd.h"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/stat.h>


namespace sound
{

  ESDCache::ESDCache()
  {
  }

  ESDCache::~ESDCache()
  {}
  
  void ESDCache::cacheSample(string filename)
  {
    ESDSample *sample = new ESDSample(filename);
    sample->readinSample();
    _samples[filename] = sample;
  }

  ESDSample *ESDCache::getSample(string filename)
  {
    return _samples[filename];
  }
  /*
  ESDSample *ESDCache::getSampleNumber(int n)
  {
    return _samples
      }
  */
}//namespace sound
