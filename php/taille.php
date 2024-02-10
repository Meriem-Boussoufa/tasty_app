<?php

include "db.php";

$idpage4 = $_GET['idcatddd'];
$stmt = $db->prepare("SELECT * FROM taille WHERE id_cat = $idpage4");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);

?>


