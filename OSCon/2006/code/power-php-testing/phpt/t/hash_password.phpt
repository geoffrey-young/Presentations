--TEST--
hash_password() function
--FILE--
<?php

require dirname(__FILE__) . '/../inc/functions.inc';

$hash = hash_password('');
var_dump($hash);

$hash = hash_password('foo');
var_dump($hash);

?>
--EXPECT--
bool(false)
string(32) "904166af5658154d75d4e04d45c93b6"
