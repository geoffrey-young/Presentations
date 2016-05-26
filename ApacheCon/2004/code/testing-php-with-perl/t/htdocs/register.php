<?php
session_start();
include 'functions.inc';
$username_ok = false;
$password_ok = false;

if (preg_match('/[a-z0-9_]/i', $_POST['username']))
{
    $username_ok = true;
}

if ($_POST['password'] == $_POST['verify_password'])
{
    $password_ok = true;
}

if ($username_ok && $password_ok)
{
    if (add_user($_POST['username'], $_POST['password']))
    {
        echo '<p>Registration Successful</p>';
    }
    else
    {
        echo '<p>Error</p>';
    }
    echo '<p><a href="/">Home</a></p>';
}
else
{
    echo '<p>Error</p>';
    echo '<p><a href="/">Home</a></p>';
}
?>
