<?php


include "db.php";

$_POST = json_decode(file_get_contents('php://input'),true);

$name = $_POST['name'];
$lastname = $_POST['lastname'];
$email = $_POST['email'];
$adr = $_POST['adr'];
$id =$_POST['id'];


$stmt = $db->prepare("UPDATE client SET name_clt = ?,prenom_clt = ?,adr_clt = ?,email = ? WHERE phone = ?");
$result = $stmt->execute([$name,$lastname,$email,$adr,$id]);

echo json_encode(["success"=>"works"]);


?>