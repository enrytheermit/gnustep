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
#include "Callbacks.h"
//#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "../sound/ESDSample.h"
#include "../sound/ESDCat.h"
#include "../sound/WavFilename.h"

void *playcallback(void *arg1, void *arg2)
{
  printf("playing sound...\n");

  sound::ESDSample *sample = new sound::ESDSample;
  sample->play_file_audiofile((sound::WavFilename*)arg1, (sound::WavFilename*)arg2);

}
