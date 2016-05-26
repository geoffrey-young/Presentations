<?php
include '../functions.inc';

$auth_user = '';
$auth_pass = '';
if (isset($_SERVER['PHP_AUTH_USER']) && isset($_SERVER['PHP_AUTH_PW']))
{
    $auth_user = $_SERVER['PHP_AUTH_USER'];
    $auth_pass = $_SERVER['PHP_AUTH_PW'];
}

if (!check_admin($auth_user, $auth_pass))
{
    echo '<p>Access Denied</p>';
    exit;
}
?>
<h3>Add a User</h3>
<form action="add.php" method="post">
<p>Username: <input type="text" name="username" /></p>
<p>Password: <input type="password" name="password" /></p>
<p><input type="submit" value="Add" /></p>
</form>
<hr />
<h3>Delete a User</h3>
<form action="delete.php" method="post">
<p>Username: <input type="text" name="username" /></p>
<p><input type="submit" value="Delete" /></p>
</form>
<hr />
<?php
$db = sqlite_open("{$_SERVER['DOCUMENT_ROOT']}/db.sqlite");
$sql = "SELECT *
        FROM   users";
$result = sqlite_query($db, $sql);
$records = sqlite_fetch_all($result);
?>
<table border="1">
    <tr>
        <th>Username</th>
        <th>Password</th>
    </tr>
<?php
foreach ($records as $record)
{
    echo '<tr>';
    echo "<td>{$record['username']}</td>";
    echo "<td>{$record['password']}</td>";
    echo '</tr>';
}
?>
</table>
