<?php
session_start();
include 'functions.inc';

if (check_login($_POST['username'], $_POST['password']))
{
    $_SESSION['logged_in'] = true;
    $_SESSION['username'] = $_POST['username'];
    $html_username = htmlentities($_POST['username']);
    echo "<p>Login Successful: <b>$html_username</b></p>";
    echo '<p><a href="/">Home</a></p>';
    echo '<p><a href="logout.php">Logout</a></p>';
}
else
{
    $_SESSION = array();
    session_destroy();
    echo '<p>Invalid Login</p>';
    echo '<p><a href="/">Home</a></p>';
}
?>
