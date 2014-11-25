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
#include "ESDSample.h"
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

  ESDSample::ESDSample(string filename)
    :_filename(filename), nbytes(0)//, ntimes(0)//, _buffer(NULL)
  {

  }

  ESDSample::ESDSample()
  {}

  ESDSample::~ESDSample()
  {}

  uint32_t ESDSample::swap_endian(uint32_t n) 
  {
	union {
		uint32_t u;
		unsigned char u8[sizeof(uint32_t)];
	} source, dest;

	source.u = n;
	for (int i; i < sizeof(uint32_t); i++)
		dest.u8[i] = source.u8[sizeof(uint32_t) - i - 1];

	return dest.u;
  } 
  int ESDSample::play_file_audiofile (string fn, string fn2)
  {
	int infd, outfd;
	FILE *ifd = fopen(fn.c_str(), "r");
	int t;

	fseek(ifd, 0L, SEEK_END);
	t = ftell(ifd);

	fclose(ifd);

	std::cout << "input filelen = " << t << std::endl;

        const int kFrameCount = 500;
        const int kSampleCount = 2 * kFrameCount;

        int16_t data[kSampleCount];
        int16_t readData[kSampleCount];

	int i;
        for (i=0; i<kSampleCount; i++)
                data[i] = 3*i + 2;

        AFfilesetup setup = afNewFileSetup();

        //ASSERT_TRUE(setup);
        afInitFileFormat(setup, AF_FILE_RAWDATA);
        afInitSampleFormat(setup, AF_DEFAULT_TRACK, AF_SAMPFMT_TWOSCOMP, 16);
        afInitChannels(setup, AF_DEFAULT_TRACK, 1);
        afInitRate(setup, AF_DEFAULT_TRACK, 44100);

	AFfilehandle handle;

        handle = afOpenNamedFD(infd, "r", setup, "./sounds/test.wav");
        AFframecount framesRead;

	int fileformat = afGetFileFormat(handle, NULL);
	std::cout << "fileformat=" << fileformat << std::endl;
	double rate = afGetRate(handle, AF_DEFAULT_TRACK);
	std::cout << "rate=" << rate << std::endl;

/***
	AFframecount framecount = afGetFrameCount(handle, AF_DEFAULT_TRACK);
	std::cout << framecount << std::endl;
	AFfileoffset fileoffset = afGetTrackBytes(handle, AF_DEFAULT_TRACK); 
	std::cout << fileoffset << std::endl;
	AFfileoffset dataoffset = afGetDataOffset(handle, AF_DEFAULT_TRACK);
	std::cout << dataoffset << std::endl;
***/	
	int nativeByteOrder;

#ifdef WORDS_BIGENDIAN
        nativeByteOrder = AF_BYTEORDER_BIGENDIAN;
#else
        nativeByteOrder = AF_BYTEORDER_LITTLEENDIAN;
#endif   
	if (afGetByteOrder(handle, AF_DEFAULT_TRACK) == nativeByteOrder)
                std::cout << "test file not in native byte order" <<std::endl;

	framesRead = afReadFrames(handle, AF_DEFAULT_TRACK, readData, kFrameCount);
                "Data read does not match data written";
        if (!::memcmp(readData, data, kFrameCount * sizeof (int16_t)))
                std::cout << "Data read does not match data written";


        AFfilehandle outhandle;
/***
        outhandle = afOpenFile(fn2.c_str(), "w", setup);
        AFframecount framesWritten;
        framesWritten = afWriteFrames(outhandle, AF_DEFAULT_TRACK, readData, kFrameCount);
***/

	int dataFramesCount = (t - i) / 2;	
        //int16_t writeData[dataFramesCount];
        AFframecount framesWritten = afWriteFrames(outhandle, AF_DEFAULT_TRACK, readData, dataFramesCount);

        afCloseFile(handle);
        afCloseFile(outhandle);

        //ASSERT_EQ(afCloseFile(handle), 0);

        afFreeFileSetup(setup);  
  /* convert audiofile parameters to EsounD parameters */
  /****
  if (in_width == 8)
    out_bits = ESD_BITS8;
  else if (in_width == 16)
    out_bits = ESD_BITS16;
  else
    {
      fputs ("only sample widths of 8 and 16 supported\n", stderr);
      return 1;
    }

  bytes_per_frame = (in_width  * in_channels) / 8;

  if (in_channels == 1)
    out_channels = ESD_MONO;
  else if (in_channels == 2)
    out_channels = ESD_STEREO;
  else
    {
      fputs ("only 1 or 2 channel samples supported\n", stderr);
      return 1;
    }

  out_format = out_bits | out_channels | out_mode | out_func;

  out_rate = (int) in_rate;

  //tullyout_sock = esd_play_stream_fallback (out_format, out_rate, NULL, (char *) fn.c_str());
  if (out_sock <= 0)
    return 1;
  ****/
  /* play */
  /****
  buf_frames = ESD_BUF_SIZE / bytes_per_frame;

  //  char rbuf[ESD_BUF_SIZE][4096];
  vector<int> _lens;
  vector<char*> _bytes;
  int i;
  while ((frames_read = afReadFrames(in_file, AF_DEFAULT_TRACK, 
				    buf, buf_frames)))
    {
      printf("frames read, bytes_per_frame : %d, %d\n", frames_read, bytes_per_frame);   

      //int ii;
      //while (ii++ < 1024)
      //buf[ii] &= 256;

      bytes_written += frames_read * bytes_per_frame;
      //memcpy(rbuf[i], buf, frames_read * bytes_per_frame);
      _bytes.push_back((char *)buf);
      _lens.push_back(frames_read);
      i++;
    }
  int j;
  //while (j < (bytes_written / bytes_per_frame)) {
  //printf("frames written, bytes_per_frame : %d, %d\n", j, bytes_per_frame);   
  while (write (out_sock, _bytes[j], _lens[j])) {
    printf("error writing to esd!");
    //      if (write (out_sock, buf, _lens[j]) <= 0)
    return 1;
  }
  j++;
  //}

  close (out_sock);

  if (afCloseFile (in_file))
    return 1;

  printf("bytes_written = %d\n", bytes_written);
  ****/
  return 0;
}

  //////////////////////////////////////////////////////////

  void ESDSample::readinSample()
  {
    FILE *source;
    char buf[ESD_BUF_SIZE];
    int length = 0;

    if ( (source = fopen( _filename.c_str(), "r" )) == NULL ) {
      printf( "%s: couldn't open sound file\n", _filename.c_str());
      return;
    }

    int i,j;
    char *b = _buffer;
    while ( ( length = fread( buf, 1, ESD_BUF_SIZE, source ) ) > 0 )
    {
	/* fprintf( stderr, "read %d\n", length ); */
	//if ( write( sock, buf, length ) <= 0 ) 
	//    return;
      /*
      if (length < ESD_BUF_SIZE) {
	memcpy(_buffer, b, length);
	b += length;
      } else {
	memcpy(_buffer, b, ESD_BUF_SIZE);
	b += ESD_BUF_SIZE;
      }
	b += ESD_BUF_SIZE;
	_lengths.push_back(length);
	j = length;
	i += j;
      */
	
      j = 0;

      if (length < ESD_BUF_SIZE) {

	while (j < length ) {
	  
	  _buffer[j+i] = buf[j];
	  j++;
	  _lengths.push_back(length);
	}
	i += j;
      } else if (length == ESD_BUF_SIZE) {
	while (j < ESD_BUF_SIZE) {
	  _buffer[j+i] = buf[j];
	  j++;
	  _lengths.push_back(ESD_BUF_SIZE);
	}
	i += ESD_BUF_SIZE;
	
      }

    }
    nbytes = i - ESD_BUF_SIZE + length;
    //ntimes = j;
    printf("***N=%d", nbytes);
  }

  void ESDSample::playSampleSampled()
  {
    /*
    int sock = -1, rate = ESD_DEFAULT_RATE;
    int length = 0, arg = 0;

    int bits = ESD_BITS16, channels = ESD_STEREO;
    int mode = ESD_STREAM, func = ESD_PLAY ;
    esd_format_t format = 0;

    char *host = NULL;
    char *name = NULL;
    
    struct stat source_stats;

    format = bits | channels | mode | func;
    printf( "opening socket, format = 0x%08x at %d Hz\n", 
	    format, rate );
   
    // sock = esd_play_stream( format, rate ); 
    //sock = esd_play_stream_fallback( format, rate, host, name );
    //tully sock = esd_open_sound( host );
    if ( sock <= 0 ) 
	return;
    stat( name, &source_stats );
    printf("***Caching sample\n");
    //int sample_id = esd_sample_cache( sock, format, rate, source_stats.st_size, get_filename().c_str() );
    int sample_id = esd_file_cache( sock, get_filename().c_str(), name );
    printf("***Playing sample\n");

    esd_sample_play( sock, sample_id );

    esd_sample_free( sock, sample_id );
    *//*****
    int i,j;
    int n = nbytes % ESD_BUF_SIZE;
    //while ( ( length = fread( buf, 1, ESD_BUF_SIZE, source ) ) > 0 )

    char *b = _buffer;
    char buf[ESD_BUF_SIZE];
    while (i < (nbytes - n)) {
      
      memcpy(buf, b, ESD_BUF_SIZE);
      
      if ( write( sock, buf, ESD_BUF_SIZE ) <= 0 ) 
	return;

      b += ESD_BUF_SIZE;
      i += ESD_BUF_SIZE;
    }
    memcpy(buf, b, n);
      
    if ( write( sock, buf, n ) <= 0 ) 
	return;

    
      ***/
    //close( sock );
    
  }

  void ESDSample::playSample()
  {

    int sock = -1, rate = ESD_DEFAULT_RATE / 16;// tully
    int length = 0, arg = 0;

    int bits = ESD_BITS16 / 16, channels = ESD_STEREO;//tully / 16
    int mode = ESD_STREAM, func = ESD_PLAY ;
    esd_format_t format = 0;

    char *host = NULL;
    char *name = NULL;
    
    format = bits | channels | mode | func;
    printf( "opening socket, format = 0x%08x at %d Hz\n", 
	    format, rate );
   
    //sock = esd_play_stream( format, rate , host, get_filename().c_str()); 
    //tully sock = esd_play_stream_fallback( format, rate, host, NULL);//get_filename().c_str() );
    if ( sock <= 0 ) 
	return;

    printf("***Playing sample\n");
    int i,j;
    int n = nbytes % ESD_BUF_SIZE;
    //while ( ( length = fread( buf, 1, ESD_BUF_SIZE, source ) ) > 0 )

    char *b = _buffer;
    
    while (i < (nbytes - n)) {
      
      char buf[ESD_BUF_SIZE];
      memcpy(buf, b, _lengths[j]);
      //if ( write( sock, buf, length ) <= 0 ) 
      if ( write( sock, buf, ESD_BUF_SIZE ) <= 0 ) 
	return;
      
      b += ESD_BUF_SIZE;
      i += ESD_BUF_SIZE;
      j++;

      printf("written %d \n", i);
    }
    char buf2[ESD_BUF_SIZE];
    memcpy(buf2, b, _lengths[j]);
      
    if ( write( sock, buf2, n ) <= 0 ) 
	return;
    printf("written %d \n", n);
    close( sock );

  }

  /***
  void ESDSample::playSampleSampled()
  {

    int sock = -1, rate = ESD_DEFAULT_RATE;
    int length = 0, arg = 0;

    int bits = ESD_BITS16, channels = ESD_STEREO;
    int mode = ESD_STREAM, func = ESD_PLAY ;
    esd_format_t format = 0;

    char *host = NULL;
    char *name = NULL;
    
    format = bits | channels | mode | func;
    printf( "opening socket, format = 0x%08x at %d Hz\n", 
	    format, rate );
   
    
    //tully sock = esd_play_stream_fallback( format, rate, host, name );
    if ( sock <= 0 ) 
	return;

    printf("***Playing sample\n");
    int i,j;
    int n = nbytes % ESD_BUF_SIZE;
    //while ( ( length = fread( buf, 1, ESD_BUF_SIZE, source ) ) > 0 )

    char *b = _buffer;
    char buf[ESD_BUF_SIZE];
    while (i < (nbytes - n)) {
      
      memcpy(buf, b, ESD_BUF_SIZE);
      
      if ( write( sock, buf, ESD_BUF_SIZE ) <= 0 ) 
	return;

      b += ESD_BUF_SIZE;
      i += ESD_BUF_SIZE;
    }
    memcpy(buf, b, n);
      
    if ( write( sock, buf, n ) <= 0 ) 
	return;



    close( sock );

  }
***/
  string ESDSample::get_filename()
  {
    return _filename;
  }

  /*
  char **ESDSample::get_buffer()
  {
    return &_buffer;
    }*/
}//namespace sound
