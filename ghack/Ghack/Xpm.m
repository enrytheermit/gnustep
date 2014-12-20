/*
Copyright (C) 2013 enrytheermit 

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/
#include <stdlib.h>
#include <stdio.h>

#import "Xpm.h"

@implementation Xpm 

- (id)initWithRogueCharacter
{
/* XPM */
static char * character_rogue_16x16_1_xpm[] = {
"16 16 90 1",
" 	c None",
".	c #294731",
"+	c #4E4E4E",
"@	c #3A3A3A",
"#	c #102616",
"$	c #66CF6E",
"%	c #39443D",
"&	c #4C4C4C",
"*	c #7B797E",
"=	c #74B35D",
"-	c #8CDC68",
";	c #3A513F",
">	c #302E1B",
",	c #401E16",
"'	c #501300",
")	c #CA470B",
"!	c #002E4C",
"~	c #39321D",
"{	c #104429",
"]	c #6DB556",
"^	c #60CF6F",
"/	c #40744B",
"(	c #3D4E40",
"_	c #4A2A16",
":	c #8D4113",
"<	c #002336",
"[	c #003455",
"}	c #382318",
"|	c #FB7021",
"1	c #5E2B11",
"2	c #461905",
"3	c #445E4A",
"4	c #593A25",
"5	c #803509",
"6	c #34312C",
"7	c #865E39",
"8	c #783611",
"9	c #803F16",
"0	c #6F6F7A",
"a	c #C5C7B5",
"b	c #000000",
"c	c #796D3F",
"d	c #1E0200",
"e	c #94400F",
"f	c #8F5A31",
"g	c #975E35",
"h	c #4E342D",
"i	c #F5CA76",
"j	c #DEA358",
"k	c #3A1E18",
"l	c #476E3A",
"m	c #B76839",
"n	c #7F421C",
"o	c #745335",
"p	c #358A54",
"q	c #68C165",
"r	c #204B30",
"s	c #4A3325",
"t	c #206136",
"u	c #B88950",
"v	c #5E3824",
"w	c #8AEC73",
"x	c #2C6A40",
"y	c #3E9255",
"z	c #5C7D48",
"A	c #27271E",
"B	c #3E281B",
"C	c #1B0B03",
"D	c #635437",
"E	c #152A1A",
"F	c #3A4A34",
"G	c #366742",
"H	c #64BE65",
"I	c #4D4D32",
"J	c #6D714F",
"K	c #5EB761",
"L	c #333A2C",
"M	c #67D370",
"N	c #81E470",
"O	c #18070C",
"P	c #000807",
"Q	c #C2FF79",
"R	c #253B2B",
"S	c #5F351A",
"T	c #351D18",
"U	c #522D16",
"V	c #120000",
"W	c #1A0C05",
"X	c #825D31",
"Y	c #392915",
"        .       ",
"     +@#$%      ",
"     &*=-;      ",
"     >,')       ",
"    !~{]^/( _:  ",
"   <[}|123 456  ",
"    7890abcde   ",
"    fghijklmn   ",
"    opqrstuv    ",
"     wxyzAB     ",
"    CDEFGH      ",
"    IJKLMNO     ",
"     PQRST      ",
"    bUVbWXb     ",
"   bbYYbbbbb    ",
"    bbbbbbb     "};

	[self init:character_rogue_16x16_1_xpm];

	return self;
}

