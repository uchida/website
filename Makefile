# customized rst2html
RST2HTML = python tools/rst2html.py

# destination to push
DEST = ike-dyn:public_html/

# source and target
ALLDOCS = $(basename $(wildcard *.rst))
ALLHTML = $(addsuffix .html,$(ALLDOCS))
STYLESHEETS = pygments.css

.PHONY: html
html: $(ALLHTML)

.PHONY: css
css: $(STYLESHEETS)

.PHONY: push
push: css html clean
	rsync -rlpgoDuv --delete --progress --exclude-from=ignore.txt ./ $(DEST)

.PHONY: clean
clean:
	find . -name '*~' -delete

%.html: %.rst
	$(RST2HTML) $< $@

%.css:
	pygmentize -S colorful -f html > $@

.PHONY: apt
apt: leopard snowleopard lion dev

.PHONY: dev
dev: $(wildcard OSXWS/dev/*/base/release)
OSXWS/dev/x86_64/base/release: $(wildcard OSXWS/dev/x86_64/RPMS.main/*.rpm)
	genbasedir -s --progress --bz2only `pwd`/OSXWS/dev/x86_64 main
OSXWS/dev/noarch/base/release: $(wildcard OSXWS/dev/noarch/RPMS.main/*.rpm)
	genbasedir -s --progress --bz2only `pwd`/OSXWS/dev/noarch main

.PHONY: lion
lion: $(wildcard OSXWS/10.7/*/base/release)
OSXWS/10.7/x86_64/base/release: $(wildcard OSXWS/10.7/x86_64/RPMS.main/*.rpm)
	genbasedir -s --progress --bz2only `pwd`/OSXWS/10.7/x86_64 main
OSXWS/10.7/noarch/base/release: $(wildcard OSXWS/10.7/noarch/RPMS.main/*.rpm)
	genbasedir -s --progress --bz2only `pwd`/OSXWS/10.7/noarch main

.PHONY: snowleopard
snowleopard: $(wildcard OSXWS/10.6/*/base/release)
OSXWS/10.6/fat/base/release: $(wildcard OSXWS/10.6/fat/RPMS.main/*.rpm)
	genbasedir -s --progress --bz2only `pwd`/OSXWS/10.6/fat main
OSXWS/10.6/noarch/base/release: $(wildcard OSXWS/10.6/noarch/RPMS.main/*.rpm)
	genbasedir -s --progress --bz2only `pwd`/OSXWS/10.6/noarch main

.PHONY: leopard
leopard: $(wildcard OSXWS/10.5/*/base/release)
OSXWS/10.5/fat/base/release: $(wildcard OSXWS/10.5/fat/RPMS.main/*.rpm)
	genbasedir -s --progress --bz2only `pwd`/OSXWS/10.5/fat main
OSXWS/10.5/noarch/base/release: $(wildcard OSXWS/10.5/noarch/RPMS.main/*.rpm)
	genbasedir -s --progress --bz2only `pwd`/OSXWS/10.5/noarch main

.PHONY: sign
sign:
	python sign.py
