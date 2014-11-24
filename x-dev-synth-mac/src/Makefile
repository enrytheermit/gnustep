.SUFFIXES : .o .cc .c

CC = g++

CFLAGS = -I/usr/include/X11 -L/usr/X11R6/lib -lX11 -lXext -lXpm

LIBS = -L/usr/X11R6/lib -lX11 -lXext -lXpm 

OBJS = XDevWindow.o WindowManipulator.o WindowManager.o  Xmanager.o XDevBaseVisit.o XDev.o

all: LIBXDev

LIBXDev: $(OBJS)
	@echo "***COMPILING NOTE***"

###	$(CXX) -shared -o libx-dev.so *.o -L/usr/X11R6/lib -lX11 -lXext -lXpm -lpthread
	ar rcu libx-dev.a *.o
	ranlib libx-dev.a



clean: 
	rm *.o libx-dev.a libx-dev.so

.cpp.o:
	$(CXX) $(CFLAGS) $< -o $@

.cc.o :
	$(CC) $(CFLAGS) $(LIBS) $(INLCUDES) -c $<
