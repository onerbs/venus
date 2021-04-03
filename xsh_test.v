module xsh

import os

const cwd = os.getwd()
const home = os.home_dir()

// this tests are not relevant in Windows

fn test_real_path() {
	assert real_path('') == cwd
	assert real_path('.') == cwd
	assert real_path('..') == os.dir(cwd)
	assert real_path('~') == home
	assert real_path('~/xsh') == '$home/xsh'
	assert real_path('~/xsh//../..') == '/home'
	assert real_path('/a/b/c//..//../x/./.') == '/a/x'
	assert real_path('/a//.//./') == '/a'
}

fn test_simple() {
	assert simple('') == ''
	assert simple('a') == 'a'
	assert simple('a/b') == 'b'
	assert simple('a/b.c') == 'b'
	assert simple('a/b.c.v') == 'b.c'
	assert simple('~/a/b.c.v') == 'b.c'
}
