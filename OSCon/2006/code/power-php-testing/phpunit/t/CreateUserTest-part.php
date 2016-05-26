<?php

require_once 'PHPUnit2/Framework/TestCase.php';
require dirname(__FILE__) . '/../inc/functions.inc';

class CreateUserTest extends PHPUnit2_Framework_TestCase
{
    public function testBlankCredentials()
    {
        $return = create_user('', '');
        $this->assertEquals(FALSE, $return);
    }

    public function testBlankUser()
    {
        $return = create_user('', 'password');
        $this->assertEquals(FALSE, $return);
    }

    public function testBlankPassword()
    {
        $return = create_user('user', '');
        $this->assertEquals(FALSE, $return);
    }
}

?>
