build:
	MIX_ENV=prod mix deps.get
	MIX_ENV=prod mix escript.build

watch:
	fswatch -0 ./lib | xargs -0 -I {} make build
