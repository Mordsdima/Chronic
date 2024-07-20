// A file which implements API

module network

const api_endpoint = $d("api", "http://localhost:8000") // define your own API by adding -d api=server

pub struct API {
pub mut:
	api_url string
mut:
	auth_token string
	refresh_token string
}