COMP_STYL=$(shell find components -type f -name "*.styl")

default: components node_modules index.js build/build.css template.html test.html

build/build.js: index.js index.styl
	@component build --dev --use stylus

build/build.css: index.js index.styl $(COMP_STYL)
	@component build --dev --use stylus

template.html: template.jade
	@./node_modules/.bin/jade $< && \
		component convert $@

test.html: test.jade
	@./node_modules/.bin/jade $<

node_modules: package.json
	@npm install

components: component.json
	@component install --dev

clean:
	rm -fr build components

.PHONY: clean build
