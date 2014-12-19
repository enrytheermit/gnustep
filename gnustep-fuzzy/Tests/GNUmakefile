# 
#    GNUmakefile gnustep-fuzzy tests
# 
#    Copyright (C) 2014 Free Software Foundation, Inc.
# 
#    Author: Johan Ceuppens <johan@yellowcouch.org>
#    Date: Dec 2014 
# 
#    This file is part of GNUstep.
# 
#    This library is free software; you can redistribute it and/or
#    modify it under the terms of the GNU Lesser General Public
#    License as published by the Free Software Foundation; either
#    version 2 of the License, or (at your option) any later version.
# 
#    This library is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
#    Lesser General Public License for more details.
# 
#    You should have received a copy of the GNU Lesser General Public
#    License along with this library; see the file COPYING.LIB.
#    If not, see <http://www.gnu.org/licenses/> or write to the
#    Free Software Foundation, 51 Franklin Street, Fifth Floor,
#    Boston, MA 02110-1301, USA.
# 
# Include the common variables defined by the Makefile Package
include $(GNUSTEP_MAKEFILES)/common.make

# Two libraries
PACKAGE_NAME = GSFuzzyTest
APP_NAME = GSFuzzyTest 
#
GSFuzzyTest_INCLUDE_DIRS = ../Headers
GSFuzzyTest_LDFLAGS = -L../obj -lgnustepfuzzy
GSFuzzyTest_ADDITONAL_INCLUDE_DIRS = 
#
# The files for the GSFuzzyTest
#
# The Objective-C files to compile
GSFuzzyTest_OBJC_FILES = \
 FuzzyUpdateTestDTree.m \

# FuzzyPaintTestRules.m \
# The C source files to be compiled
GSFuzzyTest_C_FILES = 

# The PostScript wrap source files to be compiled
GSFuzzyTest_PSWRAP_FILES = 

# The header files for the library
GSFuzzyTest_HEADER_FILES_DIR = ../Headers
GSFuzzyTest_HEADER_FILES_INSTALL_DIR = fuzzytests 
GSFuzzyTest_HEADER_FILES = \
 FuzzyPaintTestRules.h \
 FuzzyUpdateTestDTree.h \

GSFuzzyTest_OBJC_FILES += \
main.m

-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/aggregate.make
include $(GNUSTEP_MAKEFILES)/application.make
-include GNUmakefile.postamble
