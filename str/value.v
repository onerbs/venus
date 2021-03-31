module str

// is_true check if the provided string indicates a boolean true
pub fn is_true(value string) bool {
	return value in ['true', 'on', '1']
}
