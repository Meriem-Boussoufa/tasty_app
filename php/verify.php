<?php

include "db.php";
require_once 'C:/xampp/htdocs/tasty/twilio-php-main/src/Twilio/autoload.php';

use Twilio\Rest\Client;
$_POST = json_decode(file_get_contents('php://input'),true);

$sid = "ACb49eb8bc4e3c512d1f3117db2d4595c8";
$token = "09fa0179de07fadf055130421c18068e";
$phone =$_POST["phoneclt"];
$code =$_POST["code"];
$twilio = new Client($sid, $token);

$verification_check = $twilio->verify->v2->services("VA4b0559e622a73e531faafac05f5dc702")
                                         ->verificationChecks
                                         ->create($code,["to" => $phone]);

                                     
if($verification_check->status == "approved"){
    $stmt = $db->prepare("INSERT INTO client (phone) VALUES (?)");
    $result = $stmt->execute([$phone]);  
    echo "user created";
}else{
    echo "verification not done";
}                                       

