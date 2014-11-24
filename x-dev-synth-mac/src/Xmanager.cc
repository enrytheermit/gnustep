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
#include "XDev.h"
#include "Xmanager.h"

Xmanager::Xmanager()
{}

void Xmanager::init(DisplayBase<Display **>& dpyb)
{
  long event_mask;

  root_window = RootWindow(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));
  depth = DefaultDepth(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));
  visual = DefaultVisual(*(dpyb.get_display()), DefaultScreen(*(dpyb.get_display())));
  screen = DefaultScreen(*(dpyb.get_display()));
  printf("made xmanager\n");
}

Xmanager::~Xmanager()
{

}

static const char *getFontElement(const char *pattern, char *buf, int bufsiz, ...) {
  const char *p, *v;
  char *p2;
  va_list va;

  va_start(va, bufsiz);
  buf[bufsiz-1] = 0;
  buf[bufsiz-2] = '*';
  while((v = va_arg(va, char *)) != NULL) {
    p = strcasestr(pattern, v);
    if (p) {
      strncpy(buf, p+1, bufsiz-2);
      p2 = strchr(buf, '-');
      if (p2) *p2=0;
      va_end(va);
      return p;
    }
  }
  va_end(va);
  strncpy(buf, "*", bufsiz);
  return NULL;
}

static const char *getFontSize(const char *pattern, int *size) {
  const char *p;
  const char *p2=NULL;
  int n=0;

  for (p=pattern; 1; p++) {
    if (!*p) {
      if (p2!=NULL && n>1 && n<72) {
	*size = n; return p2+1;
      } else {
	*size = 16; return NULL;
      }
    } else if (*p=='-') {
      if (n>1 && n<72 && p2!=NULL) {
	*size = n;
	return p2+1;
      }
      p2=p; n=0;
    } else if (*p>='0' && *p<='9' && p2!=NULL) {
      n *= 10;
      n += *p-'0';
    } else {
      p2=NULL; n=0;
    }
  }
}

XFontSet Xmanager::createFontSet(DisplayBase<Display **>& dpyb)
{
  const char *fontname = "fixed";
#define   FONT_ELEMENT_SIZE 50
  XFontSet fs;
  char **missing;
  char *def = (char *)"-";
  int nmissing, pixel_size = 0, buf_size = 0;
  char weight[FONT_ELEMENT_SIZE], slant[FONT_ELEMENT_SIZE];

  fs = XCreateFontSet(*(dpyb.get_display()),
		      fontname, &missing, &nmissing, &def);
  if (fs && (! nmissing)) return fs;
  
#ifdef    HAVE_SETLOCALE
  if (! fs) {
    if (nmissing) XFreeStringList(missing);

    setlocale(LC_CTYPE, "C");
    fs = XCreateFontSet(*(dpyb.get_display()), fontname,
			&missing, &nmissing, &def);
    setlocale(LC_CTYPE, "");
  }
#endif // HAVE_SETLOCALE

  if (fs) {
    XFontStruct **fontstructs;
    char **fontnames;
    XFontsOfFontSet(fs, &fontstructs, &fontnames);
    fontname = fontnames[0];
  }

  getFontElement(fontname, weight, FONT_ELEMENT_SIZE,
		 "-medium-", "-bold-", "-demibold-", "-regular-", NULL);
  getFontElement(fontname, slant, FONT_ELEMENT_SIZE,
		 "-r-", "-i-", "-o-", "-ri-", "-ro-", NULL);
  getFontSize(fontname, &pixel_size);

  if (! strcmp(weight, "*")) strncpy(weight, "medium", FONT_ELEMENT_SIZE);
  if (! strcmp(slant, "*")) strncpy(slant, "r", FONT_ELEMENT_SIZE);
  if (pixel_size < 3) pixel_size = 3;
  else if (pixel_size > 97) pixel_size = 97;

  buf_size = strlen(fontname) + (FONT_ELEMENT_SIZE * 2) + 64;
  char *pattern2 = new char[buf_size];
  snprintf(pattern2, buf_size - 1,
	   "%s,"
	   "-*-*-%s-%s-*-*-%d-*-*-*-*-*-*-*,"
	   "-*-*-*-*-*-*-%d-*-*-*-*-*-*-*,*",
	   fontname, weight, slant, pixel_size, pixel_size);
  fontname = pattern2;

  if (nmissing) XFreeStringList(missing);
  if (fs) XFreeFontSet(*(dpyb.get_display()), fs);

  fs = XCreateFontSet(*(dpyb.get_display()), fontname,
		      &missing, &nmissing, &def);
  delete [] pattern2;

  return fs;
}
