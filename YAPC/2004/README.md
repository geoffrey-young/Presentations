# YAPC 2004

Talks I presented at [Yet Another Perl Conference 2004](http://yapc.org/America/previous-years/2004/)

## Writing Tests with Apache-Test

*Writing Tests with Apache-Test* was a standard, one hour presentation.

### Description

Tests make your life easier, and Apache-Test makes writing live webserver tests easy.

The Apache-Test framework is arguably one of the best things to emerge from the mod_perl 2.0 redesign effort.  All you need to do is write the tests and *poof* Apache-Test takes care of configuring and starting the server, running your tests, stopping the server, and reporting back your successes (or failures).

This talk will introduce the Apache-Test interface and detail how to let it make your life easier.  We will step thought the processes of writing a complete test suite for a simple Apache:: module, from generating the Makefile.PL to deciding which aspects of our module ought to be tested - everything you need to be able to start writing tests for your neglected web applications.

## Why mod_perl 2.0 Sucks, Why mod_perl 2.0 Rocks

*Why mod_perl 2.0 Sucks, Why mod_perl 2.0 Rocks* was a standard, one hour presentation.

### Description

Have you tried working with mod_perl 2.0 yet?  Ugh.  With all those new classes and directives to learn, not to mention the list of incomplete features, you might as well stay with the trusty, stable mod_perl of old.  And subroutine attributes?  Eesh.  

Of course, the new 2.0 API does let you do fun stuff like write output filters.  Oh, and there's the Apache::Test framework that's pretty cool.  Not to mention a method called assbackwards().

This brief, fun talk will introduce mod_perl 2.0 by poking fun at its shortcomings as well as showcasing its promise.
