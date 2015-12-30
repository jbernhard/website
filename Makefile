builddir ?= build

index = index.html
html = $(builddir)/$(index)
css = $(builddir)/main.min.css
img = $(builddir)/img
targets = $(html) $(css) $(img)

all: $(builddir) $(targets)

$(builddir):
	mkdir -p $(builddir)

$(html): $(index) sections/*.html data/*
	./render-template > $(html)

$(css): css/*css
	sass css/main.scss | cat css/normalize.css - | cleancss > $(css)

$(img):
	@rsync -rui --delete --info=name1,del img $(builddir)/

clean:
	@rm -rv $(targets)

.PHONY: all $(img) clean
