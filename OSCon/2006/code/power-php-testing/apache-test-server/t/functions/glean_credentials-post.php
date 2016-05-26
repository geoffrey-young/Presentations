<?php

$path = dirname(__FILE__) . '/../..';
$path = realpath($path);
ini_set('include_path', ".:$path:$path/PEAR");

require 'HTTP/Request.php';

$host = 'http://127.0.0.1:8529';
$path = '/TestFunctions/glean_credentials-post.php';

$req = new HTTP_Request("$host$path");
$req->setMethod(HTTP_REQUEST_METHOD_POST);
$req->addPostData('username', 'testuser');
$req->addPostData('password', 'testpass');

if (!PEAR::isError($req->sendRequest()))
{
    echo $req->getResponseBody();
}

?>
