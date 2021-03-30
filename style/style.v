module style

pub const (
	error_tag  = fail('Error')
	warn_tag   = warn('Warning')
	info_tag   = info('(i)')
)

pub fn title(msg string) string {
	return style(msg, '1')
}

pub fn high(msg string) string {
	return bold(msg, '34')
}

pub fn meta(msg string) string {
	return style('"$msg"', '35')
}

pub fn dim(msg string) string {
	return style(msg, '2')
}

pub fn good(msg string) string {
	return bold(msg, '32')
}

pub fn info(msg string) string {
	return bold(msg, '33')
}

pub fn warn(msg string) string {
	return bold(msg, '35')
}

pub fn fail(msg string) string {
	return bold(msg, '31')
}

pub fn bold(msg string, mode string) string {
	return style(msg, '1;$mode')
}

pub fn style(msg string, mode string) string {
	return '\e[${mode}m$msg\e[m'
}
