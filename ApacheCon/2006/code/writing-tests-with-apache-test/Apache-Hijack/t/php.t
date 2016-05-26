use strict;
use warnings FATAL => 'all';

use Apache::Test qw(-withtestmore);
use Apache::TestRequest;

plan tests => 21, need need_lwp, need_php;

{
  my $url = '/foo.php';

  my $response = GET $url;

  is ($response->code,
      200,
      "$url returned 200");

  like ($response->content,
        qr/echo/,
        "$url unparsed by php");

  unlike ($response->content,
          qr/mod_perl/,
          "$url unaltered by mod_perl filter");
}

foreach my $base (qw(php-script php-app)) {

  {
    my $url = "/$base/foo.php";

    my $response = GET $url;

    is ($response->code,
        200,
        "$url returned 200");

    unlike ($response->content,
            qr/echo/,
            "$url parsed by php");

    like ($response->content,
          qr/mod_perl/,
          "$url altered by mod_perl filter");

    like ($response->header('X-Powered-By'),
          qr/mod_perl/,
          "$url powered by mod_perl");

    unlike ($response->header('X-Powered-By'),
            qr/PHP/,
            "$url not powered by PHP");
  }

  {
    my $url = "/$base/index.html";

    my $response = GET $url;

    is ($response->code,
        200,
        "$url returned 200");

    unlike ($response->content,
            qr/mod_perl/,
            "$url not altered by mod_perl filter");

    if ($url =~ m/script/) {
      like ($response->header('X-Powered-By'),
            qr/mod_perl/,
            "SetHandler $url powered by mod_perl");
    }
    else {
      unlike ($response->header('X-Powered-By'),
              qr/mod_perl/,
              "AddHandler $url not powered by mod_perl");
    }

    unlike ($response->header('X-Powered-By'),
            qr/PHP/,
            "$url not powered by PHP");
  }
}
