module table

struct Table {
mut:
	rows  [][]string
	metro []int
	gap   string
}

// new create a configuration object
pub fn new(cfg Config) Config {
	return cfg
}

// source create a table from a string
pub fn source(source string) Table {
	return new({}).source(source)
}

// lines create a table from a list of lines
pub fn lines(lines []string) Table {
	return new({}).lines(lines)
}

// matrix create a table from a string matrix
pub fn matrix(matrix [][]string) Table {
	return new({}).matrix(matrix)
}

pub fn (self Table) str() string {
	return self.lines().join_lines()
}

pub fn (self Table) lines() []string {
	mut res := []string{}
	for row in self.cells() {
		mut until := row.len
		for until > 0 {
			if row[until - 1].len > 0 {
				break
			}
			until--
		}
		limit := until - 1
		mut line := []string{}
		for ix in 0 .. limit {
			line << grow(row[ix], self.metro[ix])
		}
		if limit >= 0 {
			line << row[limit]
		}
		res << line.join(self.gap)
	}
	return res
}

pub fn (self Table) cells() [][]string {
	return self.rows
}

fn grow(cell string, metro int) string {
	if metro > cell.len {
		return cell + ' '.repeat(metro - cell.len)
	}
	return cell
}

// -----------------

pub struct Config {
pub mut:
	rd  string = '\n'
	cd  string = ':'
	gap byte   = 2
}

// source create a table from a string
pub fn (cfg Config) source(source string) Table {
	return cfg.lines(source.split(cfg.rd))
}

// lines create a table from a list of lines
pub fn (cfg Config) lines(lines []string) Table {
	return cfg.matrix(lines.map(it.split(cfg.cd)))
}

// matrix create a table from a string matrix
pub fn (cfg Config) matrix(matrix [][]string) Table {
	mut metro := []int{}
	for row in matrix {
		for ix in 0 .. row.len {
			row_len := row[ix].len
			if metro.len == ix {
				metro << row_len
			} else if row_len > metro[ix] {
				metro[ix] = row_len
			}
		}
	}
	// trim empty columns on the right
	mut until := metro.len
	for until > 0 {
		if metro[until - 1] > 0 {
			break
		}
		until--
	}
	metro = metro[..until]
	rows := matrix.map(parse_row(it, metro))
	gap := ' '.repeat(cfg.gap)
	return Table{rows, metro, gap}
}

// parse_row create a fixed-size row
fn parse_row(row []string, metro []int) []string {
	mut res := []string{len: metro.len}
	for i in 0 .. row.len {
		it := row[i]
		if it.len > 0 {
			res[i] = it
		}
	}
	return res
}
