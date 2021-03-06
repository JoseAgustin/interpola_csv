#
# This file is processed by automake (produces file Makefile.in)
#
# Compiler flags 
#

AM_FCFLAGS  = $(NC_LIB) -I$(top_srcdir)

FCFLAGS = $(AM_FCFLAGS)

AM_CPPFLAGS=-O2 $(NC_INC)
if GFOR
AM_CPPFLAGS += -DGFOR -fdec 
FCFLAGS += -fdec
endif
# Compiler flags

# Parallel version
if WITH_OMPI
  AM_FCFLAGS += $(OPENMP_FCFLAGS)
endif

TESTS = test1

check_PROGRAMS= test1

test1_SOURCES= $(top_builddir)/02_lee_domain_nc.F90 $(top_builddir)/s_check.F90 test_02.F90

# Additional files to be cleaned with 'make clean'
CLEANFILES = *.o *.mod package.m4 testsuite

# The `:;' works around a Bash 3.2 bug when the output is not writeable.
$(srcdir)/package.m4: $(top_srcdir)/configure.ac
	:;{ \
	echo '# Signature of the current package.' && \
	echo 'm4_define([AT_PACKAGE_NAME],' && \
	echo '  [@PACKAGE_NAME@])' && \
	echo 'm4_define([AT_PACKAGE_TARNAME],' && \
	echo '  [@PACKAGE_TARNAME@])' && \
	echo 'm4_define([AT_PACKAGE_VERSION],' && \
	echo '  [@PACKAGE_VERSION@])' && \
	echo 'm4_define([AT_PACKAGE_STRING],' && \
	echo '  [@PACKAGE_STRING@])' && \
	echo 'm4_define([AT_PACKAGE_BUGREPORT],' && \
	echo '  [@PACKAGE_BUGREPORT@])'; \
	echo 'm4_define([AT_PACKAGE_URL],' && \
	echo '  [@PACKAGE_URL@])'; \
	}>'$(srcdir)/package.m4'

TESTSUITE = $(srcdir)/testsuite

EXTRA_DIST = testsuite.at $(srcdir)/package.m4 $(TESTSUITE)

check-local: atconfig  $(TESTSUITE)
	$(SHELL) '$(TESTSUITE)' $(TESTSUITEFLAGS)

maintainer-clean-local:
	rm -rf aclocal.m4 configure Makefile.in autotools m4
     
installcheck-local: atconfig  $(TESTSUITE)
	$(SHELL) '$(TESTSUITE)' AUTOTEST_PATH='$(bindir)' \
	$(TESTSUITEFLAGS)
     
clean-local:
	test ! -f '$(TESTSUITE)' || \
	$(SHELL) '$(TESTSUITE)' --clean

AUTOM4TE = $(SHELL) $(top_builddir)/autoconf/missing --run autom4te
AUTOTEST = $(AUTOM4TE) --language=autotest

$(TESTSUITE): $(srcdir)/testsuite.at $(srcdir)/package.m4
	$(AUTOTEST) -I '$(srcdir)' -o $@.tmp $@.at
	mv $@.tmp $@

.PHONY: $(EXTRA_DIST)
$(EXTRA_DIST):
