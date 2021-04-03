module xsh

import os
import str

pub const (
	origin = os.executable()
	cmd_file = os.args[0]
	cmd_name = os.base(cmd_file)
	cmd_real_name = os.base(origin)

	is_quiet   = str.is_true(os.getenv('QUIET'))
	is_debug   = !is_quiet && str.is_true(os.getenv('DEBUG'))
	is_verbose = !is_quiet && str.is_true(os.getenv('VERBOSE'))
)

// get_args return the command-line arguments
pub fn get_args() []string {
  return os.args[1..]
}

// need_args ensures that the user have passed a certain
// number of command-line arguments to the program
pub fn need_args(count int) ?[]string {
  args := get_args()
	if args.len < count {
		not_enough('arguments', count, args.len) ?
	}
	return args
}

// need_env ensures that the specified environment variable has a value
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

// simple return the file name without extension
pub fn simple(base string) string {
	if str.is_blank(base) {
		return ''
	}
	parts := os.file_name(base).split('.')
	if parts.len == 1 {
		return parts[0]
	}
	return parts[..parts.len - 1].join('.')
}
