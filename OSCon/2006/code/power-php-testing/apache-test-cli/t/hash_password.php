<?php

require 'test-more.php';
require dirname(__FILE__) . '/../inc/functions.inc';

# plan the number of tests we expect to run
plan(2);


{
    $hash = hash_password('');
    ok (!$hash, 'no password fails');
}

{
    $hash = hash_password('foo');
    is ($hash,
        '904166af5658154d75d4e04d45c93b6',
        'known password produces known digest');
}

?>
