server:
	hugo server --theme=axcoto --buildDrafts --watch

build:
	hugo --theme=axcoto

build_draft:
	hugo --theme=axcoto --buildDrafts

add_subtree:
	git subtree add --prefix=public origin master --squash

pull_subtree:
	git subtree pull --prefix=public origin master

push_subtree:
	git subtree push --prefix=public origin master

deploy: push_subtree
