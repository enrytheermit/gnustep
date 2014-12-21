/*
Copyright (C) 2013 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

#import "MonsterInfo.h"
#import "Monster.h"

@implementation MonsterTypeInfo 
- (id)init
{
	return self;
}

-(id)initName:(NSString*)name Class:(NSString*)c
{
	_typeinfo.name = [name UTF8String];
	_typeinfo.class = [c UTF8String];
	return self;	
}

-(void)setName:(NSString*)name
{
	_typeinfo.name = [name UTF8String];
}
-(void)setClass:(NSString*)c
{
	_typeinfo.class = [c UTF8String];
}
@end

@implementation MonsterBaseInfo 

-(id)init
{
	return self;
}

-(id)initHitpoints:(NSString*)hp armor:(NSString*)a strength:(NSString*)s
{
	_baseinfo.hitpoints = [hp UTF8String];
	_baseinfo.armor = [a UTF8String];
	_baseinfo.strength = [s UTF8String];	
	return self;
}

@end

@implementation MonsterManaInfo 

-(id)init
{
	return self;
}

-(id)initManaPoints:(NSString*)mp spells:(NSString*)a manaLevel:(NSString*)s
{
	_manainfo.manapoints = [mp UTF8String];
	_manainfo.spells = [a UTF8String];
	_manainfo.manalevel = [s UTF8String];	
	return self;
}

@end



@implementation MonsterWizardInfo 

-(id)init
{
	return self;
}

-(id)initManaPoints:(NSString*)mp spells:(NSString*)a manaLevel:(NSString*)s
{
	_wizardinfo.manapoints = [mp UTF8String];
	_wizardinfo.spells = [a UTF8String];
	_wizardinfo.manalevel = [s UTF8String];	
	return self;
}

@end



@implementation MonsterPriestInfo 

-(id)init
{
	return self;
}

-(id)initClericPoints:(NSString*)mp spells:(NSString*)a manaLevel:(NSString*)s
{
	_priestinfo.clericpoints = [mp UTF8String];
	_priestinfo.spells = [a UTF8String];
	_priestinfo.clericlevel = [s UTF8String];	
	return self;
}

@end

@implementation MonsterThiefInfo 

-(id)init
{
	return self;
}

-(id)initThiefPoints:(NSString*)mp spells:(NSString*)a manaLevel:(NSString*)s
{
	_thiefinfo.thiefpoints = [mp UTF8String];
	_thiefinfo.skills = [a UTF8String];
	_thiefinfo.thieflevel = [s UTF8String];	
	return self;
}

@end

@implementation MonsterLevelInfo 

-(id)init
{
	return self;
}

-(id)initStrength:(NSString*)s dexterity:(NSString*)d intelligence:(NSString*)i constitution:(NSString*)c charsima:(NSString*)cs
{
	_levelinfo.strength = [s UTF8String];
	_levelinfo.dexterity = [d UTF8String];
	_levelinfo.intelligence = [i UTF8String];
	_levelinfo.constitution = [c UTF8String];
	_levelinfo.charisma = [cs UTF8String];
	return self;
}

@end

@implementation MonsterEquipmentInfo 

-(id)init
{
	return self;
}

-(id)initHead:(NSString*)s body:(NSString*)d feet:(NSString*)i gloves:(NSString*)cs
{
	_equipmentinfo.head = [s UTF8String];
	_equipmentinfo.body = [d UTF8String];
	_equipmentinfo.feet = [i UTF8String];
	_equipmentinfo.gloves = [cs UTF8String];
	return self;
}

@end



@implementation Monster 

- (id)new
{
	return self;
}

- (id)init
{
	_typeinfo = [MonsterTypeInfo new];
	_baseinfo = [MonsterBaseInfo new];
	_manainfo = [MonsterManaInfo new];
	_wizardinfo = [MonsterWizardInfo new];
	_priestinfo = [MonsterPriestInfo new];
	_levelinfo = [MonsterLevelInfo new];
	_equipmentinfo = [MonsterEquipmentInfo new];

	return self;
}

-(void)setName:(NSString*)name
{
	[_typeinfo setName:name];
}	
-(void)setClass:(NSString*)class
{
	[_typeinfo setclass:class];
}

-(void)setHitpoints:(NSString*)name
{
	[_baseinfo setHitpoints:name];
}

-(void)setArmor:(NSString*)armor
{
	[_baseinfo setArmor:armor];
}

-(void)setStrength:(NSString*)s
{
	[_baseinfo setStrength:s];
}


@end

