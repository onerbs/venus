module str

fn test_is_true() {
	assert is_true('true')
	assert is_true('1')
	assert is_true('on')
	assert !is_true('false')
	assert !is_true('0')
	assert !is_true('off')
	assert !is_true('other')
	assert !is_true('')
}
