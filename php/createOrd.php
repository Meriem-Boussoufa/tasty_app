<?php
include "db.php";
$_POST = json_decode(file_get_contents('php://input'),true); // 

$total = $_POST['total'];
$STOTAL = $_POST['STOTAL'];
$etat = $_POST['etat'];
$phone = $_POST['id'];
$idrest = $_POST['idrest'];
$local = $_POST['local'];
$date = $_POST['date'];
$idart = $_POST['idart'];
$stotal = $_POST['stotal'];
$qte = $_POST['qte'];

$stmt = $db->prepare("INSERT INTO commande (total,STOTAL,etat_cmd,phone,idrest,xlocyloc,date) VALUES (?,?,?,?,?,?,?)");
$result = $stmt->execute([$total,$STOTAL,$etat,$phone,$idrest,$local,$date]);

$idcmd = $db->lastInsertId();

foreach($_POST['idart'] as $idar){
$stmt = $db->prepare("INSERT INTO detail_cmd (qte,S_total,id_art,id_cmd) VALUES (?,?,?,?)");
$result = $stmt->execute([$qte,$stotal,$idar,$idcmd]);
}

echo json_encode(["success"=>"WORK"]); 


?>