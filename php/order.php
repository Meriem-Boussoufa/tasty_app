<?php

include "db.php";

$stmt = $db->prepare("SELECT * FROM commande");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);

?>
