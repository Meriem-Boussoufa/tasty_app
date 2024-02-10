<?php

include "db.php";

$_POST = json_decode(file_get_contents('php://input'),true);

$favori = $_POST['favori'];
$id = $_POST['id'];

$stmt = $db->prepare("UPDATE restaurant SET favori = ? WHERE id_rest = ?");
$result = $stmt->execute([$favori,$id]);

echo json_encode(['success' => "works"]);

