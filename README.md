# hello this is chronical

its still in development, written in V

## build

before everything install vlang and SuperErnD.cn package (just `v install SuperErnD.cn`)

### client:

about dependecies read [here](https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux)

to build client (server not yet ready) you need run that (for linux):

```sh 
cd client

make build # (production) make sure if you installed depends for raylib, and v

make devbuild # (development) same as ^^

make devrun # (development) simply v . && ./client, read about depends ^^^
```

### api:

via docker:

just `docker compose up`

manually:

install sqlite3-devel (or similar) and vlang, and thats all what you need

and then just in console `v run .`

## license

its ISC, read more in [LICENSE file](./LICENSE)