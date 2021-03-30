module xsh

import style

// report print an error as a warning message and exit with the error code
pub fn report(err IError) {
	eprintln('$style.error_tag: $cmd_name: $err.msg')
	exit(err.code)
}

// info print an informative message
pub fn info(msg string) {
	if is_debug {
		eprintln('$style.info_tag $cmd_name: $msg')
	}
}

// warn print a warning message
pub fn warn(msg string) {
	if is_debug {
		eprintln('$style.warn_tag: $cmd_name: $msg')
	}
}

// debug print a debug message
pub fn debug(msg string) {
	if is_debug {
		eprintln(style.dim('$cmd_name: $msg'))
	}
}

// verbose print a verbose message
pub fn verbose(msg string) {
	if is_verbose {
		tag := style.title(cmd_name)
		eprintln('$tag: $msg')
	}
}

// ----------------- errors

// fail raise an error with exit code `1`
pub fn fail(msg string) ? {
	return error_with_code(msg, 1)
}

// fatal raise an error with exit code `2`
pub fn fatal(msg string) ? {
	return error_with_code(msg, 2)
}

// missing
pub fn missing(kind string, name string) ? {
	fail('missing $kind ${style.meta(kind)}') ?
}

// missing_value
pub fn missing_value(kind string, name string) ? {
	fail('missing value for $kind ${style.meta(name)}') ?
}

// unknown
pub fn unknown(kind string, value string) ? {
	fail('unknown $kind ${style.meta(value)}') ?
}

// not_enough
pub fn not_enough(kind string, want int, actual int) ? {
	fail('not enough $kind: ' + expected('$want', '$actual')) ?
}

// not_expected
pub fn not_expected(value string, kind string) ? {
	fail(expected(kind, value)) ?
}

// expected
pub fn expected(kind string, value string) string {
	return 'expected $kind, got ${style.style(value, '1')}'
}
