# OSCon 2002

Talks I presented at [The O'Reilly Open Source Convention 2002](http://conferences.oreillynet.com/os2002/)

## Transitioning to mod_perl Handlers

*Transitioning to mod_perl Handlers* was a 3 hour, in-depth tutorial.

### Description

So, you have managed to port all of your existing CGI scripts to work under mod_perl and Apache::Registry. Now what? In this tutorial we will start harnessing the real power of mod_perl - the mod_perl handler API.

With the mod_perl API you have the ability to take advantage of the entire Apache API and framework using Perl. This opens up a huge window of opportunity for developers, who are no longer limited to programming around the Apache architecture to accomplish tasks, but instead can develop applications that live right within it.

Here, we introduce handlers as a means to take advantage of the Apache API and request phases, improve performance, and allow for greater developer flexibility. Direct examination of handlers that integrate tightly with the Apache request cycle, such as URI translation, authentication, and filtered content generation will be presented. Along the way, we will be seeing how mod_perl interacts with Apache, learning the basics of the mod_perl API, and providing a basis for using mod_perl as an inexpensive, robust, and powerful platform for web applications.

1. Apache and mod_perl 101
    * The Apache Lifecycle
    * What mod_perl really is
    * Apache::Registry as a mod_perl handler
2. mod_perl Handler Basics
    * Anatomy of a mod_perl handler
    * Why use handlers?
    * Your first handler
3. mod_perl API Basics
    * The Apache request object
    * Sending Content-Type and other HTTP headers
    * The Apache::Constants class and handler return codes
    * Other useful Apache:: core classes
4. Using the Apache Framework
    * Filtered content generation with Apache::Filter
    * Reducing bandwidth with Apache::Clean
    * The PerlInitHandler and PerlTransHandler
    * The Resource Control Phases
5. Advanced mod_perl API features
    * pnotes()
    * The Apache::Table class
    * Caching with proper HTTP headers
6. Transition Strategies
    * Moving away from Apache::Registry with Apache::Dispatch
    * Method Handlers
