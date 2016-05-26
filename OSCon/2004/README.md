# OSCon 2004

Talks I presented at [The O'Reilly Open Source Convention 2004](http://conferences.oreillynet.com/os2004/).

## Programming the Apache Lifecycle

*Programming the Apache Lifecycle* was a 3 hour, in-depth tutorial.

### Description

Apache offers a rich and robust framework for web development; an architecture built right into the server itself that allows for an easy way to program how Apache, for instance, authenticates a user or maps a request to a file on disk. This framework makes programming complex web applications easier and more manageable, sometimes even providing a solution to problems that would be impossible without it. mod_perl gives Perl developers the ability to put every aspect of Apache under their control so they can program within the Apache framework instead of around it.

In order to leverage the full power of the Apache framework, however, developers need to undergo a rather intense (and perhaps difficult) paradigm shift—almost everything about the way Apache works is now at the developer's disposal and (potentially) under his control. With all this power, knowing where to start is difficult. This session will cover programming the Apache framework from the ground up, clearing the way for the myriad of possibilities mod_perl makes available.

Discussion will begin with a detailed explanation of how mod_perl interacts with the Apache API and request cycle. Following will be a full description of each of the phases of the request, including idiomatic and in-depth examples of how mod_perl can be used to make Apache into a powerful web application engine. Techniques specific to handling resource control, maintaining state, proper caching headers, and logging through the mod_perl API will round out this session and start developers "thinking in mod_perl”.

