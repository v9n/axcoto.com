WORKDIR = $(shell pwd)
CSS_REV = "main-$(shell md5 -r $(WORKDIR)/public/css/main.css | awk '{print $$1}').css"

server:
	hugo server --theme=axcoto --buildDrafts --watch

asset:
	cd public/css && pwd && cp main.css "main-$(shell md5 -r $(WORKDIR)/public/css/main.css | awk '{print $$1}').css"
	echo $(CSS_REV)
	find public -name "*.html" -print0 | xargs -0 -I filename /bin/bash -c "echo filename; sed 's/css\/main.css/css\/$(CSS_REV)/g' filename > tmp; mv tmp filename"

build:
	hugo --theme=axcoto

build_draft:
	hugo --theme=axcoto --buildDrafts

add_subtree:
	git subtree add --prefix=public origin public --squash

pull_subtree:
	git subtree pull --prefix=public origin public

push_subtree:
	git subtree push --prefix=public origin public

deploy: push_subtree

ssh_deploy:
	ssh kurei@noty "bash deploy-axcoto.sh"
