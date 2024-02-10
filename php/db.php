<?php
    $host = "localhost";
    $dbname = "tasty";
    $user = "root";
    $pass = "";
    
    try {
        $db = new PDO("mysql:host=$host; dbname=$dbname", $user, $pass);
    } catch (\Throwable $th) {
        echo "Error: ".$th->getMessage();
    }
?>