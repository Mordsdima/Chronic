module config

import os
import x.json2
import engine

pub struct LoginInformation {
pub mut:
	auth_token string
	refresh_token string
}

fn get_login_information_internal() !LoginInformation {
	return json2.decode[LoginInformation](os.read_file(engine.get_save_directory()! + '/Chronical/login.json')!)
}

pub fn get_login_information() LoginInformation {
	return get_login_information_internal() or { LoginInformation{} }
}