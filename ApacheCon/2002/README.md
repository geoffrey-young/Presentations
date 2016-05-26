# ApacheCon US 2002

Talks I presented at [ApacheCon US 2002](http://www.apachecon.com/2002/US/html/sessions.html)

## Object Oriented mod_perl

*Object Oriented mod_perl* was a 3 hour, in-depth tutorial.

### Description

Object-oriented techniques allow developers to reduce code maintenance overhead and development time, deploy flexible APIs, and easily extend program functionality without duplicating work or code - all things that let us be efficient programmers and keep both ourselves and our managers happy. This tutorial will cover elements of programming with the mod_perl API using its object-oriented model.

One of the greatest benefits of using the mod_perl handler API is the ability to leverage the power of object-oriented programming techniques within your application using mod_perl's concept of method handlers. Since mod_perl handlers are just subroutines contained within a package namespace, your existing handlers already have most of the components required of Perl's object-oriented model: a class and a method. With a few additional steps, you can turn your ordinary handlers in to method handlers, opening up enormous opportunities. With object- oriented design, you can subclass existing classes, changing only the methods whose features do not fit your needs.

After showing the steps required to invoke method handlers, we will see how to reduce code duplication by sub classing an Apache module from CPAN, tuning it to meet specific needs. Following that, we will examine the base mod_perl classes and show examples of how sub classing these classes can add incredibly powerful tools to your programming arsenal.

1. Object-Oriented Mechanics
   * A brief introduction on how Perl implements classes, objects, and methods. 
   * Private object data in Perl
   * Method inheritance and the empty-subclass test
2. Method Handler Basics
   * Prototyping handlers with ($$)
   * Capturing both $self and $r
   * Using subroutine attributes instead of prototypes
   * Stacking method handlers
3. Extending Method Handlers
   * Sub classing your own classes
   * Sub classing CPAN modules
4. Sub classing and Extending Base mod_perl Classes
   * Sub classing Apache
   * Sub classing Apache Registry
   * Sub classing Apache Request
