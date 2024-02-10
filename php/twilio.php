<?php

require_once 'C:/xampp/htdocs/tasty/twilio-php-main/src/Twilio/autoload.php';

$_POST = json_decode(file_get_contents('php://input'),true);
use Twilio\Rest\Client;

$phone =$_POST['phoneclt'];


$sid = "ACb49eb8bc4e3c512d1f3117db2d4595c8";
$token ="09fa0179de07fadf055130421c18068e";
$twilio = new Client($sid, $token);

$verification = $twilio->verify->v2->services("VA4b0559e622a73e531faafac05f5dc702")
                                   ->verifications
                                   ->create($phone,"sms");

$response = array("message" =>"SMS SENT");

echo json_encode ($response);                         

print($verification->sid);

