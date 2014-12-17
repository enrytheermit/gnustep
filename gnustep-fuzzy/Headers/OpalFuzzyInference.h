 /*
    OpalFuzzyInference.h
 
    Copyright (C) 2014 Free Software Foundation, Inc.
 
    Author: Johan Ceuppens <johan@yellowcouch.org> 
    Date: Dec 2014
 
    This file is part of GNUstep.
 
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.
 
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
    License along with this library; see the file COPYING.LIB.
    If not, see <http://www.gnu.org/licenses/> or write to the
    Free Software Foundation, 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
 */
 
 #ifndef OpalFuzzyInference_h_defined
 #define OpalFuzzyInference_h_defined

#import <Foundation/Foundation.h>
@class OpalFuzzyDB;
@class OpalFuzzyPredicate;
@class OpalFuzzyInference;

@interface InferenceNode
{
	id _data;
	OpalFuzzyPredicate *_predicate;
}
-(id)new:(id)d;
-(id)data;
-(void)data:(id)d;
-(id)predicate;
-(void)predicate:(OpalFuzzyPredicate*)d;
@end

@interface InferenceADT
{
	InferenceNode* _node;
	int _nodeid;
}
-(id)node;
-(id)nodeid;
@end

@interface InferenceAtom : InferenceADT
{
}
-(void) parse:(OpalFuzzyInference*)inf;
@end
@interface InferenceVariable : InferenceADT
{
}
-(void) parse:(OpalFuzzyInference*)inf;
@end
@interface InferenceNumber : InferenceADT
{
}
-(void) parse:(OpalFuzzyInference*)inf;
@end
@interface InferenceCompound : InferenceADT
{
}
-(void) parse:(OpalFuzzyInference*)inf;
@end
 
@interface OpalFuzzyInference : NSObject {
	OpalFuzzyDB *_atoms;	
	OpalFuzzyDB *_vars;	
	OpalFuzzyDB *_numbers;	
	OpalFuzzyDB *_compounds;	
 }
 - (id)new;
 
@end
 
 #endif
