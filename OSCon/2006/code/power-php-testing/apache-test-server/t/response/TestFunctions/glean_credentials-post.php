<?php

require 'test-more.php';
require dirname(__FILE__) . '/../../../inc/functions-post.inc';

# plan the number of tests we expect to run
plan(2);


{
    list($user, $pass) = glean_credentials();

    is ($user,
        'testuser',
        'found known user');

    is ($pass,
        'testpass',
        'found known password');
}
?>
