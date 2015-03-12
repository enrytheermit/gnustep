# 
#    GNUmakefile gnustep-fuzzy
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
LIBRARY_NAME = libgnustepfuzzy

#
libgnustepfuzzy_INCLUDE_DIRS = Headers
libgnustepfuzzy_ADDITONAL_INCLUDE_DIRS = 
#
# The files for the libgnustepfuzzy library
#
# The Objective-C files to compile
libgnustepfuzzy_OBJC_FILES = \
 Source/FuzzyPaintParser.m \
 Source/FuzzyParser.m \
 Source/FuzzyPredicate.m \
 Source/FuzzyPredicateSet.m \
 Source/FuzzyVisitor.m \
 Source/FuzzyNetwork.m \
 Source/FuzzyNode.m \
 Source/Fuzzy.m \
 Source/FuzzyDB.m \
 Source/FuzzyManipulator.m \
 Source/FuzzyPaintRuleSystem.m \
 Source/FuzzyRuleSystem.m \
 Source/FuzzyDTree.m \
 Source/FuzzyInference.m \

# The C source files to be compiled
libgnustepfuzzy_C_FILES =

# The PostScript wrap source files to be compiled
libgnustepfuzzy_PSWRAP_FILES = 

# The header files for the library
libgnustepfuzzy_HEADER_FILES_DIR = Headers
libgnustepfuzzy_HEADER_FILES_INSTALL_DIR = fuzzy 
libgnustepfuzzy_HEADER_FILES = FuzzyDB.h \
 Fuzzy.h \
 FuzzyManipulator.h \
 FuzzyNetwork.h \
 FuzzyNode.h \
 FuzzyPaintParser.h \
 FuzzyPaintRuleSystem.h \
 FuzzyParser.h \
 FuzzyPredicate.h \
 FuzzyDTree.h \
 FuzzyInference.h \
 FuzzyVisitor.h \

# Option include to set any additional variables
-include GNUmakefile.preamble

# Include in the rules for making libraries
include $(GNUSTEP_MAKEFILES)/library.make

# Option include to define any additional rules
-include GNUmakefile.postamble
