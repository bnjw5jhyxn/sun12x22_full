.POSIX:

sun12x22.psfu: sun12x22.psf cp437_extended.uni
	psfaddtable sun12x22.psf cp437_extended.uni sun12x22.psfu

sun12x22.psf: sun12x22.txt
	txt2psf sun12x22.txt sun12x22.psf

sun12x22.txt: font_sun12x22.c sun12x22.ed
	ed font_sun12x22.c < sun12x22.ed

font_sun12x22.c:
	curl -O https://raw.githubusercontent.com/torvalds/linux/master/lib/fonts/font_sun12x22.c

sun12x22.ed:
	if test -f sun12x22.ed; then rm sun12x22.ed; fi
	@echo "H" >> sun12x22.ed
# delete all lines without comments
	@echo "v/\/\*/d" >> sun12x22.ed
# create character separators
	@echo ",s/^	\/\*/++/g" >> sun12x22.ed
# remove leading non-comment material
	@echo ",s/^.*\/\* //g" >> sun12x22.ed
# strip trailing zeroes and end-of-comments
	@echo ",s/0* \*\/$$//g" >> sun12x22.ed
# replace zeroes with spaces
	@echo "v/^\+\+/s/0/ /g" >> sun12x22.ed
# replace ones with X's (cosmetic change, feel free to comment out)
	@echo "v//s/1/X/g" >> sun12x22.ed
# insert header
	@echo "1i" >> sun12x22.ed
	@echo "++font-text-file" >> sun12x22.ed
	@echo "++chars" >> sun12x22.ed
	@echo "256" >> sun12x22.ed
	@echo "++width" >> sun12x22.ed
	@echo "12" >> sun12x22.ed
	@echo "++height" >> sun12x22.ed
	@echo "22" >> sun12x22.ed
	@echo "." >> sun12x22.ed
# write to file
	@echo "w sun12x22.txt" >> sun12x22.ed

cp437_extended.uni: cp437.uni cp437.ed
	ed cp437.uni < cp437.ed

cp437.uni:
	curl -O https://raw.githubusercontent.com/legionus/kbd/master/data/unimaps/cp437.uni

cp437.ed:
	if test -f cp437.ed; then rm cp437.ed; fi
	@echo "H" >> cp437.ed
# code point 0x22 (double quotes)
# U+201c (left double quote)
# U+201d (right double quote)
	@echo "g/^0x22/s/$$/ U+201c U+201d/" >> cp437.ed
# code point 0x27 (apostrophe)
# U+2019 (right single quote)
	@echo "g/^0x27/s/$$/ U+2019/" >> cp437.ed
# code point 0x2d (hyphen-minus)
# U+2010 (hyphen)
# U+2013 (en dash)
# U+2014 (em dash)
# U+2212 (minus sign)
	@echo "g/^0x2d/s/$$/ U+2010 U+2013 U+2014 U+2212/" >> cp437.ed
# code point 0x60 (backtick)
# U+2018 (left single quote)
	@echo "g/^0x60/s/$$/ U+2018/" >> cp437.ed
	@echo "w cp437_extended.uni" >> cp437.ed

clean:
	rm --force sun12x22.psfu sun12x22.psf sun12x22.txt font_sun12x22.c sun12x22.ed cp437_extended.uni cp437.uni cp437.ed
