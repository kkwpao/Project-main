<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: X-Requested-With, content-type, access-control-allow-origin, access-control-allow-methods, access-control-allow-headers");

require "connect.php";

// Check connection
if (!$con) {
    die("Connection error: " . mysqli_connect_error());
}

$cus_id = isset($_POST['cus_id']) ? $_POST['cus_id'] : '';

$sql = "SELECT * FROM customer_table WHERE cus_id = '" . $cus_id . "'";
$result = mysqli_query($con, $sql);

if ($result) {
    $resultObj = mysqli_fetch_assoc($result);
        echo json_encode(array(
            "result" => 1,
            "message" => "Success",
            "data" => array(
                'cus_name' => $resultObj['cus_name'],
                'cus_lastname' => $resultObj['cus_lastname'],
                'cus_phone' => $resultObj['cus_phone'],
                'cus_email' => $resultObj['cus_email']
                
            )
        ));
    
} else {
    // Error in the SQL query
    echo json_encode(['error' => mysqli_error($con)]);
}

// Stop execution after sending JSON response
exit();