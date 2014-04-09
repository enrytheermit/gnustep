.SUFFIXES : .o .cc .c

CC = g++
CFLAGS = -g
INCLUDES = -I/usr/X11R6/include
LIBS = -L/usr/X11R6/lib -lX11 

###-lXpm -lXext -lpthread -L./lib -llua -L./xlua -lxlua
###-ljpeg -lpng -L./widget -lPixieWidget -lImlib
OBJS = XDevWindow.o WindowManager.o  Xmanager.o XDevBaseVisit.o XDev.o

all: LIBXDev

LIBXDev: $(OBJS)
	@echo "***COMPILING NOTE***"
	ar rcu libx-dev.a *.o
	ranlib libx-dev.a

clean: 
	rm *.o libx-dev.a

.cpp.o:
	$(CXX) $(CFLAGS) $< -o $@

.cc.o :
	$(CC) $(CFLAGS) $(INLCUDES) -c $<
