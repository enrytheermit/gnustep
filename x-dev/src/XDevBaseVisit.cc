/*
 Copyright (C) Enry the Ermit 2011

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
#include "XDevBaseVisit.h"

void DisplayBaseVisit::accept(XDevBaseVisit& rmb)
{ 
	rmb.visit(*this);
}

	//virtual void draw
void XDevBaseVisit::visit(DisplayBase<Display **>& dpyb) { 

	if (DisplayBaseVisit* rm = dynamic_cast<DisplayBaseVisit*>(&dpyb)) {
	//FIXME1	draw(*this);
	} else {
		return;
	} 
}

