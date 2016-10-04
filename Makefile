.PHONY: check

_site:
	jekyll build

check:
	htmlproofer --assume-extension ./_site
