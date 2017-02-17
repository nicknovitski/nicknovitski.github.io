.PHONY: default check

default:
	jekyll build

check: default
	htmlproofer --assume-extension --check-html --check-opengraph ./_site
