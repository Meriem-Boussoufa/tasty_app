<?php

include "db.php";

$id =$_GET["id_rest"];
$stmt = $db->prepare("SELECT * FROM categorie WHERE id_rest=$id");
$stmt->execute();

$resultcat = $stmt->fetchAll(PDO::FETCH_ASSOC);
// haka dertha 

echo json_encode($resultcat);
?>