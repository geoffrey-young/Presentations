
export APACHE_TEST_APXS ?= /apache/2.0.52/worker/perl-5.8.5/bin/apxs

all : Makefile
	$(MAKE) -f Makefile cmodules

Makefile :
	perl Makefile.PL

install :
	$(APACHE_TEST_APXS) -iac c-modules/example_ipc/mod_example_ipc.c

%: force
	@$(MAKE) -f Makefile $@
force: Makefile;

