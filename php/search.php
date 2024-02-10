<?php
include 'db.php';

$resto= $_POST['search'];


$stmt = $db->prepare("SELECT id_rest,name_rest,dureeliv,cuisine,adr_rest,horaire,service,favori,rating FROM restaurant WHERE name_rest='".$resto."'");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);


?>
