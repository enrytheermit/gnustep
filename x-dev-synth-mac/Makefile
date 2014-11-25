.SUFFIXES : .o .cc .c
LD=ld
CXX = g++
CFLAGS = -g -I./src

LIBS = -L/usr/X11R6/lib -lX11 -lXpm -lXext -lpthread -L/Users/bubble/sound/lib -laudiofile

XDEV = -I/Users/bubble/sound/include -L./src -lx-dev -L./widgets -lx-dev-widgets -L./synth -lx-synth -L./sound -lx-dev-sound

all: LIBXDev XDevMain

OBJS = main.o
SRC = main.cc
XDevMain: debug $(OBJS) LIBXDev 
	$(CXX) main.cc -o xdevsynth $(LIBS) $(XDEV)

debug:
	@echo Constructing config.h
	@rm -f config.h
	@echo '#define	DEBUG' >> config.h
	@echo "***COMPILING NOTE***"

LIBXDev:
	cd sound; $(MAKE) $(MFLAGS); cd ..
	cd src; $(MAKE) $(MFLAGS); cd ..
	cd widgets; $(MAKE) $(MFLAGS); cd ..
	cd synth; $(MAKE) $(MFLAGS); cd ..


test : $(OBJS) 
	cd test; $(MAKE) $(MFLAGS)

clean: 
	rm *.o xdevsynth
	cd src; rm *.o *.a *.so; cd ..
	cd widgets; rm *.o *.a *.so; cd ..
	cd synth; rm *.o *.a *.so; cd ..
	cd sound; rm *.o *.a *.so; cd ..

distclean: 
	rm *.o xdevsynth.exe */*.o 

.cpp.o:
	$(CXX) $(XDEV) $(CFLAGS) $(INCLUDES) $< -o $@

.cc.o :
	$(CXX) $(XDEV) $(CFLAGS) $(INLCUDES) -c $<
