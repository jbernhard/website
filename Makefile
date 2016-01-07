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
	sass --cache-location $(XDG_RUNTIME_DIR)/sass-cache css/main.scss | \
		cat css/normalize.css - | \
		postcss \
			--use autoprefixer --autoprefixer.browsers "last 2 versions, > 5%" \
			--use cssnano > $(css)

$(img):
	@rsync -rui --delete --info=name1,del img $(builddir)/

watch: all
	livereloadx --static $(builddir)

clean:
	rm -rfv $(targets)

.PHONY: all $(img) watch clean
