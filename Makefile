.PHONY: default check

default:
	jekyll build

check: default
	htmlproofer --assume-extension ./_site
