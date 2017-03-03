WORKDIR = $(shell pwd)

CSS_DIR = public/css
CSS_FILE = $(CSS_DIR)/main.css
CSS_REV = main-$(shell md5 -r $(WORKDIR)/$(CSS_FILE) | awk '{print $$1}').css

server:
	hugo server --theme=axcoto --buildDrafts --watch

asset:
	cp $(CSS_FILE) "$(CSS_DIR)/main-$(shell md5 -r $(CSS_FILE) | awk '{print $$1}').css"
	echo $(CSS_REV)
	find public -name "*.html" -print0 | xargs -0 -I filename /bin/bash -c "echo filename; sed 's/css\/main.css/css\/$(CSS_REV)/g' filename > tmp; mv tmp filename"

generate:
	hugo --theme=axcoto

build: generate asset

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
	ssh axcoto "bash deploy-axcoto.sh"
