module main

import xsh.str.buffer

fn test_drop_beg() {
	mut buf := buffer.new()
	buf.write('hello, darling')
	buf.drop_beg(7)
	assert buf.str() == 'darling'
}

fn test_drop_end() {
	mut buf := buffer.new()
	buf.write('hello, darling')
	buf.drop_end(9)
	assert buf.str() == 'hello'
}

fn test_push() {
	mut buf := buffer.new()
	buf.push(`a`)
	buf.push(`h`)
	buf.push(`o`)
	buf.push(`y`)
	assert buf.str() == 'ahoy'
}

fn test_push_many() {
	mut buf := buffer.new()
	buf.push_many('ahoy'.bytes())
	assert buf.str() == 'ahoy'
}

fn test_write() {
	mut buf := buffer.new()
	buf.write('ahoy')
	buf.write('ahoy')
	assert buf.str() == 'ahoyahoy'

	buf.write('ahoy')
	assert buf.str() == 'ahoy'
}

fn test_writeln() {
	mut buf := buffer.new()
	buf.writeln('ahoy')
	buf.writeln('ahoy')
	assert buf.str() == 'ahoy\nahoy\n'

	buf.writeln('ahoy')
	assert buf.str() == 'ahoy\n'
}
