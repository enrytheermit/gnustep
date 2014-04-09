.SUFFIXES : .o .cc .c

CXX = g++
CFLAGS = -g
INCLUDES = -I/usr/X11R6/include -I./xdev
LIBS = -L/usr/X11R6/lib -lX11
XDEV = -L./xdev -lxdev 
###-lXpm -lXext -lpthread
### -ljpeg -lpng -lImlib

all: XDevMain LIBXDev

XDevMain: debug main.o LIBXDev 
	$(CXX) $(CFLAGS) $(INCLUDES) $(OBJS) -o xdevmain $(LIBS) $(XDEV) main.o

debug:
	@echo Constructing config.h
	@rm -f config.h
	@echo '#define	DEBUG' >> config.h
	@echo "***COMPILING NOTE***"

LIBXDev:
	cd xdev; $(MAKE) $(MFLAGS); cd ..

test : $(OBJS) 
	cd test; $(MAKE) $(MFLAGS)

clean: 
	rm *.o xdevmain 

distclean: 
	rm *.o xdevmain */*.o 

.cpp.o:
	$(CXX) $(CFLAGS) $(INCLUDES) $< -o $@

.cc.o :
	$(CXX) $(CFLAGS) $(INLCUDES) -c $<
