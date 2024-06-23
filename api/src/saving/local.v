module saving

import crypto.sha1
import encoding.hex
import toml
import os

pub struct LocalSaver {
mut:
	config toml.Doc
}

pub fn (mut ls LocalSaver) init(doc toml.Doc) ! {
	ls.config = doc
}

pub fn (mut ls LocalSaver) save(data []u8) !string {
	hash := hex.encode(sha1.sum(data))
	hash2 := hash[..2]

	mut f := os.create('${ls.config.value('saver.backend_connect').string()}/${hash2}/${hash}')!

	f.write(data)!

	f.close()

	return hash
}

pub fn (mut ls LocalSaver) delete(hash string) ! {
	hash2 := hash[..2]
	os.rm('${ls.config.value('saver.backend_connect').string()}/${hash2}/${hash}')!
}

pub fn (mut ls LocalSaver) get(hash string) ![]u8 {
	hash2 := hash[..2]
	mut f := os.open('${ls.config.value('saver.backend_connect').string()}/${hash2}/${hash}')!

	f.seek(0, .end)!
	mut size := f.tell()!
	f.seek(0, .start)!

	return f.read_bytes(int(size))
}
