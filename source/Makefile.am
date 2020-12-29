#
# This file is processed by automake (produces file Makefile.in)
#
ACLOCAL_AMFLAGS = -I autoconf
AM_CPPFLAGS=-O2
if GFOR
AM_CPPFLAGS += -DGFOR -fdec
endif

bin_PROGRAMS = interpolacsv.exe

interpolacsv_exe_SOURCES  = 00_mod_vars.F90       01_principal.F90      02_lee_domain_nc.F90  s_check.F90
interpolacsv_exe_SOURCES += 03_lee_csv.F90        04_interpola.F90      05_guarda.F90

#
# Compiler flags
AM_FCFLAGS = $(NC_INC) $(NC_LIB)

# Parallel version
if WITH_OMPI
  AM_FCFLAGS += $(OPENMP_FCFLAGS)
endif

# Additional files to be cleaned with 'make clean'
CLEANFILES = *.o *.mod *~

TESTSUITE = $(srcdir)/testsuite

SUBDIRS = . testsuite

EXTRA_DIST =  $(TESTSUITE)

.PHONY: $(EXTRA_DIST)
$(EXTRA_DIST):
