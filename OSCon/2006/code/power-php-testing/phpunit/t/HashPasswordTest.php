<?php

require_once 'PHPUnit2/Framework/TestCase.php';
require dirname(__FILE__) . '/../inc/functions.inc';

class HashPasswordTest extends PHPUnit2_Framework_TestCase
{
    public function testBlankPassword()
    {
        $hash = hash_password('');

        $this->assertEquals(FALSE, $hash);
    }

    public function testPassword()
    {
        $hash = hash_password('foo');

        $this->assertEquals('904166af5658154d75d4e04d45c93b6', $hash);
    }
}
?>
