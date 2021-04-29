module util

// get_kv extract a key-value pair from a string
pub fn get_kv(raw string, delim string) (string, string) {
	if !raw.contains(delim) {
		return raw, ''
	}
	parts := raw.split_nth(delim, 2)
	return parts[0], parts[1]
}

// max get the maximum value of the two provided
pub fn max<T>(a T, b T) T {
	if a > b {
		return a
	}
	return b
}

// min get the minimum value of the two provided
pub fn min<T>(a T, b T) T {
	if a < b {
		return a
	}
	return b
}
