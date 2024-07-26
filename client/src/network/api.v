// A file which implements API

module network

import net.http

// API structures

pub struct APIError {
	error string
}

// end

const api_endpoint = $d("api", "http://localhost:8080") // define your own API by adding -d api=server

pub const gapi = create_api() // global api

fn create_api() &API {
	mut api := API{}

	return &api
}

pub struct API {
pub mut:
	api_url string = api_endpoint
mut:
	auth_token string
	refresh_token string
}

// Actually this doesnt "login", just checks the token by getting self and writes token to struct
pub fn (mut api API) login_via_auth_token(auth_token string) ! {
	mut response := http.fetch(
		url: "${api.api_url}/me",
		header: http.new_header(key: .authorization, value: auth_token)
	)!

	if response.status_code != 200 {
		return error("Token is not valid seems")
	} else {
		// now we should write token!
		api.auth_token = auth_token
	}
}

// get connection token
pub fn (mut api API) connect() !string { 
	if api.auth_token == '' {
		return error("no valid token")
	}

	mut response := http.fetch(
		url: "${api.api_url}/initiate_connect",
		header: http.new_header(key: .authorization, value: api.auth_token)
	)!

	if response.status_code != 200 {
		return error("something went wrong!")
	} else {
		return response.body
	}
}