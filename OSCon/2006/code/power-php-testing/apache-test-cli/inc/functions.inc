<?php

function authenticate_user($username, $password)
{
    $clean = array();
    $sqlite = array();

    if (empty($username) || empty($password))
    {
        return FALSE;
    }

    if (ctype_alnum($username))
    {
        $clean['username'] = $username;
    }
    else
    {
        return FALSE;
    }

    $clean['password'] = hash_password($password);


    $sqlite['username'] = sqlite_escape_string($clean['username']);
    $sqlite['password'] = sqlite_escape_string($clean['password']);

    $db = sqlite_open('/tmp/db.sqlite');

    $sql = "SELECT username
            FROM   users
            WHERE  username =  '{$sqlite['username']}'
            AND    password = '{$sqlite['password']}'";

    $result = sqlite_query($db, $sql);

    if (sqlite_num_rows($result))
    {
        return TRUE;
    }

    return FALSE;
}

function create_user($username, $password)
{
    $clean = array();
    $sqlite = array();

    if (empty($username) || empty($password))
    {
        return FALSE;
    }

    if (ctype_alnum($username))
    {
        $clean['username'] = $username;
    }
    else
    {
        return FALSE;
    }

    $clean['password'] = hash_password($password);

    $sqlite['username'] = sqlite_escape_string($clean['username']);
    $sqlite['password'] = sqlite_escape_string($clean['password']);

    $db = sqlite_open('/tmp/db.sqlite');

    $sql = "INSERT
            INTO   users
            VALUES ('{$sqlite['username']}', '{$sqlite['password']}')";

    if (sqlite_query($db, $sql))
    {
        return TRUE;
    }

    return FALSE;
}

function delete_user($username)
{
    $clean = array();
    $sqlite = array();

    if (empty($username))
    {
        return FALSE;
    }

    if (ctype_alnum($username))
    {
        $clean['username'] = $username;
    }
    else
    {
        return FALSE;
    }

    $sqlite['username'] = sqlite_escape_string($clean['username']);

    $db = sqlite_open('/tmp/db.sqlite');

    $sql = "DELETE
            FROM   users
            WHERE  username = '{$sqlite['username']}'";

    if ($result = sqlite_query($db, $sql))
    {
        return sqlite_changes($db);
    }

    return FALSE;
}

function glean_credentials()
{
    $credentials = array();
    $credentials[] = '';
    $credentials[] = '';

    if (isset($_GET['username']) &&
        isset($_GET['password']))
    {
        $credentials[0] = $_GET['username'];
        $credentials[1] = $_GET['password'];
    }

    return $credentials;
}

function glean_user()
{
    $username = FALSE;
    $order = ini_get('variables_order');

    $map = array();
    $map['G'] = $_GET;
    $map['P'] = $_POST;
    $map['C'] = $_COOKIE;
    $map['S'] = $_SERVER;

    for ($i = 0; $i < 4; $i++)
    {
        if (!empty($map[$order[$i]]['username']))
        {
            $username = $map[$order[$i]]['username'];
        }
    }

    return $username;
}

function hash_password($password)
{
    $salt = 'SHIFLETT';

    if (empty($password))
    {
        return FALSE;
    }

    return md5($salt . md5($password . $salt));
}

?>
