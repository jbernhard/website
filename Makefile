builddir ?= build

index = index.html
html = $(builddir)/$(index)
css = $(builddir)/style.min.css
img = $(builddir)/img
targets = $(html) $(css) $(img)

all: $(builddir) $(targets)

$(builddir):
	mkdir -p $(builddir)

$(html): $(index)
	./render-template > $(html)

$(css): css/*css
	sass css/main.scss | \
		cat css/normalize.css - | \
		postcss \
			--no-map \
			--use autoprefixer --autoprefixer.browsers "last 2 versions, > 5%" \
			--use cssnano > $(css)

$(img):
	@cp -rluv img $(builddir)

clean:
	rm -rfv $(targets)

.PHONY: all $(img) clean
