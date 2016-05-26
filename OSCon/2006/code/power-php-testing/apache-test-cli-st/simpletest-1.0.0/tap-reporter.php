<?php
    /**
     *	Tap Compliant Reporter
     *	@package	SimpleTest
     *	@subpackage	UnitTester
     *  @author     Mike Lively <m@digitalsandwich.com>
     *	@version	$Id$
     */

    /**#@+
     *	include other SimpleTest class files
     */
    require_once(dirname(__FILE__) . '/scorer.php');
    /**#@-*/
    
    /**
     *    Tap Compliant Reporter. Displays test results that SHOULD be 
     *    compatible with Perl's Test::Harness
	 *	  @package SimpleTest
	 *	  @subpackage UnitTester
     */
    class TAPReporter extends SimpleReporter {
        
        /**
         *    Does nothing yet. The first output will
         *    be sent on the first test start. For use
         *    by a testing framework such as Apache-Test.
         *    @access public
         */
        function TAPReporter($character_set = 'ISO-8859-1') {
            $this->SimpleReporter();
			header('Content-Type: text/plain'); 
        }
        
        /**
         *    Paints the content type header for the test. (text/plain)
         *    @param string $test_name      Name class of test.
         *    @access public
         */
        function paintHeader($test_name) {
			header('Content-Type: text/plain'); 
        }

        /**
         *     Provides a total count of how many tests have passed, 
         *     failed, or been exceptioned in the test case thus far.
         *     @access protected
         */
        function _countTests() {
        	return $this->getFailCount() + $this->getExceptionCount() + $this->getPassCount();
        }
        
        /**
         *    Paints the end of the test with a test plan.
         *    @param string $test_name        Name class of test.
         *    @access public
         */
        function paintFooter($test_name) {
        	parent::paintFooter($test_name);
        	print "1.." . $this->_countTests() . "\n";
        }
        
        /**
         *    Paints the test failure with a breadcrumbs
         *    trail of the nesting test suites below the
         *    top level test.
         *    @param string $message    Failure message displayed.
         *    @access public
         */
        function paintFail($message) {
            parent::paintFail($message);
            print "not ok " . $this->_countTests();
            if ($message !== '') {
            	print " - {$message}";
            }
            print "\n";
        }
        
        /**
         *    Paints a PHP error or exception.
         *    @param string $message       Failure message displayed.
         *    @access public
         *    @abstract
         */
        function paintException($message) {
            parent::paintFail($message);
            print "not ok " . $this->_countTests();
            if ($message !== '') {
            	print " - {$message}";
            }
            print "\n";
        }
        
        /**
         *    Increments the pass count.
         *    @param string $message        Passing message displayed.
         *    @access public
         */
        function paintPass($message) {
            parent::paintFail($message);
            print "ok " . $this->_countTests();
            if ($message !== '') {
            	print " - {$message}";
            }
            print "\n";
        }

        /**
         *    Paints formatted text such as dumped variables.
         *    @param string $message        Text to show.
         *    @access public
         */
        function paintFormattedMessage($message) {
        	$messageLines = split("\n", $message);
        	foreach ($messageLines as $line) {
        		echo "# $line\n";
        	}
        }
        
        /**
         *    Paints a simple supplementary message.
         *    @param string $message        Text to display.
         *    @access public
         */
        function paintMessage($message) {
        	$this->paintFormattedMessage($message);
        }
        
    }
    

?>
