builddir ?= build

index = index.html
html = $(builddir)/$(index)
css = $(builddir)/main.min.css
js = $(builddir)/site.min.js
img = $(builddir)/img
targets = $(html) $(css) $(js) $(img)

all: $(builddir) $(targets)

$(builddir):
	mkdir -p $(builddir)

$(html): $(index) sections/*.html data/*
	./render-template > $(html)

$(css): css/*css
	sass --cache-location $(XDG_RUNTIME_DIR)/sass-cache css/main.scss | \
		cat css/normalize.css - | \
		postcss \
			--no-map \
			--use autoprefixer --autoprefixer.browsers "last 2 versions, > 5%" \
			--use cssnano > $(css) 2> /dev/null

$(js): js/*.js
	uglifyjs js/*.js --compress --mangle > $(js)

$(img):
	@rsync -rui --delete --info=name1,del img $(builddir)/

watch: all
	livereloadx --static $(builddir)/

clean:
	rm -rfv $(targets)

.PHONY: all $(img) watch clean
