<?php
$dbHost = "localhost";
$dbUsername = "root";
$dbPassword = "";
$dbName = "infiniteskyvf";
$db = new mysqli($dbHost, $dbUsername, $dbPassword, $dbName);
if ($db->connect_error) {
    die("Error al conectarse con la BD: " . $db->connect_error);
}