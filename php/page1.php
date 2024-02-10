<?php

include "db.php";

$stmt = $db->prepare("SELECT * FROM restaurant");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>

