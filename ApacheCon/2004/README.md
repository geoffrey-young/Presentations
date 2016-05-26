# ApacheCon US 2004

Talks I presented at [ApacheCon US 2004](http://www.apachecon.com/2004/US/html/sessions.html)

## Test-Driven Apache Module Development

*Test-Driven Apache Module Development* was a 3 hour, in-depth tutorial.

### Description

Writing tests is up there with documentation as the thing we coders dread the most, but for Apache developers it doesn't need to be that way. With the Apache-Test framework, the engine behind much of the httpd-test project, testing your code can be more exciting than writing it! Imagine a world where your Apache module contains a full suite of integrated tests that even your boss can run--it's self-documenting fun!

In this session, participants will learn about using the Apache-Test toolkit to:

 - Issue a single command that will configure Apache, start the server, run your tests, shutdown the server, and issue a success report
 - Test against 1.3, 2.0, or 2.1 Apache server installations
 - Use the test framework to automatically compile and configure Apache C modules
 - Write simple test scripts that mimic client behaviors
 - Examine basic testing principles to help methodically guide test writing
 - Impress your boss, get a raise, make new friends

If you develop or maintain Apache modules in either C or Perl then this is one session you can't afford to miss.

## mod_perl 2.0 at Warp Speed

* mod_perl 2.0 at Warp Speed* was a standard, one hour presentation.

### Description

Tests make your life easier, and Apache-Test makes writing live webserver tests easy.

The Apache-Test framework is arguably one of the best things to emerge from the mod_perl 2.0 redesign effort.  All you need to do is write the tests and *poof* Apache-Test takes care of configuring and starting the server, running your tests, stopping the server, and reporting back your successes (or failures).

This talk will introduce the Apache-Test interface and detail how to let it make your life easier.  We will step thought the processes of writing a complete test suite for a simple Apache:: module, from generating the Makefile.PL to deciding which aspects of our module ought to be tested - everything you need to be able to start writing tests for your neglected web applications.

## Testing PHP with Perl: Two Great Tastes that Taste Great Together

*Testing PHP with Perl: Two Great Tastes that Taste Great Together* was a standard, one hour presentation co-presented with Chris Shiflett

### Description

Lots of people use PHP for Web development. Lots of people use Perl for testing. Why can't we be friends? This fun but genuine talk will show how developers can use the power of the Apache-Test framework to improve the overall quality of PHP applications using Perl's mature testing tools and methodologies.
