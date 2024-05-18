install:
	bundle install
	yarn

start:
	bin/dev

console:
	bin/rails console

test:
	yarn run build
	yarn run build:css
	NODE_ENV=test bundle exec rake test

lint:
	bundle exec rubocop

secrets:
	cp .env.example .env

.PHONY: test