#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
/*
Copyright (C) 2013-2014 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/
typedef struct __struct_MonsterTypeInfo { char *name; char *class; } typeinfo;
typedef struct __struct_MonsterBaseInfo { char *hitpoints; char *armor; char *strength; } baseinfo;
struct __struct_MonsterManaInfo { char *manapoints; char *spells; char *manalevel; };
struct __struct_MonsterWizardInfo { char *manapoints; char *spells; char *manalevel; };
struct __struct_MonsterPriestInfo { char *clericpoints; char *spells; char *clericlevel; };
struct __struct_MonsterThiefInfo { char *clericpoints; char *spells; char *clericlevel; };
struct __struct_MonsterLevelInfo { char *strength; char *dexterity;
				char *intelligence; char *constitution;
				char *charisma; };
struct __struct_MonsterEquipmentInfo { char *head; char *body; char *feet; char *gloves; };
struct __struct_MonsterCustomInfo {};

/*FIXME 
#define __Def2(type2) \
	typedef struct {} type \
	##define __DefMonsterInfo() \
		typedef type2 type \
	__DefMonsterInfo(type2)
*/

#define __Def(type) \
	typedef type
/***
  Note : This was made for chaning monsterinfo_t types as non-persistent types
*/
#define __DefMonsterInfo(type) \
	typedef type monsterinfo_t 

typedef struct {} monsterinfo_t;
__DefMonsterInfo(monsterinfo_t);

/*
 * Do not subclass, use the meta level above
 */
@interface MonsterInfo : NSObject 
{
	id info;
}

-(id) init;

@end
