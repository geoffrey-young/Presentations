<?php

require_once 'PHPUnit2/Framework/TestCase.php';
require dirname(__FILE__) . '/../inc/functions.inc';

class CreateUserTest extends PHPUnit2_Framework_TestCase
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

    public function testCreateUser()
    {
        $return = create_user('user', 'password');
        $this->assertEquals(TRUE, $return);
    }

    public function testDeleteUser()
    {
        $return = delete_user('user');
        $this->assertEquals(TRUE, (bool)$return);
    }

    public function testCreateUserAgain()
    {
        $return = create_user('user', 'password');
        $this->assertEquals(TRUE, $return);
    }

    public function testCreateDuplicateUser()
    {
        $return = @create_user('user', 'password');
        $this->assertEquals(FALSE, $return);
    }

    public function testDeleteUserAgain()
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
