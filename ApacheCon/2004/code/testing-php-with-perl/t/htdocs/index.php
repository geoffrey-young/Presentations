<?php
session_start();

if ($_SESSION['logged_in'])
{
    $html_username = htmlentities($_SESSION['username']);
    echo "<p>Logged In: <b>$html_username</b></p>";
    echo '<p><a href="logout.php">Logout</a></p>';
}
else
{
?>
<h3>Existing Users</h3>
<form action="login.php" method="post">
<p>Username: <input type="text" name="username" /></p>
<p>Password: <input type="password" name="password" /></p>
<p><input type="submit" value="Log In" /></p>
</form>
<hr />
<h3>New Users</h3>
<form action="register.php" method="post">
<p>Username: <input type="text" name="username" /></p>
<p>Password: <input type="password" name="password" /></p>
<p>Verify Password: <input type="password" name="verify_password" /></p>
<p><input type="submit" value="Register" /></p>
</form>
<?php
}
?>
