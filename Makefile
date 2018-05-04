.POSIX:
.ONESHELL:

sun12x22.psfu: sun12x22.psf cp437_extended.uni
	psfaddtable sun12x22.psf cp437_extended.uni sun12x22.psfu

sun12x22.psf: sun12x22.txt
	txt2psf sun12x22.txt sun12x22.psf

sun12x22.txt: font_sun12x22.c
	ed font_sun12x22.c << EOF
	H
# delete all lines without comments
	v/\/\*/d
# create character separators
	,s/^	\/\*/++/g
# remove leading non-comment material
	,s/^.*\/\* //g
# strip trailing zeroes and end-of-comments
	,s/0* \*\/$$//g
# replace zeroes with spaces
	v/^\+\+/s/0/ /g
# replace ones with X's (cosmetic change, feel free to comment out)
	v//s/1/X/g
# insert header
	1i
	p+font-text-file
	p+chars
	256
	p+width
	12
	p+height
	22
	.
# put in plus signs
	1,6s/^p/+/g
# write to file
	w sun12x22.txt
	EOF

cp437_extended.uni: cp437.uni
	ed cp437.uni << EOF
	H
# code point 0x22 (double quotes)
# U+201c (left double quote)
# U+201d (right double quote)
	g/^0x22/s/$$/ U+201c U+201d/
# code point 0x27 (apostrophe)
# U+2019 (right single quote)
	g/^0x27/s/$$/ U+2019/
# code point 0x2d (hyphen-minus)
# U+2010 (hyphen)
# U+2013 (en dash)
# U+2014 (em dash)
# U+2212 (minus sign)
	g/^0x2d/s/$$/ U+2010 U+2013 U+2014 U+2212/
# code point 0x60 (backtick)
# U+2018 (left single quote)
	g/^0x60/s/$$/ U+2018/
	w cp437_extended.uni
	EOF

font_sun12x22.c:
	curl -O https://raw.githubusercontent.com/torvalds/linux/master/lib/fonts/font_sun12x22.c

cp437.uni:
	curl -O https://raw.githubusercontent.com/legionus/kbd/master/data/unimaps/cp437.uni

.PHONY: clean mostlyclean
clean:
	rm -vf sun12x22.psfu sun12x22.psf sun12x22.txt font_sun12x22.c cp437_extended.uni cp437.uni

mostlyclean:
	rm -vf sun12x22.psfu sun12x22.psf sun12x22.txt cp437_extended.uni
