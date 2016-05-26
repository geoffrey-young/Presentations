<?php
/*
define('SIMPLE_TEST', '../../simpletest-1.0.0/');

require_once(SIMPLE_TEST . 'unit_tester.php');
require_once(SIMPLE_TEST . 'tap-reporter.php');
*/

require_once(dirname(__FILE__) . '/../simpletest-1.0.0/unit_tester.php');
require_once(dirname(__FILE__) . '/../simpletest-1.0.0/tap-reporter.php');

require dirname(__FILE__) . '/../inc/functions.inc';

class CreateUserTest extends UnitTestCase
{
    private $db_file = '/tmp/db.sqlite';
    private static $db;

    public function testCreateDatabase()
    {
        self::$db = sqlite_open($this->db_file);
        $this->assertTrue((bool)self::$db);
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
        $this->assertTrue((bool)$return);
    }

    public function testBlankCredentials()
    {
        $return = create_user('', '');
        $this->assertFalse($return);
    }

    public function testBlankUser()
    {
        $return = create_user('', 'password');
        $this->assertFalse($return);
    }

    public function testBlankPassword()
    {
        $return = create_user('user', '');
        $this->assertFalse($return);
    }

    public function testCreateUser()
    {
        $return = create_user('user', 'password');
        $this->assertTrue($return);
    }

    public function testDeleteUser()
    {
        $return = delete_user('user');
        $this->assertTrue((bool)$return);
    }

    public function testCreateUserAgain()
    {
        $return = create_user('user', 'password');
        $this->assertTrue($return);
    }

    public function testCreateDuplicateUser()
    {
        $return = @create_user('user', 'password');
        $this->assertFalse($return);
    }

    public function testDeleteUserAgain()
    {
        $return = delete_user('user');
        $this->assertTrue((bool)$return);
    }

    public function testDeleteDatabase()
    {
        $return = unlink($this->db_file);
        $this->assertTrue($return);
    }
}

$test = &new CreateUserTest();
$test->run(new TapReporter());

?>
