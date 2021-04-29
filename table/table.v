module table

struct Table {
mut:
	data [][]string
	size []int
	gap  string
}

// new define the new Table configuration
pub fn new(cfg Config) Config {
	return cfg
}

// source create a Table from a string
pub fn source(source string) Table {
	return new({}).source(source)
}

// lines create a Table from a list of lines
pub fn lines(lines []string) Table {
	return new({}).lines(lines)
}

// matrix create a Table from a string matrix
pub fn matrix(matrix [][]string) Table {
	return new({}).matrix(matrix)
}

// str returns a string representation of this `Table`
pub fn (self Table) str() string {
	return self.lines().join_lines()
}

// lines returns the lines on this Table
pub fn (self Table) lines() []string {
	mut res := []string{}
	for row in self.data {
		// drop empty cells on the right
		mut end := row.len - 1
		for ; end >= 0; end-- {
			if row[end].len > 0 {
				break
			}
		}
		mut line := []string{}
		for ix in 0 .. end {
			line << grow(row[ix], self.size[ix])
		}
		if end >= 0 {
			line << row[end]
		}
		res << line.join(self.gap)
	}
	return res
}

// cells returns the cells on this Table
pub fn (self Table) cells() [][]string {
	return self.data
}

// grow append spaces to the end of a string to match the specified size
fn grow(src string, size int) string {
	delta := size - src.len
	if delta > 0 {
		gap := ' '.repeat(delta)
		return '$src$gap'
	}
	return src
}
