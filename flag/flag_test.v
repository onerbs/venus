module main

import xsh.flag

fn test_got() {
	mut args := ['some', '--dir', 'argument', '-f']
	assert flag.got(mut args, '-d', '--dir')
	assert flag.got(mut args, '-f', '--file')
	assert !flag.got(mut args, '-h', '--help')
	assert args == ['some', 'argument']
}

fn test_get() {
	mut args := ['some', '-d', 'ahoy', 'argument', '-f']
	f_d := flag.get(mut args, '-d') or { 'some_d' }
	f_f := flag.get(mut args, '-f') or { 'some_f' }
	assert f_d == 'ahoy'
	assert f_f == 'some_f'
	assert args == ['some', 'argument']
}

fn test_get_two() {
	mut args := ['some', '-df', 'argument']
	f_d := flag.get(mut args, '-d') or { 'some_d' }
	f_f := flag.get(mut args, '-f') or { 'some_f' }
	assert f_d == 'some_d'
	assert f_f == 'some_f'
	assert args == ['some', '-df', 'argument']
}

fn test_float() {
	mut args := ['some', '-w', '0.88', 'plus']
	f_w := flag.float(mut args, '-w') or { 45.3 }
	f_z := flag.float(mut args, '-z') or { 66 }
	assert f_w == 0.88
	assert f_z == 66.0
	assert args == ['some', 'plus']
}

fn test_float_two() {
	mut args := ['some', '-w', 'plus']
	f_w := flag.float(mut args, '-w') or { 45.3 }
	f_z := flag.float(mut args, '-z') or { 66 }
	assert f_w == 45.3
	assert f_z == 66.0
	assert args == ['some', 'plus']
}
