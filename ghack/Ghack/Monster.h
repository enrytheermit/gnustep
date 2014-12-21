#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
/*
Copyright (C) 2013 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/
#import "MonsterInfo.h"
////see monsterinfo.h typedef int monsterinfo_t; 
#define DefMonsterTypeInfo \
	typedef monsterinfo_t \
typedef struct {} __struct_MonsterTypeInfo \
__DefMonsterInfo(__struct_MonsterTypeInfo)

@interface MonsterTypeInfo : NSObject 
{
	typeinfo _typeinfo;
}
-(void)setName:(NSString*)name;
-(void)setClass:(NSString*)class;
@end

#define DefMonsterBaseInfo \
	typedef monsterinfo_t \
typedef struct {} __struct_MonsterBaseInfo \
__DefMonsterInfo(__struct_MonsterBaseInfo)

@interface MonsterBaseInfo : NSObject 
{
@private
	baseinfo _baseinfo;
}
-(id)initHitpoints:(NSString*)hp armor:(NSString*)a strength:(NSString*)s;
-(void)setHitpoints:(NSString*)name;
-(void)setArmor:(NSString*)armor;
-(void)setStrength:(NSString*)s;
@end

#define DefMonsterManaInfo \
	typedef monsterinfo_t \
typedef struct {} __struct_MonsterManaInfo \
__DefMonsterInfo(__struct_MonsterManaInfo)

@interface MonsterManaInfo : NSObject 
{
@private
	manainfo _manainfo;
}
@end

#define DefMonsterWizardInfo \
	typedef monsterinfo_t \
typedef struct {} __struct_MonsterWizardInfo \
__DefMonsterInfo(__struct_MonsterWizardInfo)

@interface MonsterWizardInfo : NSObject 
{
@private
	wizardinfo _wizardinfo;
}
@end

#define DefMonsterPriestInfo \
	typedef monsterinfo_t \
typedef struct {} __struct_MonsterPriestInfo \
__DefMonsterInfo(__struct_MonsterPriestInfo)

@interface MonsterPriestInfo : NSObject 
{
@private
	priestinfo _priestinfo;
}
@end

#define DefMonsterThiefInfo \
	typedef monsterinfo_t \
typedef struct {} __struct_MonsterPriestInfo \
__DefMonsterInfo(__struct_MonsterPriestInfo)

@interface MonsterThiefInfo : NSObject 
{
@private
	thiefinfo _thiefinfo;
}
@end

#define DefMonsterLevelInfo \
	typedef monsterinfo_t \
typedef struct {} __struct_MonsterLevelInfo \
__DefMonsterInfo(__struct_MonsterLevelInfo)

@interface MonsterLevelInfo : NSObject 
{
@private
	levelinfo _levelinfo;
}
@end

#define DefMonsterEquipmentInfo \
	typedef monsterinfo_t \
typedef struct {} __struct_MonsterEquipmentInfo \
__DefMonsterInfo(__struct_MonsterEquipmentInfo)

@interface MonsterEquipmentInfo : NSObject 
{
@private
	equipmentinfo _equipmentinfo;
}
@end


@interface Monster : NSObject 
{
//@private
	MonsterTypeInfo *_typeinfo;
	MonsterBaseInfo *_baseinfo;
	MonsterManaInfo *_manainfo;
	MonsterWizardInfo *_wizardinfo;
	MonsterPriestInfo *_priestinfo;
	MonsterLevelInfo *_levelinfo;
	MonsterEquipmentInfo *_equipmentinfo;
}
- (id)new;
- (id)init;

-(void)setName:(NSString*)name;
-(void)setClass:(NSString*)class;
-(void)setHitpoints:(NSString*)name;
-(void)setArmor:(NSString*)armor;
-(void)setStrength:(NSString*)s;

@end

