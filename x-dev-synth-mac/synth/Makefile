.SUFFIXES : .o .cc .c

CC = g++

CFLAGS = -fpermissive -I/Users/bubble/sound/include -I/usr/include/X11 -L/usr/X11R6/lib -lX11 -lXext -lXpm

LIBS = -L/usr/X11R6/lib -lX11 -lXext -lXpm -L../src -lx-dev -L../widgets -lx-dev-widgets -L../sound -lx-dev-sound

###-lXpm -lXext -lpthread -L./lib -llua -L./xlua -lxlua
###-ljpeg -lpng -L./widget -lPixieWidget -lImlib
OBJS = SynthWindow.o Callbacks.o

all: LIBXSynth

LIBXSynth: $(OBJS)
	@echo "***COMPILING NOTE***"

###	$(CXX) -shared -o libx-synth.so *.o $(LIBS) -L/usr/lib -lX11 -lXext -lXpm -lpthread
	ar rcu libx-synth.a *.o
	ranlib libx-synth.a



clean: 
	rm *.o libx-dev.a libx-dev.so

.cpp.o:
	$(CXX) $(CFLAGS) $< -o $@

.cc.o :
	$(CC) $(CFLAGS) $(LIBS) $(INLCUDES) -c $<
