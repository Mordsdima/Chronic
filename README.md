# ⚠️ Maintenance notice ⚠️

# Chronical is now slowly developed due to problems with electrical problems

Is that end?

No, its not end, its a temporary notice, maybe when i can use computer in my free time that notice will be removed.

# ⚠️ Maintenance notice ⚠️

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

## also btw about naming (in russian, i am lazy to translate)

```В общем, полное название хроника это - Chronical Adventure, который я сократил до хроникал а потом уже хроник, adventure это понятно, но насчёт хроникал, хроникал как раз от слова "хроническое" или типо того, я знал что есть такое слово хроническое, но не знал что оно значит, а по мне это звучало прикольно, да и досихпор как по мне звучит прикольно, сейчас я знаю что такое хроническое, и в целом получается щас хроник = хроникал = Chronical Adventure, что если сильно дословно переводить то это получается неизлечимое приключение?```