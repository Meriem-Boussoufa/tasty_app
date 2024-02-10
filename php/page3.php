<?php

include "db.php";

$id = $_GET['id_cat'];
$stmt = $db->prepare("SELECT * FROM article WHERE id_cat=$id");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>