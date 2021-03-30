module flag

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
					if res.len > 0 && res[0] != `-` {
						args.delete(index)
						return res
					}
				}
				break
			}
		}
	}
	return none
}
