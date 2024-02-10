<?php

include "db.php";

$id = $_GET['id_cmd'];
$stmt = $db->prepare("SELECT * FROM detail_cmd d LEFT JOIN article a ON d.id_art=a.id_art WHERE id_cmd = $id");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);

?>