module xsh

import os
import str

pub const (
	args = os.args[1..]
	origin = os.executable()
	cmd_file = os.args[0]
	cmd_name = os.base(cmd_file)
	cmd_real_name = os.base(origin)

	is_quiet   = str.is_true(os.getenv('QUIET'))
	is_debug   = !is_quiet && str.is_true(os.getenv('DEBUG'))
	is_verbose = !is_quiet && str.is_true(os.getenv('VERBOSE'))
)

// need_args ensures that the user have passed a certain
// number of command-line arguments to the program
pub fn need_args(count int) ?[]string {
	if args.len < count {
		not_enough('arguments', count, args.len) ?
	}
	return args
}

pub fn need_env(name string) ?string {
	value := os.getenv(name)
	if value.len == 0 {
		missing_value('environment variable', name) ?
	}
	return value
}

// from_home prepends the user home directory to the specified path
pub fn from_home(dirs ...string) string {
	return os.join_path(os.home_dir(), ...dirs)
}

// get the current PATH as a list
pub fn user_path() []string {
	return os.getenv('PATH').split(os.path_delimiter)
}

// real_path will obtain the absolute path to the requested resource
// this will attempt to build the path if points to a nonexistent file
// this function is not relevant in Windows
pub fn real_path(base string) string {
	if str.is_blank(base) {
		return os.getwd()
	}
	mut path := os.real_path(base)
	$if windows {
		return path
	}
	if path[0] == `~` {
		// it seems that real_path does not resolve this
		path = path.replace_once('~', os.home_dir())
	}
	if os.exists(path) {
		return path
	}
	// brute force ...
	if path.starts_with('./') {
		path = os.getwd() + path[1..]
	}
	if path.starts_with('../') {
		path = os.dir(os.getwd()) + path[2..]
	}
	for path.contains('//') {
		path = path.replace_once('//', '/')
	}
	for path.contains('/./') {
		path = path.replace_once('/./', '/')
	}
	for path.contains('/../') {
		parts := path.split_nth('/..', 2)
		path = os.dir(parts[0]) + parts[1]
	}
	if path.ends_with('/..') {
		path = os.dir(path[..path.len - 3])
	}
	if path.ends_with('/.') {
		path = path[..path.len - 2]
	}
	return path.trim_right('/')
}
