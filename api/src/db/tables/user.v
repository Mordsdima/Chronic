module tables

pub struct User {
pub mut:
	id            int    @[primary; sql: serial]
	name          string @[unique]
	password_hash string
	salt          string @[unique]
	bio           string
	avatar        string // todo
	banner        string // todo
	country       string
}
