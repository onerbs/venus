module str

// is_blank returns `true` if the string is empty
// or contains only white space characters
pub fn is_blank(s string) bool {
	if s.len > 0 {
		mut beg := 0
		mut end := s.len - 1
		for end >= beg {
			if !s[beg].is_space() || !s[end].is_space() {
				return false
			}
			beg++
			end--
		}
	}
	return true
}

// is_numeric check if the provided string is a number
pub fn is_numeric(n string) bool {
	match n.len {
		0 { return false }
		1 { return n[0].is_digit() }
		else {
			if !n[0].is_digit() && n[0] !in [`+`, `-`, `.`] {
				return false
			}
			// todo: scientific, binary, octal and hex notation
			mut dotted := false
			for c in n[1..] {
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
		}
	}
	return n[n.len - 1] != `.`
}

// is_integer check if the provided string is an integer
pub fn is_integer(n string) bool {
	return !n.contains('.') && is_numeric(n)
}

// is_true check if the provided string indicates a boolean true
pub fn is_true(value string) bool {
	return value in ['true', 'on', '1']
}
