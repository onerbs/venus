module str

fn test_is_blank() {
	assert is_blank('')
	assert is_blank(' ')
	assert is_blank(' \n ')
	assert is_blank('\n\t  ')
	assert is_blank('   \f ')
	assert is_blank('   \v   ')
	assert !is_blank('    a')
	assert !is_blank('a    ')
	assert !is_blank('  a   ')
	assert !is_blank('   🤠  ')
}

fn test_is_numeric() {
	assert is_numeric('235')
	assert is_numeric('1')
	assert is_numeric('5.6')
	assert is_numeric('.5')
	assert is_numeric('-46')
	assert !is_numeric('5.')
	assert !is_numeric('3f')
	assert !is_numeric('')
}

fn test_is_ingeger() {
	assert is_integer('235')
	assert is_integer('1')
	assert !is_integer('5.6')
	assert !is_integer('.5')
	assert is_integer('-46')
	assert !is_integer('5.')
	assert !is_integer('3f')
	assert !is_integer('')
}

fn test_is_true() {
	assert is_true('true')
	assert is_true('yes')
	assert is_true('on')
	assert is_true('1')
	assert !is_true('false')
	assert !is_true('no')
	assert !is_true('off')
	assert !is_true('0')
	assert !is_true('other')
	assert !is_true('')
}
