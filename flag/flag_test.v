module main

import xsh.flag

fn test_bool() {
	mut args := ['some', '--dir', 'argument', '-f']
	assert flag.bool(mut args, ['-d', '--dir'])
	assert flag.bool(mut args, ['-f', '--file'])
	assert !flag.bool(mut args, ['-h', '--help'])
	assert args == ['some', 'argument']
}

fn test_value() {
	mut args := ['some', '--dir', 'ahoy', 'argument', '-f']
	dir := flag.value(mut args, ['-d', '--dir']) or { 'some_dir' }
	file := flag.value(mut args, ['-f', '--file']) or { 'some_file' }
	assert dir == 'ahoy'
	assert file == 'some_file'
	assert args == ['some', 'argument']
}

fn test_value_two() {
	mut args := ['some', '-df', 'argument']
	dir := flag.value(mut args, ['-d', '--dir']) or { 'some_dir' }
	file := flag.value(mut args, ['-f', '--file']) or { 'some_file' }
	assert dir == 'some_dir'
	assert file == 'some_file'
	assert args == ['some', '-df', 'argument']
}
