builddir ?= build

index = $(builddir)/index.html
redirects = $(addprefix $(builddir)/, $(addsuffix .html,resume talks papers))
css = $(builddir)/style.min.css
img = $(builddir)/img
targets = $(index) $(redirects) $(css) $(img)

all: $(builddir) $(targets)

$(builddir):
	mkdir -p $(builddir)

$(index): index.html base.html
	./render-template $< > $@

$(redirects): $(builddir)/%.html: redirect.html base.html
	./render-template $< $* > $@

$(css): css/*css
	sass css/main.scss | \
		cat css/normalize.css - | \
		postcss \
			--no-map \
			--use autoprefixer --autoprefixer.browsers "last 2 versions, > 5%" \
			--use cssnano > $@

$(img):
	@cp -rluv img $(builddir)

clean:
	rm -rfv $(targets)

.PHONY: all $(img) clean
