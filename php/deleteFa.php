<?php

include "db.php";


$id = $_GET['id'];
$phone =str_replace(" ","","+".$_GET['phone']) ;  

echo $phone; 
echo $id;

$stmt = $db->prepare("DELETE FROM favori WHERE id_rest = ? AND phone = ?");
$result = $stmt->execute([$id,$phone]);

echo json_encode(['success' => "works"]);


