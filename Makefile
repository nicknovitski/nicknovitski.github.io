.PHONY: default check

default:
	jekyll build
	sed -i 's|nicknovitski.com/pages/nicknovitski|nicknovitski.com|' _site/*.html

check: default
	htmlproofer --internal-domains nicknovitski.com --assume-extension --check-html --check-opengraph ./_site
