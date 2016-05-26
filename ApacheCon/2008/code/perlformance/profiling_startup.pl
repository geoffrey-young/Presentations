# $Id: profiling_startup.pl,v 1.17 2008/10/09 18:58:42 geoff Exp $

use strict;

print STDERR '[% profiling %] is enabled - see devX.cfg', "\n";

use TM::Config;
use TMCS::Config;
use TMCS::Resource;

if ($ENV{TM_DO_PROFILE}) {

    print STDERR '[% profiling %] loading Devel::Profiler::Apache', "\n";

    #$ENV{DEVEL_PROFILER_DEBUG} = 1;
    require Devel::Profiler::Plugins::Template;
    require Devel::Profiler;
    require Devel::Profiler::Apache;

    print STDERR '[% profiling %] Devel::Profiler found in ', $INC{'Devel/Profiler.pm'}, "\n";
    print STDERR '[% profiling %] Devel::Profiler::Apache found in ', $INC{'Devel/Profiler/Apache.pm'}, "\n";
    print STDERR '[% profiling %] Devel::Profiler::Plugins::Template found in ', $INC{'Devel/Profiler/Plugins/Template.pm'}, "\n";

    our $output_dir = "/$ENV{CLASS}/local/logs/dprof";
    print STDERR '[% profiling %] using ', $output_dir, ' as base profiling directory', "\n";

    Devel::Profiler::Apache->import(
        bad_pkgs => [qw( TMCS::Exception UNIVERSAL Time::HiRes B Carp
                         Exporter Cwd Config CORE DynaLoader XSLoader
                         AutoLoader utf8 Template::Stash::XS Template::Config
                         Template::Context Template::Document TMCS::Util::Log
                         Profiling TMCS::Util::KeyRing TMCS::Util::Ingrian
                         DBD::_::st DBD::_::db DBD::st DBD::db
                         DBI::st DBI::db DBI::dr HTTP::Message)],
        bad_subs => [qw(TMCS::Model::view TMCS::Util::MAC::dzs_decode),
                     'BigTime::(0+'],
        output_dir => $output_dir,
    );
}
else {
    print STDERR '[% profiling %] enabled but no $ENV{TM_DO_PROFILE}?', "\n"
}

sub Profiling::ChildTerminate::handler {
  my $r = shift;
  our $output_dir;
  $r->send_http_header('text/plain');
  $r->print(join '/', $output_dir, $$, 'tmon.out');
  $r->child_terminate;
  0;
}

sub Profiling::Off::handler {
  $Devel::Profiler::COLLECT = 0;
  print STDERR '[% profiling %] profiling OFF', "\n";
  0;
}

sub Profiling::On::handler {
  $Devel::Profiler::COLLECT = 1;
  print STDERR '[% profiling %] profiling ON', "\n";
  0;
}

sub Profiling::Status::handler {
  my $r = shift;
  return 500 unless $ENV{TM_DO_PROFILE};
  $r->send_http_header('text/plain');
  $r->print($Devel::Profiler::COLLECT);
  0;
}

sub Profiling::BurnCache::handler {
  my $r = shift;

  my $dest = "tmweb\@$TM::Config::cch_vip_host";

  my $cmd = <<'EOF';
# your stuff here
EOF

  my $rc = CORE::system("ssh $dest \"$cmd\"");

  if ($rc == 0) {
    sleep 5;
    print STDERR '[% profiling %] cache burned', "\n";
    $r->send_http_header('text/plain');
    $r->print("burned cache in $dest");
    return 0;
  }
  else {
    $r->log_error("problem burning cache on $dest");
    return 500;
  }
}

1;
