# This software is copyrighted by G. Andrew Mangogna.
# The following terms apply to all files associated with the software unless
# explicitly disclaimed in individual files.
# 
# The authors hereby grant permission to use, copy, modify, distribute,
# and license this software and its documentation for any purpose, provided
# that existing copyright notices are retained in all copies and that this
# notice is included verbatim in any distributions. No written agreement,
# license, or royalty fee is required for any of the authorized uses.
# Modifications to this software may be copyrighted by their authors and
# need not follow the licensing terms described here, provided that the
# new terms are clearly indicated on the first page of each file where
# they apply.
# 
# IN NO EVENT SHALL THE AUTHORS OR DISTRIBUTORS BE LIABLE TO ANY PARTY FOR
# DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
# OUT OF THE USE OF THIS SOFTWARE, ITS DOCUMENTATION, OR ANY DERIVATIVES
# THEREOF, EVEN IF THE AUTHORS HAVE BEEN ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# 
# THE AUTHORS AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.  THIS SOFTWARE
# IS PROVIDED ON AN "AS IS" BASIS, AND THE AUTHORS AND DISTRIBUTORS HAVE
# NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS,
# OR MODIFICATIONS.
# 
# GOVERNMENT USE: If you are acquiring this software on behalf of the
# U.S. government, the Government shall have only "Restricted Rights"
# in the software and related documentation as defined in the Federal
# Acquisition Regulations (FARs) in Clause 52.227.19 (c) (2).  If you
# are acquiring the software on behalf of the Department of Defense,
# the software shall be classified as "Commercial Computer Software"
# and the Government shall have only "Restricted Rights" as defined in
# Clause 252.227-7013 (c) (1) of DFARs.  Notwithstanding the foregoing,
# the authors grant the U.S. Government and others acting in its behalf
# permission to use and distribute the software in accordance with the
# terms specified in this license.
#*++
# PROJECT:
#  mrtools
#
# MODULE:
#  Makefile -- build commands for elfdecode package
#
# ABSTRACT:
#
#*--
#

DOCSRC 	=\
	elfdecode.aweb\
	$(NULL)

PDF 	=\
     	../doc/$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

TCLSRC	=\
     	$(patsubst %.aweb,%.tcl,$(DOCSRC))\
	$(NULL)

CLEANFILES =\
	$(PDF)\
	$(TCLSRC)\
	$(NULL)

A2XOPTS =\
	--verbose\
	$(NULL)

ATANGLEOPTS	=\
	$(NULL)

DBLATEX_PARAMS	=\
		doc.publisher.show=0\
		glossary.numbered=0\
		index.numbered=0\
		doc.lot.show=figure,table\
		toc.section.depth=3\
		doc.section.depth=0\
		$(NULL)

EXTRAS =\
	docinfo.xml\
	elfdecode-docinfo.xml\
	$(NULL)

ASCIIDOC_ATTRS	=\
		docinfo2\
		$(NULL)


DBLATEX_OPTS	=\
		--dblatex-opts="$(patsubst %,--param=%,$(DBLATEX_PARAMS))"\
		--dblatex-opts=--fig-path=.\
		$(NULL)

ASCIIDOC_OPTS	=\
		$(patsubst %,--attribute=%,$(ASCIIDOC_ATTRS))\
		$(NULL)

all : doc code package

doc : $(PDF)

code : $(TCLSRC)

package : pkgIndex.tcl

$(PDF) : $(DOCSRC) $(EXTRAS)

$(TCLSRC) : $(DOCSRC)

pkgIndex.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

clean :
	$(RM) $(CLEANFILES)

../doc/%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=article  --format=pdf --destination-dir=../doc\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
