# sun12x22\_full

The sun12x22.psfu included in [kbd][__kbd]
is missing many glyphs present in the [Linux kernel source][__linux],
from which it is derived.

In addition, the default Unicode mapping for [Code Page 437][__cp437]
included in [kbd][__kbd] lacks several code points used in man pages
and the output of shell commands.

## dependencies

This Makefile has several dependencies,
listed here in order from most onerous to least onerous.

* [nafe][__nafe]
provides `txt2psf`
* [GNU make][__gmake]
not [BSD make][__bmake] or other [make][__posix_make]s
* [ed][__posix_ed]
edits text files non-interactively
* [kbd][__kbd]
provides `psfaddtable`
* [curl][__curl]
downloads source files

## reasonable questions

_Why do you write the ed scripts in the makefile instead of just
writing separate files with the ed scripts?_

Even though [GNU ed][__gnu_ed] supports comments,
[POSIX ed][__posix_ed]
doesn't require this support and other versions of [ed][__posix_ed], including
[BSD ed][__bsd_ed], have no support for comments.
I didn't want to make the [ed][__posix_ed] dependency even more onerous
by specifically requiring [GNU ed][__gnu_ed],
so I put the script and comments together in the Makefile.

This solution necessitates the use of the special target `.ONESHELL`,
support for which is not required by [POSIX make][__posix_make]
and, as far as I can tell, is not present in [BSD make][__bmake].

## legal/license question

I wrote the [ed][__posix_ed] scripts specifically to interact with
files licensed under the [GPL][__gpl], but I'm not releasing
modified versions of the files;
I'm only releasing code that makes modified versions of said files,
one of which has a different purpose from the original.
Am I still required to release this code under the [GPL][__gpl]
or can I use some other license?

[__kbd]: http://kbd-project.org
[__linux]: https://www.kernel.org
[__cp437]: https://en.wikipedia.org/wiki/Code_Page_437
[__nafe]: http://nafe.sourceforge.net
[__posix_ed]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/ed.html
[__kbd]: http://kbd-project.org
[__curl]: https://curl.haxx.se
[__gnu_ed]: https://www.gnu.org/software/ed/
[__bsd_ed]: https://www.freebsd.org/cgi/man.cgi?ed(1)
[__gmake]: https://www.gnu.org/software/make/
[__bmake]: https://www.freebsd.org/cgi/man.cgi?make(1)
[__posix_make]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
[__gpl]: https://www.gnu.org/licenses/gpl.html
