
export APACHE_TEST_APXS ?= /apache/2.0.52/worker/perl-5.8.5/bin/apxs

t/TEST :
	perl -MApache::TestRun -e 'Apache::TestRun->generate_script()'

test : t/TEST
	t/TEST

install :
	$(APACHE_TEST_APXS) -iac c-modules/example_ipc/mod_example_ipc.c
