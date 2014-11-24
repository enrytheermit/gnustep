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
#ifndef FRAME_H
#define FRAME_H

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/xpm.h>

#include <string>

namespace sound
{

typedef char BYTE;

class Frame
{
	public:
		Frame();
		Frame(int const& nbits);
		virtual ~Frame();

	protected:

		int _length;
		BYTE *_p;					
	public:
		bool writeAscii(std::string const& bytestring);

	private:
		int rewind();
};

}//namespace sound
#endif
