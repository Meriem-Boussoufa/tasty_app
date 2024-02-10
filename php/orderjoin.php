<?php

include "db.php";


$stmt = $db->prepare("SELECT * FROM commande c LEFT JOIN restaurant r ON c.idrest =r.id_rest");
$stmt->execute();

$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);

