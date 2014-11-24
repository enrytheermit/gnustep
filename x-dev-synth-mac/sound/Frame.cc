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
#include "Frame.h"

namespace sound
{

Frame::Frame()
	: _length(64)
{
}

Frame::Frame(int const& nbits)
	: _length(nbits)
{

}

Frame::~Frame()
{}

bool Frame::writeAscii(std::string const& bytestring)
{
	for (int i = 0; i < _length / sizeof(BYTE); i++)
		*_p++ = bytestring[i];
	return (rewind());
}	

int Frame::rewind()
{
	_p -= _length / sizeof(BYTE);
	return *_p;
}

}//namespace sound
