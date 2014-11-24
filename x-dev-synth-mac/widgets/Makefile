.SUFFIXES : .o .cc .c

CC = g++

CFLAGS = -I/usr/include/X11 -L/usr/X11R6/lib -lX11 -lXext -lXpm

LIBS = -L/usr/X11R6/lib -lX11 -lXext -lXpm -L../src -lx-dev 

OBJS = XDevWidgetizedWindow.o Button.o LabelButton.o WindowWidget.o WidgetTree.o Widget.o WidgetWindowManipulator.o

all: LIBXDevWidgets

LIBXDevWidgets: $(OBJS)
	@echo "***COMPILING NOTE***"

###	$(CXX) -shared -o libx-dev-widgets.so *.o -L../src -lx-dev -L/usr/X11R6/lib -lX11 -lXext -lXpm -lpthread
	ar rcu libx-dev-widgets.a *.o
	ranlib libx-dev-widgets.a



clean: 
	rm *.o libx-dev-widgets.a

.cpp.o:
	$(CXX) $(CFLAGS) $< -o $@

.cc.o :
	$(CC) $(CFLAGS) $(LIBS) $(INLCUDES) -c $<
