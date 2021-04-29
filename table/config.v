module table

pub struct Config {
pub mut:
	rd  string = '\n'
	cd  string = ':'
	gap byte   = 2
}

// source create a `Table` from a string
pub fn (cfg Config) source(raw string) Table {
	return cfg.lines(raw.split(cfg.rd))
}

// lines create a `Table` from a list of lines
pub fn (cfg Config) lines(raw []string) Table {
	return cfg.matrix(raw.map(it.split(cfg.cd)))
}

// matrix create a `Table` from a string matrix
pub fn (cfg Config) matrix(raw [][]string) Table {
	mut size := []int{}
	for row in raw {
		for ix in 0 .. row.len {
			row_len := row[ix].len
			if size.len == ix {
				size << row_len
			} else if row_len > size[ix] {
				size[ix] = row_len
			}
		}
	}
	// drop empty cells on the right
	mut lim := size.len - 1
	for ; size[lim] == 0; lim-- {}
	size.trim(lim + 1)
	return Table{
		size: size
		data: raw.map(row(it, size))
		gap: ' '.repeat(cfg.gap)
	}
}

fn row(data []string, size []int) []string {
	mut res := []string{len: size.len}
	for i in 0 .. data.len {
		it := data[i]//.trim_space()
		if it.len > 0 {
			res[i] = it
		}
	}
	return res
}
