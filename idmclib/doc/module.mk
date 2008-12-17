%.html: %.texinfo
	texi2html $< --output=$@

GENERATED_FILES+=doc/version.texinfo doc/manual.html

doc/manual.html: doc/version.texinfo
doc: doc/manual.html

