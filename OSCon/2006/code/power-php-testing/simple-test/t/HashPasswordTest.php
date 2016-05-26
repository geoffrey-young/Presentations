<?php

define('SIMPLE_TEST', '../simpletest-1.0.0/');

require_once(SIMPLE_TEST . 'unit_tester.php');
require_once(SIMPLE_TEST . 'tap-reporter.php');
require dirname(__FILE__) . '/../inc/functions.inc';

class HashPasswordTest extends UnitTestCase
{
    public function testBlankPassword()
    {
        $hash = hash_password('');
        $this->assertFalse($hash);
    }

    public function testPassword()
    {
        $hash = hash_password('foo');
        $this->assertEqual('904166af5658154d75d4e04d45c93b6', $hash);
    }
}

$test = &new HashPasswordTest();
$test->run(new TapReporter());

?>
