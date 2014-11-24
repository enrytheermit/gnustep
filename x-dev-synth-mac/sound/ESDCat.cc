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
//tully #include "XDev.h"
#include "ESDCat.h"
#include "../esound/esd.h"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/stat.h>


namespace sound
{

  ESDCat::ESDCat()
  {
  }

  ESDCat::~ESDCat()
  {}

  void ESDCat::addSample(string filename)
  {
    _cache.cacheSample(filename);
  }  

  void ESDCat::playSampleNumber(int n)
  {
    // _cache.getSample(
  }  

  void ESDCat::playSampleFilename(string filename)
  {
    ESDSample *sample = _cache.getSample(filename);
    //playSample(sample->get_buffer());
    sample->playSample();
  }  



    void ESDCat::esdcat(string filename)
  {
    char buf[ESD_BUF_SIZE];
    int sock = -1, rate = ESD_DEFAULT_RATE;
    int length = 0, arg = 0;

    int bits = ESD_BITS16, channels = ESD_STEREO;
    int mode = ESD_STREAM, func = ESD_PLAY ;
    esd_format_t format = 0;

    FILE *source = NULL;
    char *host = NULL;
    char *name = NULL;
    
    if ( (source = fopen( filename.c_str(), "r" )) == NULL ) {
      printf( ": couldn't open sound file: %s\n", filename.c_str());
      return;
    }

    
    /* use stdin if no file specified */
    if (!source) {
	source = stdin;
    }

    format = bits | channels | mode | func;
    printf( "opening socket, format = 0x%08x at %d Hz\n", 
	    format, rate );
   
    /* sock = esd_play_stream( format, rate ); */
    //tully sock = esd_play_stream_fallback( format, rate, host, name );
    if ( sock <= 0 ) 
	return;
    
    while ( ( length = fread( buf, 1, ESD_BUF_SIZE, source ) ) > 0 )
    {
	/* fprintf( stderr, "read %d\n", length ); */
	if ( write( sock, buf, length ) <= 0 ) 
	    return;
    }
    close( sock );

    return;


  }
}//namespace sound
