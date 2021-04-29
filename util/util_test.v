module util

fn test_get_kv() {
	mut a, mut b := get_kv('a = b', ' = ')
	assert a == 'a'
	assert b == 'b'

	a, b = get_kv('c: no', ': ')
	assert a == 'c'
	assert b == 'no'

	a, b = get_kv('some', ' = ')
	assert a == 'some'
	assert b == ''
}

fn test_int() {
	assert min(0, 4) == 0
	assert min(4, 6) == 4
	assert min(6, 2) == 2

	assert max(0, 4) == 4
	assert max(4, 6) == 6
	assert max(6, 2) == 6
}

fn test_float() {
	assert min(0.5, 4.3) == 0.5
	assert min(4.5, 6.3) == 4.5
	assert min(6.5, 2.3) == 2.3

	assert max(0.5, 4.3) == 4.3
	assert max(4.5, 6.3) == 6.3
	assert max(6.5, 2.3) == 6.5
}
