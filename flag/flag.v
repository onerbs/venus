module flag

import str

// got check if a flag is present in the args
pub fn got(mut args []string, flags ...string) bool {
	for it in flags {
		ix := args.index(it)
		if ix >= 0 {
			args.delete(ix)
			return true
		}
	}
	return false
}

// Q: parse flags in the form `--some=soma` ?

// get returns a value from the argument list
pub fn get(mut args []string, flags ...string) ?string {
	ix, res := get_index(mut args, flags) ?
	if !is_flag(res) {
		args.delete(ix)
		return res
	}
	return none
}

// float returns a float value from the argument list
pub fn float(mut args []string, flags ...string) ?f64 {
	ix, res := get_index(mut args, flags) ?
	if str.is_numeric(res) {
		args.delete(ix)
		return res.f64()
	}
	return none
}

// int returns an integer value from the argument list
pub fn int(mut args []string, flags ...string) ?int {
	ix, res := get_index(mut args, flags) ?
	if str.is_integer(res) {
		args.delete(ix)
		return res.int()
	}
	return none
}

// get_index returns the index of the flag value
fn get_index(mut args []string, flags []string) ?(int, string) {
	for it in flags {
		for ix in 0 .. args.len {
			if args[ix] == it {
				args.delete(ix)
				if ix < args.len {
					return ix, args[ix]
				}
				break
			}
		}
	}
	return none
}

// is_flag check if the provided value is a flag or not
fn is_flag(raw string) bool {
	return match raw.len {
		0 { false }
		1 { raw == '-' }
		else { raw[0] == `-` && !raw[1].is_digit() }
	}
}
