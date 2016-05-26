<?php

require_once 'PHPUnit2/Framework/TestCase.php';
require dirname(__FILE__) . '/../inc/functions.inc';

class AuthenticateUserTest extends PHPUnit2_Framework_TestCase
{
    private $db_file = '/tmp/db.sqlite';
    private static $db;

    public function testCreateDatabase()
    {
        self::$db = sqlite_open($this->db_file);
        $this->assertEquals(TRUE, (bool)self::$db);
    }

    public function testCreateTable()
    {
        $sql = "CREATE TABLE users
                (
                    username    varchar(50),
                    password    varchar(32),
                    PRIMARY KEY (username)
                )";

        $return = sqlite_query(self::$db, $sql);
        $this->assertEquals(TRUE, (bool)$return);
    }

    public function testBlankCredentials()
    {
        $return = authenticate_user('', '');
        $this->assertEquals(FALSE, $return);
    }

    public function testBlankUser()
    {
        $return = authenticate_user('', 'password');
        $this->assertEquals(FALSE, $return);
    }

    public function testInvalidUser()
    {
        $return = authenticate_user('user', 'password');
        $this->assertEquals(FALSE, $return);
    }

    public function testCreateUser()
    {
        $return = create_user('user', 'password');
        $this->assertEquals(TRUE, $return);
    }

    public function testWrongPassword()
    {
        $return = authenticate_user('user', 'foo');
        $this->assertEquals(FALSE, $return);
    }

    public function testBlankPassword()
    {
        $return = authenticate_user('user', '');
        $this->assertEquals(FALSE, $return);
    }

    public function testValidUser()
    {
        $return = authenticate_user('user', 'password');
        $this->assertEquals(TRUE, $return);
    }

    public function testDeleteUser()
    {
        $return = delete_user('user');
        $this->assertEquals(TRUE, (bool)$return);
    }

    public function testDeleteDatabase()
    {
        $return = unlink($this->db_file);
        $this->assertEquals(TRUE, $return);
    }
}

?>
