module buffer

struct Buffer {
mut:
	data []byte
	cap  int
	len  int
}

const def_capacity = 1024

// new create a Buffer with the default capacity
pub fn new() Buffer {
	return cap(buffer.def_capacity)
}

// cap create a Buffer with the specified capacity
pub fn cap(cap int) Buffer {
	return Buffer{
		data: []byte{cap: cap}
		cap: cap
	}
}

// peek returns a copy of the accumulated string
pub fn (mut self Buffer) peek() string {
	raw := unsafe { &byte(memdup(self.data.data, self.len)) }
	return unsafe { raw.vstring_with_len(self.len) }
}

// str returns a copy of the accumulated string and reset the buffer
pub fn (mut self Buffer) str() string {
	res := self.peek()
	self.set_pos(0)
	return res
}

// trim returns the string representation of this item, without trailing white spaces
pub fn (mut self Buffer) trim() string {
	mut beg := 0
	mut end := self.len - 1
	for ; self.data[beg].is_space(); beg++ {
		if beg == end {
			return ''
		}
	}
	for ; self.data[end].is_space(); end-- {}
	end++
	raw := unsafe { &byte(memdup(self.data[beg..end].data, end - beg)) }
	res := unsafe { raw.vstring_with_len(end - beg) }
	self.set_pos(0)
	return res
}

// drop_beg discards the first `n` bytes from the buffer
pub fn (mut self Buffer) drop_beg(n int) {
	if n < self.len {
		len := self.len - n
		for i in 0 .. len {
			self.data[i] = self.data[n + i]
		}
		self.set_pos(len)
	} else {
		self.set_pos(0)
	}
}

// drop_end discards the last `n` bytes from the buffer
pub fn (mut self Buffer) drop_end(n int) {
	if n < self.len {
		self.len -= n
		self.data.trim(self.len)
	} else {
		self.set_pos(0)
	}
}

// set_pos resets the buffer to the given position
pub fn (mut self Buffer) set_pos(pos int) {
	self.data.trim(pos)
	self.len = pos
}

// push appends a single byte to the accumulated buffer
pub fn (mut self Buffer) push(b byte) {
	self.data << b
	self.len++
}

// push_many appends all bytes to the accumulated buffer
pub fn (mut self Buffer) push_many(data []byte) {
	self.write_ptr(data.data, data.len)
}

// write appends a string to the accumulated buffer
[inline]
pub fn (mut self Buffer) write(str string) {
	self.write_ptr(str.str, str.len)
}

// writeln appends a string and a newline character to the accumulated buffer
pub fn (mut self Buffer) writeln(str string) {
	self.write(str)
	self.push(`\n`)
}

// write_ptr appends `size` bytes to the accumulated buffer
pub fn (mut self Buffer) write_ptr(ptr &byte, size int) {
	unsafe { self.data.push_many(ptr, size) }
	self.len += size
}