- (id)init:(char *[])data
{

	int idx = 0;

	//process first row of chars (w,h,ncolors,f)
	//skip starter "
	[self skipChar:'"' data:data[0] atIndex:&idx];

	//read in n rows
	char *cw = [self getWord:data[0] atIndex:&idx];
	int w = atoi(cw);
	[self setRow:w];
	[self skipChar:' ' data:data[0] atIndex:&idx];
	//read in n cols
	char *ch = [self getWord:data[0] atIndex:&idx];
	int h = atoi(ch);
	[self setCol:h];
	[self skipChar:' ' data:data[0] atIndex:&idx];
	//read in ncolors
	char *cnc = [self getWord:data[0] atIndex:&idx];
	int numcolors = atoi(cnc);
	[self setNColors:numcolors];
	[self skipChar:' ' data:data[0] atIndex:&idx];
	//read in rest of line //FIXME == bpp
	char *f = [self getWord:data[0] atIndex:&idx];
	[self skipChar:'"' data:data[0] atIndex:&idx];

	free(cw);
	free(ch);
	free(cnc);
	free(f);

	idx = 0;
	int i = 1;
	//FIXMENOTE a color symbol is one char wide (xpm with 256 colors )!
	symboltable = (int*)malloc(sizeof(int)*256);

	for ( ; i < ncolors + 1; i++) {
		char *line = data[i];

		int lineidx = 0;
		//skip first " char on colorsymbol line
		[self skipChar:'"' data:line atIndex:&lineidx];
		char colorsymbol;
		//whitespace color symbol
		if (line[lineidx] == ' ') {
			[self skipChar:'\t' data:line atIndex:&lineidx];
			[self skipChar:' ' data:line atIndex:&lineidx];
			[self skipChar:'c' data:line atIndex:&lineidx];
			[self skipChar:' ' data:line atIndex:&lineidx];
			char *colorsymbols = " ";
			//set colorsymbol which is 1 char wide
			colorsymbol = colorsymbols[0];
		} else {	
			char *colorsymbols = [self getWord:line atIndex:&lineidx];
			//set colorsymbol which is 1 char wide
			colorsymbol = colorsymbols[0];
			free(colorsymbols);

			//FIXME skip everything until c char
			[self skipChar:'\t' data:line atIndex:&lineidx];
			[self skipChar:' ' data:line atIndex:&lineidx];
			[self skipChar:'c' data:line atIndex:&lineidx];
			[self skipChar:' ' data:line atIndex:&lineidx];
		}
		//read hex color string with '#HEX' or None	
		char* colornumberstr = [self getWord:line atIndex:&lineidx];
		if (strncmp(colornumberstr, "None",4) == 0 || strncmp(colornumberstr, "none", 4) == 0) {

			[self addColorSymbol:colorsymbol Color:0 atIndex:i];

		} else if (colornumberstr[0] == '#') {
			//skip #
			int colorstartidx = lineidx - strlen(colornumberstr)+1;
			char *hexstr = [self getWord:line atIndex:&colorstartidx];
			int valueofhex = [self hexStringToNumber:hexstr];	 
			[self addColorSymbol:colorsymbol Color:valueofhex atIndex:i];
		}
	}
	//NOTE that j starts at xpm file linenumber ncolors + 1 for bpp line etc
	int j = ncolors+1, k = 0;
	symboldata = (char*)malloc(row*col);
	for ( ; j < col + ncolors+1; j++) {
		char *line = data[j];

		for ( ; k < row; k++) {
			symboldata[k+row*(j-ncolors-1)] = line[k+1];//skip " at begin and end 
		}
		k = 0;	
	}

	return self;

}

- (void)addColorSymbol:(char)symbol Color:(int)color atIndex:(int)i
{
	symboltable[(int)symbol] = color;//FIXME int cast
}

- (int)getColor:(char)symbol
{
	return symboltable[(int)symbol];//FIXME int cast
}

- (char *)getSymbolData
{
	return strdup(symboldata);
}

- (int)hexStringToNumber:(char *)hexstr
{

	int rh = 0;
	int i = 0;
	while (i < strlen(hexstr)) {
		char valuestr[2];
		valuestr[0] = hexstr[i];
		valuestr[1] = '\0';
		int value = atoi(valuestr);
		rh += (strlen(hexstr)-i-1)*8*value;
		i++;
	}
	return rh;
}


- (char *)getWord:(char *)linedata atIndex:(int*)idx
{

	char cs[256];
	int i = *idx;
	int j = 0;
	char c;	
	while ((c = linedata[i++]) && (c != ' ' && c != '\t' && c != '"'))
		cs[j++] = c;

	cs[j] = '\0';//null terminate string

	*idx = i;
	return (strdup((const char *)cs));
}

- (void)skipChar:(char)cd data:(char *)linedata atIndex:(int*)idx
{
	int i = *idx;
	char c;
	while ((c = linedata[i++]) && c == cd)
		;

	*idx = i;
}

- (int)row
{
    return row;
}

- (int)col
{
    return col;
}

- (int)ncolors
{
    return ncolors;
}

- (void)setRow:(int)r
{
	row = r;
}

- (void)setCol:(int)c
{
	col = c;
}

- (void)setNColors:(int)nc
{
	ncolors = nc;
}

@end

