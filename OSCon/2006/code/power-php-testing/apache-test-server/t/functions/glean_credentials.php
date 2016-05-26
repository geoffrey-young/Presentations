<?php

$path = dirname(__FILE__) . '/../..';
$path = realpath($path);
ini_set('include_path', ".:$path:$path/PEAR");

require 'HTTP/Request.php';

$req = new HTTP_Request('http://127.0.0.1:8529/TestFunctions/glean_credentials.php?username=testuser&password=testpass');

if (!PEAR::isError($req->sendRequest()))
{
    echo $req->getResponseBody();
}

?>
