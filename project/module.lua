ffi = require("ffi");

ffi.cdef[[
typedef enum {
	TEST_E_ONE,
	TEST_E_TWO
} TestE;

void berdie(float* buf, uint32_t size);
typedef struct {
	float x;
	float y;
} Vec2;
void pfunc(Vec2*, uint32_t size);

void test_e(TestE e);

void vfunc(void* in);
]]

function berdie(table)
	length = #table;
	h = string.format("float[%i]", length);
	print("length: " .. length);
	print("h: " .. h);
	array = ffi.new(h, table);
	ffi.C.berdie(array, length);
end

function pfunc(vecs)
	vec_count = #vecs;
	t = ffi.new(string.format("Vec2[%i]", vec_count), vecs);
	ffi.C.pfunc(t, vec_count);
end
berdie({0.1, 0.2, 0.3 ,0.4});
print();
pfunc({{0.8, 0.8}, {-1, -1}});
print();
ffi.C.test_e("TEST_E_TWO");
print();
ffi.C.vfunc(ffi.new("uint32_t[1]", {56}));
print();
path("This is totally legit!");
torus("Cool torus func!");
