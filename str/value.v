module str

// is_blank returns `true` if the string is empty
// or contains only white space characters
pub fn is_blank(s string) bool {
	if s.len == 0 { return true }
	mut beg := 0
	mut end := s.len - 1
	for ; s[beg].is_space(); beg++ {
		if beg == end {
			return true
		}
	}
	return false
}

// is_numeric check if the provided string is a number
pub fn is_numeric(raw string) bool {
	if raw.len == 0 { return false }
	if raw.len == 1 { return raw[0].is_digit() }

	// todo: scientific notation.

	mut dotted := raw[0] == `.`
	if !dotted && !raw[0].is_digit() && raw[0] !in [`+`, `-`] {
		return false
	}
	for c in raw[1..] {
		if c == `.` {
			if dotted {
				return false
			}
			dotted = true
		}
		else if !c.is_digit() {
			return false
		}
	}
	return raw[raw.len - 1] != `.`
}

// is_integer check if the provided string is an integer
pub fn is_integer(n string) bool {
	return !n.contains('.') && is_numeric(n)
}

// is_true check if the value indicates a boolean `true`
pub fn is_true(value string) bool {
	return value.to_lower() in ['true', 'yes', 'on', '1']
}
