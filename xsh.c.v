module xsh

import str.buffer
import os

// get_input read data from the standard input
// trailing white spaces are trimmed from the result
pub fn get_input() string {
	mut buf := buffer.new()
	for {
		c := C.getchar()
		if c < 0 {
			break
		}
		buf.push(byte(c))
	}
	return buf.trim()
}

// get_lines read all lines from the standard input
// trailing white spaces are trimmed from every line
// the result does not contains empty lines
pub fn get_lines() []string {
	mut res := []string{}
	mut buf := buffer.new()
	for {
		c := C.getchar()
		if c < 0 {
			break
		}
		if c == `\n` {
			s := buf.trim()
			if s.len > 0 {
				res << s
			}
		} else {
			buf.push(byte(c))
		}
	}
	return res
}

fn C.fgetc(&C.FILE) int

// read_file read the content of the given file
// trailing white spaces are trimmed from the result
pub fn read_file(file string) ?string {
	fp := os.vfopen(file, 'r') ?
	mut buf := buffer.new()
	for {
		c := C.fgetc(fp)
		if c < 0 {
			break
		}
		buf.push(byte(c))
	}
	C.fclose(fp)
	return buf.trim()
}

// read_file read the lines of the given file
// trailing white spaces are trimmed from every line
// the result does not contains empty lines
pub fn read_lines(file string) ?[]string {
	fp := os.vfopen(file, 'r') ?
	mut buf := buffer.new()
	mut res := []string{}
	for {
		c := C.fgetc(fp)
		if c < 0 {
			break
		}
		if c == `\n` {
			s := buf.trim()
			if s.len > 0 {
				res << s
			}
		} else {
			buf.push(byte(c))
		}
	}
	C.fclose(fp)
	if buf.len > 0 {
		res << buf.trim()
	}
	return res
}
