<?php

$host = "localhost";
    $dbname = "tester";
    $user = "root";
    $pass = "";
    
    try {
        $db = new PDO("mysql:host=$host; dbname=$dbname", $user, $pass);
    } catch (\Throwable $th) {
        echo "Error: ".$th->getMessage();
    }

$stmt = $db->prepare("SELECT to_base64(img) as image FROM restaurant");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);

?>