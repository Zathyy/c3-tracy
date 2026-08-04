module c3_tracy;
import std::io;
import std::thread;

import tracy;

fn int main(String[] args) => @pool()
{
	tracy::set_thread_name("Main");
	defer tracy::message("Exit");

	test();

	return 0;
}

fn void test() => @tracy("test")
{
	TracyAllocator alloc; alloc.init(tmem);
	Allocator allocator = &alloc;

	for (int i = 0; i < 100; i++)
	{
		tracy::frame_mark(string::tformat_zstr("Frame %d", i));
		void* ptr = alloc::alloc(allocator, void*);
		thread::sleep_ms(100);
	}
}
