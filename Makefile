#LIBREN: vulkan.cpp
#	g++ -std=c++14  vulkan.cpp obj.cc -o libren.so -L./lib -lvulkan -lglfw3 -I./include -g -lrt -lm -ldl -lXrandr -lXinerama -lXxf86vm -lXext -lXcursor -lXrender -lXfixes -lX11 -lpthread -lxcb -lXau -lXdmcp -shared -fPIC

SHARED_FLAGS := -shared -fPIC

LIBFONT:
	g++ -std=c++14 font.cc -o libfont.so -g $(SHARED_FLAGS) $(shell pkg-config --cflags freetype2) $(shell pkg-config --libs freetype2)

LIBREN: tut.cc
	g++ -std=c++14  tut.cc obj.cc -o libren.so -L./lib -lvulkan -lglfw3 -I./include -g -lrt -lm -ldl -lXrandr -lXinerama -lXxf86vm -lXext -lXcursor -lXrender -lXfixes -lX11 -lpthread -lxcb -lXau -lXdmcp -shared -fPIC

LIBOBJ: obj.cc
	g++ -std=c++14 obj.cc -o libobj.so -I./include -shared -fPIC -g


RENEXEC: vulkan.cpp
	g++ -std=c++14 -D DEBUG vulkan.cpp obj.cc -o vulkan -L./lib -lvulkan -lglfw3 -I./include -g -lrt -lm -ldl -lXrandr -lXinerama -lXxf86vm -lXext -lXcursor -lXrender -lXfixes -lX11 -lpthread -lxcb -lXau -lXdmcp

TUT: vulkan.cpp
	g++ -std=c++14 tut.cc obj.cc -o tut -L./lib -lvulkan -lglfw3 -I./include -g -lrt -lm -ldl -lXrandr -lXinerama -lXxf86vm -lXext -lXcursor -lXrender -lXfixes -lX11 -lpthread -lxcb -lXau -lXdmcp

RUN: main
	./main

THIRD_PARTY_DIR := ./CheriVCAD-third_party
INCLUDE := $(THIRD_PARTY_DIR)/include
LIB := $(THIRD_PARTY_DIR)/lib
SRC := $(wildcard *.cc)

MAIN: main.cc
	echo $(SRC)
	g++ -std=c++11 $(SRC) -o main -L$(LIB) -I./ -I$(INCLUDE) -I$(INCLUDE)/luajit-2.0 -lvulkan $(shell pkg-config --static --libs glfw3) -lluajit-5.1 -llua5.1 -lshaderc -pthread -g -rdynamic

OBJTEST: main.cc
	echo $(SRC)
	g++ -std=c++11 -c $(SRC) -o obj/main.o -L$(LIB) -I./ -I$(INCLUDE) -I$(INCLUDE)/luajit-2.0 -lvulkan $(shell pkg-config --static --libs glfw3) -lluajit-5.1 -llua5.1 -lshaderc -pthread -g -rdynamic
