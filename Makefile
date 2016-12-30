default:
	node-sass --output static/static/css static/static/css/style.scss
	node-sass --output static/static/css static/static/css/spf13-1.scss


push:
	git push
	ssh nginx 'cd /srv/blog && git pull && hugo'
