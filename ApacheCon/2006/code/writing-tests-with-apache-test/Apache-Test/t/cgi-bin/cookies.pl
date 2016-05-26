#!/perl/perl-5.8.7/bin/perl
# WARNING: this file is generated, do not edit
# generated on Tue Oct  3 15:20:11 2006
# 01: /perl/perl-5.8.7/lib/site_perl/5.8.7/i686-linux-thread-multi/Apache/TestConfig.pm:953
# 02: /perl/perl-5.8.7/lib/site_perl/5.8.7/i686-linux-thread-multi/Apache/TestConfig.pm:1043
# 03: /perl/perl-5.8.7/lib/site_perl/5.8.7/i686-linux-thread-multi/Apache/TestMM.pm:141
# 04: ./Makefile.PL:39
# 05: /perl/perl-5.8.7/lib/5.8.7/ExtUtils/MakeMaker.pm:188
# 06: /perl/perl-5.8.7/lib/5.8.7/ExtUtils/MakeMaker.pm:175
# 07: /perl/perl-5.8.7/lib/5.8.7/ExtUtils/MakeMaker.pm:175
# 08: /perl/perl-5.8.7/lib/5.8.7/ExtUtils/MakeMaker.pm:598
# 09: /perl/perl-5.8.7/lib/5.8.7/ExtUtils/MakeMaker.pm:58
# 10: Makefile.PL:3

BEGIN { eval { require blib && blib->import; } }
#!perl -wT

use strict;

use CGI;
use CGI::Cookie;

my %cookies = CGI::Cookie->fetch;
my $name = 'ApacheTest';
my $c = ! exists $cookies{$name}
    ? CGI::Cookie->new(-name=>$name, -value=>time)
    : '';

print "Set-Cookie: $c\n" if $c;
print "Content-Type: text/plain\n\n";
print ($c ? 'new' : 'exists'), "\n";
