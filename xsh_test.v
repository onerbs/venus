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
