.SUFFIXES : .o .cc .c

CXX = g++
CFLAGS = -g -I../esound
CXXFLAGS = -g -I/Users/bubble/sound/include -I/Users/bubble/sound/include
LIBS = -L/Users/bubble/sound/lib -laudiofile #### -lesd -lm

OBJS = WavFilename.o ESDSampleBuf.o ESDSample.o ESDCache.o ESDCat.o Frame.o XSynth.o XSynthFrameBuilder.o

all: LIBSOUNDDev

LIBSOUNDDev: $(OBJS)
	@echo "***COMPILING NOTE***"
###	$(CXX) -shared -o libx-dev-sound.so *.o $(LIBS)
	ar rcu libx-dev-sound.a *.o
	ranlib libx-dev-sound.a



clean: 
	rm *.o *.a *.so

.cpp.o:
	$(CXX) $(CXXFLAGS) $< -o $@

.cc.o :
	$(CXX) $(CXXFLAGS) $(INLCUDES) -c $<
