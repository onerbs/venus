module xsh

import os

// get_input read from the standard input but allow empty lines
pub fn get_input() string {
	mut buff := []byte{cap: 0x400}
	for {
		c := C.getchar()
		if c < 0 {
			break
		}
		buff << byte(c)
	}
	return flush(buff)
}

// get_lines read all lines from the standard input but allow empty lines
pub fn get_lines() []string {
	mut buff := []byte{cap: 0x100}
	mut lines := []string{}
	for {
		c := C.getchar()
		if c < 0 {
			break
		}
		if c == `\n` {
			if buff.len > 0 {
				lines << flush(buff)
				buff = []byte{cap: 0x100}
			}
		} else {
			buff << byte(c)
		}
	}
	return lines
}

fn C.fgetc(&C.FILE) int

// read_file read the content of the given text file
pub fn read_file(file string) ?string {
	fp := os.vfopen(file, 'r') ?
	mut buff := []byte{cap: 0x400}
	for {
		c := C.fgetc(fp)
		if c < 0 {
			break
		}
		buff << byte(c)
	}
	C.fclose(fp)
	return flush(buff)
}

// read_file read the lines of the given text file
pub fn read_lines(file string) ?[]string {
	fp := os.vfopen(file, 'r') ?
	mut buff := []byte{cap: 0x100}
	mut lines := []string{}
	for {
		c := C.fgetc(fp)
		if c < 0 {
			break
		}
		if c == `\n` {
			if buff.len > 0 {
				lines << flush(buff)
				buff = []byte{cap: 0x100}
			}
		} else {
			buff << byte(c)
		}
	}
	C.fclose(fp)
	if buff.len > 0 {
		lines << flush(buff)
	}
	return lines
}

fn flush(buff []byte) string {
	return string(buff).trim_space()
}
