<?php

include "db.php";


$stmt = $db->prepare("SELECT * FROM favori f LEFT JOIN restaurant r ON f.id_rest =r.id_rest");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);