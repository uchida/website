# customized rst2html
RST2HTML = python tools/rst2html.py

# destination for install-web
DEST = ike-dyn:public_html/

# source and target
ALLDOCS = $(basename $(wildcard *.rst))
ALLHTML = $(addsuffix .html,$(ALLDOCS))
STYLESHEETS = pygments.css

.PHONY: html
html: $(ALLHTML)

.PHONY: css
css: $(STYLESHEETS)

.PHONY: install-web
install-web: css html clean
	rsync -rlpgoDuv --delete --progress --exclude-from=ignore.txt ./ $(DEST)

.PHONY: clean
clean:
	find . -name '*~' -delete

.PHONY: apt
apt:
	genbasedir -s --progress --bz2only `pwd`/OSXWS/10.7/x86_64 main
	genbasedir -s --progress --bz2only `pwd`/OSXWS/10.7/noarch main

%.html: %.rst
	$(RST2HTML) $< $@

%.css:
	pygmentize -S colorful -f html > $@
