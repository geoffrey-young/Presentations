--TEST--
authenticate_user() function
--FILE--
<?php

require dirname(__FILE__) . '/../inc/functions.inc';

$db_file = '/tmp/db.sqlite';

$db = sqlite_open($db_file);
var_dump($db);

$sql = "CREATE TABLE users
        (
            username    varchar(50),
            password    varchar(32),
            PRIMARY KEY (username)
        )";

$return = sqlite_query($db, $sql);
var_dump($return);

$return = authenticate_user('', '');
var_dump($return);

$return = authenticate_user('', 'password');
var_dump($return);

$return = authenticate_user('user', 'password');
var_dump($return);

$return = create_user('user', 'password');
var_dump($return);

$return = authenticate_user('user', 'foo');
var_dump($return);

$return = authenticate_user('user', '');
var_dump($return);

$return = authenticate_user('user', 'password');
var_dump($return);

$return = delete_user('user');
var_dump($return);

$return = unlink($db_file);
var_dump($return);

?>
--EXPECT--
resource(5) of type (sqlite database)
resource(6) of type (sqlite result)
bool(false)
bool(false)
bool(false)
bool(true)
bool(false)
bool(false)
bool(true)
int(1)
bool(true)
