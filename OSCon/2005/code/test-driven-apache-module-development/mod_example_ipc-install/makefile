export APACHE_TEST_APXS ?= /apache/2.0.54/prefork/perl-5.8.7/bin/apxs
 
all : Makefile
	$(MAKE) -f Makefile cmodules
 
Makefile :
	perl Makefile.PL
 
install :
	$(APACHE_TEST_APXS) -iac c-modules/example_ipc/mod_example_ipc.c
 
%: force
	@$(MAKE) -f Makefile $@
force: Makefile;
