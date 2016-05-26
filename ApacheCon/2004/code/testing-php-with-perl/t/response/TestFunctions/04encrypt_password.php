<?php
require 'test_more.inc';
require "{$_SERVER['DOCUMENT_ROOT']}/functions.inc";

plan(3);

{
    $password = 'funkyfunky';

    $newpass = encrypt_password($password);

    # the returned password should be different
    isnt ($newpass,
          $password,
          'password is at least different');

    # and that it has basic md5 characteristics,
    # such as being 32 characters long
    is (strlen($newpass),
        32,
        'password is a proper 32 characters');

    # and all 32 characters must be within hex range
    like ($newpass,
          '/^[0-9a-fA-F]{32}$/',
          'password consists of only hex characters');
}
?>
