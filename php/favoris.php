<?php

include "db.php";

$_POST = json_decode(file_get_contents('php://input'),true);

$idrest = $_POST['idresto'];
$phone = $_POST['phone'];
$favori = $_POST['favori'];

$stmt = $db->prepare("INSERT INTO favori (id_rest,phone,favori) VALUES (?,?,?)");
$result = $stmt->execute([$idrest,$phone,$favori]);


echo json_encode(["success"=>"works"]);

?>