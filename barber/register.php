<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: X-Requested-With, content-type, access-control-allow-origin, access-control-allow-methods, access-control-allow-headers");

require "connect.php";

// Check connection
if (!$con) {
    die("Connection error: " . mysqli_connect_error());
}

// Ensure that the variables are defined with default values
$cus_name = isset($_POST['name']) ? $_POST['name'] : '';
$cus_lastname = isset($_POST['lastname']) ? $_POST['lastname'] : '';
$cus_phone = isset($_POST['phone']) ? $_POST['phone'] : '';
$cus_email = isset($_POST['email']) ? $_POST['email'] : '';
$cus_password = isset($_POST['password']) ? md5($_POST['password']) : '';

$sql = "SELECT * FROM customer_table WHERE cus_email = '$cus_email'";
$result = mysqli_query($con, $sql);
$count = mysqli_num_rows($result);

if ($count == 1) {
    echo json_encode('Error');
} else {
    $insert = "INSERT INTO customer_table(cus_name, cus_lastname, cus_phone, cus_email, cus_password) VALUES ('$cus_name','$cus_lastname','$cus_phone', '$cus_email', '$cus_password')";
    $query = mysqli_query($con, $insert);

    if ($query) {
        echo json_encode('Succeed');
    } else {
        echo json_encode(['error' => mysqli_error($con)]);
    }
}

// Stop execution after sending JSON response
exit();
?>
