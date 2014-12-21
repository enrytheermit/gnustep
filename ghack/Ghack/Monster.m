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
	_typeinfo.name = name;
	_typeinfo.class = c;
	return self;	
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








@implementation Monster 

- (id)new
{
	return self;
}

- (id)init
{

	return self;
}

@end

