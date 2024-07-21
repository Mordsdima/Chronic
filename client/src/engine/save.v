module engine

import os

pub fn get_save_directory() !string {
	return os.config_dir()!
}