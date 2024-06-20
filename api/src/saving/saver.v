module saving

import toml

pub interface Saver {
mut:
	// a interface which describes interface between server and saver (like s3, local, etc.)
	init(toml.Doc) ! // doesnt yet have parameters
	save([]u8) !string // input type is file, return is hash or similar
	delete(string) ! // delete file by hash
	get(string) ![]u8 // get file by hash
}