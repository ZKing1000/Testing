#include <stdio.h>
extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
#include "luajit.h"
}
#include <thread>
#include <chrono>

void init();
void loop();

//const char* PROJECT_DIR = "project/";
extern "C" {

enum TestE {
	TEST_E_ONE,
	TEST_E_TWO
};

void berdie(float* buf, uint32_t size) {
	for(int i=0;i<size;i++){
		printf("buf[%i]: %f\n", i, buf[i]);
	}
}

struct Vec2 {
	float x;
	float y;
};

void pfunc(Vec2* vecs, uint32_t size){
	for(int i=0;i<size;i++){
		printf("vecs[%i]: %f, %f\n", i, vecs[i].x, vecs[i].y);
	}
}

void test_e(TestE e) {
	printf("TestE: %i\n", e);
}

void vfunc(void* in) {
	uint32_t* p = (uint32_t* )(in);
	printf("VFunc: %i\n", *p);
}

int main()
{

    lua_State* L;

    L = luaL_newstate();
    luaL_openlibs(L);
    luaL_dostring(L, "function path(wow)\n\tprint(wow);\nend");
    luaL_dostring(L, "function torus(wow)\n\tprint(wow);\nend");
    luaL_loadfile(L, "project/_init_.lua");
    luaL_loadfile(L, "project/module.lua");
	luaJIT_setmode(L, -1, LUAJIT_MODE_WRAPCFUNC|LUAJIT_MODE_ON);
	/*
    lua_getglobal(L, "package");
    lua_pushstring(L, PROJECT_DIR);
    lua_setfield(L, -2, "path");
    lua_pop(L, 1);
    */
    int ret = lua_pcall(L, 0, 0, 0);
    if(ret != 0){
        fprintf(stderr, "%s\n", lua_tostring(L, -1));
        return 1;
    }

}
}
