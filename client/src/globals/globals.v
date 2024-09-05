module globals

import network

pub const gapi = network.create_api() // global api
pub const gmanager = network.create_manager()