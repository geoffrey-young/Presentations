package Cookbook::TrapNoHost2;

use Apache::Const -compile => qw(DECLINED HTTP_BAD_REQUEST);

use Apache::RequestRec ();  # for $r->headers_in()
use Apache::URI ();         # for $r->parsed_uri()
use Apache::Response ();    # for $r->custom_response()
use APR::Table ();          # for headers_in->get()
use APR::URI ();            # for parsed_uri->hostname()

use strict;

sub handler {

  my $r = shift;

  # Valid requests for name based virtual hosting are:
  # requests with a Host header, or
  # requests that are absolute URIs.

  unless ($r->headers_in->get('Host') || $r->parsed_uri->hostname) {

    $r->custom_response(Apache::HTTP_BAD_REQUEST,
                        "Oops!  Did you mean to omit a Host header?");

    return Apache::HTTP_BAD_REQUEST;
  }

  return Apache::DECLINED;
}
1;
