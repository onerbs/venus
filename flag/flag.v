module flag

import str

// bool check if a flag is present in the argument list
pub fn bool(mut args []string, flags []string) bool {
	mut status := false
	for flag in flags {
		index := args.index(flag)
		if index >= 0 {
			args.delete(index)
			status = true
		}
	}
	return status
}

// value get a flagged value from the argument list
pub fn value(mut args []string, flags []string) ?string {
	for flag in flags {
		for index in 0 .. args.len {
			if args[index] == flag {
				args.delete(index)
				if index < args.len {
					res := args[index]
					if res.len > 0 && res[0] != `-` { // !
						args.delete(index)
						return res // !
					}
				}
				break
			}
		}
	}
	return none
}

// todo: copy-paste ...

// float get a float value from the argument list
pub fn float(mut args []string, flags []string) ?f64 {
	for flag in flags {
		for index in 0 .. args.len {
			if args[index] == flag {
				args.delete(index)
				if index < args.len {
					res := args[index]
					if str.is_numeric(res) { // !
						args.delete(index)
						return res.f64() // !
					}
				}
				break
			}
		}
	}
	return none
}

// int get an integer value from the argument list
pub fn int(mut args []string, flags []string) ?int {
	for flag in flags {
		for index in 0 .. args.len {
			if args[index] == flag {
				args.delete(index)
				if index < args.len {
					res := args[index]
					if str.is_integer(res) { // !
						args.delete(index)
						return res.int() // !
					}
				}
				break
			}
		}
	}
	return none
}
