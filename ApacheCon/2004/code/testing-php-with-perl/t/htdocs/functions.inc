<?php
function add_user($username, $password)
{
    if (empty($username) || empty($password))
    {
        return false;
    }
    $db = sqlite_open("{$_SERVER['DOCUMENT_ROOT']}/db.sqlite");
    $sql_username = sqlite_escape_string($username);
    $sql_password = encrypt_password($password);
    $sql = "INSERT
            INTO users
            VALUES ('$sql_username', '$sql_password')";
    if ($result = sqlite_query($db, $sql))
    {
        return true;
    }
    return false;
}

function check_admin($username, $password)
{
    if ($username == 'admin' && $password == 'adminpass')
    {
        return true;
    }
    header('HTTP/1.0 401 Unauthorized');
    header('WWW-Authenticate: Basic realm="Testing PHP with Perl"');
    return false;
}

function check_login($username, $password)
{
    if (empty($username) || empty($password))
    {
        return false;
    }
    $db = sqlite_open("{$_SERVER['DOCUMENT_ROOT']}/db.sqlite");
    $sql_username = sqlite_escape_string($username);
    $sql_password = encrypt_password($password);
    $sql = "SELECT username
            FROM   users
            WHERE  username = '$sql_username'
            AND    password = '$sql_password'";
    $result = sqlite_query($db, $sql);
    if (sqlite_num_rows($result))
    {
        return true;
    }
    return false;
}

function delete_user($username)
{
    if (empty($username))
    {
        return false;
    }
    $db = sqlite_open("{$_SERVER['DOCUMENT_ROOT']}/db.sqlite");
    $sql_username = sqlite_escape_string($username);
    $sql = "DELETE
            FROM users
            WHERE username = '$username'";
    if ($result = sqlite_query($db, $sql) && sqlite_changes($result))
    {
        return true;
    }
    return false;
}

function encrypt_password($password)
{
    return md5($password);
}
?>
