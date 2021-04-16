module cmd

import table

enum KindOfFlag {
	bool
	float
	int
	string
}

pub struct FlagType {
pub:
	brief    string
	alias    rune
	name     string
	item     string
	required bool
	wide     bool
pub mut:
	value string
}

struct Flag {
	FlagType
pub:
	kind KindOfFlag [required]
}

pub fn (self Flag) str() string {
	mut result := self.get_alias()
	name := self.get_name()
	if name.len > 0 {
		if result.len > 0 {
			result += ', $name'
		} else {
			result += '$name'
		}
	}
	if self.item.len > 0 {
		result += ' <$self.item>'
	}
	return result
}

pub fn (self Flag) get_name() string {
	if self.name == '--' {
		return '--'
	}
	if self.name.len > 0 {
		return '--$self.name'
	}
	return ''
}

pub fn (self Flag) get_alias() string {
	if self.alias == `-` {
		return '-'
	}
	if self.alias > 0 {
		return '-${rune(self.alias)}'
	}
	return ''
}

// ----------------- flag_array.v

pub fn (ary []Flag) get(id string) ?Flag {
	if id.len > 0 {
		is_alias := id.len == 1
		for it in ary {
			if is_alias {
				if it.alias == id[0] {
					return it
				}
			} else {
				if it.name == id {
					return it
				}
			}
		}
	}
	return none
}

pub fn (ary []Flag) str() string {
	return ary.table_().str()
}

pub fn (ary []Flag) lines() []string {
	return ary.table_().lines()
}

pub fn (ary []Flag) table_() table.Table {
	// todo: memo.
	matrix := ary.map(['$it', it.brief])
	return table.new(gap: 4).matrix(matrix)
}

// -----------------

// pub fn (ary []Flag) str() string {
// 	mut matrix := [][]string{}
// 	hlf, hsf := ary.stats()
// 	for it in ary {
// 		if hsf && it.alias == `-` {
// 			matrix << [' $it', it.brief]
// 			continue
// 		}
// 		if hlf && it.alias == `-` {
// 			matrix << ['  $it', it.brief]
// 			continue
// 		}
// 		it_str := '$it'
// 		if hlf && it_str[0] == `-` && it_str[1].is_letter() {
// 			matrix << [' $it_str', it.brief]
// 			continue
// 		}
// 		matrix << [it_str, it.brief]
// 	}
// 	return table(gap: 4).matrix(matrix).str()
// }

// fn (ary []Flag) stats() (bool, bool) {
// 	mut hlf := false
// 	mut hsf := false
// 	// todo: better way to detect.
// 	for it in ary.map('$it') {
// 		if it.starts_with('--') {
// 			hlf = true
// 		} else if it.starts_with('-') {
// 			hsf = true
// 		}
// 	}
// 	return hlf, hsf
// }
