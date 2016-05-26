use strict;
use warnings FATAL => qw(all);

use File::Spec::Functions qw(catfile);

use Apache::Test qw(-withtestmore);
use Apache::TestRequest;
use Apache::TestUtil qw(t_write_perl_script);

plan tests => 4, need need_lwp, need_cgi;

Test::More->builder->current_test(4);

my $file = catfile(Apache::Test::vars('documentroot'),
                   'test.cgi');

# t/htdocs/test.cgi
t_write_perl_script($file, <DATA>);

print GET_BODY_ASSERT '/test.cgi';

__END__
#---------------------------------------------------------------------
# this is a sample cgi script.  you can forget about most of this
# since I needed to add some testing overhead...
#---------------------------------------------------------------------

use strict;
use warnings FATAL => qw(all);

print "Content-Type: text/plain\n\n";

use Test::More no_plan => 1;
Test::More->builder->no_header(1);

use Cwd qw(cwd);
use File::Spec ();

use lib File::Spec->catfile(cwd, '../lib');

use blib;

use My::CommonTestRoutines;

# localize tmpdir to our test directory
no warnings qw(once);
local *File::Spec::tmpdir = sub { My::CommonTestRoutines->tmpdir };

# for testing, so we get back an image we know
use Digest::MD5;
no warnings qw(redefine);
local *Digest::MD5::hexdigest = sub { 'b77a27f12f2fb0e1b65ba560659640aa' };


#---------------------------------------------------------------------
# now, for the top of cgi script, create the object
#---------------------------------------------------------------------

use WebService::CaptchasDotNet;

my $o = WebService::CaptchasDotNet->new(secret   => 'secret',
                                        username => 'demo');


#---------------------------------------------------------------------
# first page, display the captcha
#---------------------------------------------------------------------

my $random = $o->random();

my $url = $o->url($random);


#---------------------------------------------------------------------
# second page, retrieve the user input and compare
# $random should come back unaltered
# $captcha should be user input
#---------------------------------------------------------------------

{
  # simulate a mistype
  my $captcha = 'zzzzzz';

  my $result = $o->verify($captcha, $random);

  ok (!$result, 'user input bogus');
}

{
  # good user input
  my $captcha = 'lmaeba';

  my $result = $o->verify($captcha, $random);

  ok ($result, 'user input passed');
}
