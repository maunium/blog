push: build
	git push
	scp -r public/* meow:/srv/web/maunium.net/blog/

export PATH := $(PATH):/usr/local/nodejs/bin

style:
	node-sass --output static/static/css static/static/css/style.scss
	node-sass --output static/static/css static/static/css/spf13-1.scss

build: style
	hugo
