<?php
session_start();
$_SESSION = array();
session_destroy();
echo '<p>Logged Out</p>';
echo '<p><a href="/">Home</a></p>';
?>
