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
#ifndef ESDSAMPLE_H
#define ESDSAMPLE_H

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>

#include <vector>
#include <string>
#include "../esound/esd.h"

using namespace std;

namespace sound
{

const  int BUF_MAX = 4096;
class ESDSample
{
 public:
  ESDSample();
  ESDSample(string filename);
  virtual ~ESDSample();

  uint32_t swap_endian(uint32_t n); 
  void readinSample();
  int play_file_audiofile (string fn, string fn2);
  void playSample();
  void playSampleSampled();

 protected:
  //char ***get_buffer();
 char _buffer[ESD_BUF_SIZE * BUF_MAX];
 int nbytes;//, ntimes;
 vector<int> _lengths;
 string get_filename();
 private:
  string _filename;
  double rate;
  int ratediv, nchannels;  
};

// static char ESDSample::_buffer = (char **)0;

}//namespace sound
#endif
