.PHONY: default check

default:
	jekyll build

check:
	htmlproofer --assume-extension ./_site
