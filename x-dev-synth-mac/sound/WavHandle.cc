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

#include "WavHandle.h"
#include "../esound/esd.h"

#include <iostream>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/stat.h>
#include <fcntl.h>

namespace sound
{

  WavHandle::WavHandle()
  {}

  WavHandle::~WavHandle()
  {}

  AFfilehandle& WavHandle::get()
  {
	return handle;
  }

  void WavHandle::initread(string& fn, WavSetup& setup)
  {
        handle = afOpenFile(fn.c_str(), "r", setup.get());
  }

  void WavHandle::initwrite(string& fn, WavSetup& setup)
  {
        handle = afOpenFile(fn.c_str(), "w", setup.get());
  }

  AFframecount WavHandle::read(int filelen)
  { 
	AFfileoffset dataoffset = afGetDataOffset(handle, AF_DEFAULT_TRACK);
	////std::cout << "dataoffset=" << dataoffset << std::endl;
	///int16_t readData[filelen];
	readData = new int16_t[filelen];	
	return afReadFrames(handle, AF_DEFAULT_TRACK, &*readData, filelen-dataoffset);
  }

  int16_t* WavHandle::getreaddata()
  {
	return readData;
  };
  
}
