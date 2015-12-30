builddir ?= build

index = index.html
html = $(builddir)/$(index)

scss = css/main.scss
css = $(builddir)/main.css

img = $(builddir)/img


all: $(builddir) $(html) $(css) $(img)

$(builddir):
	mkdir -p $(builddir)

$(html): $(index)
	./render-template $(index) > $(html)

$(css): css/*css
	sass --style compressed $(scss) > $(css)

$(img):
	@rsync -ru --delete --info=name1,del img $(builddir)/


.PHONY: all $(img)
