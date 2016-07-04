server:
	hugo server --theme=axcoto --buildDrafts --watch

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
