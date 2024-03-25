<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: X-Requested-With, content-type, access-control-allow-origin, access-control-allow-methods, access-control-allow-headers");

require "connect.php";

// Check connection
if (!$con) {
    die("Connection error: " . mysqli_connect_error());
}

$cus_id = $_POST['cus_id'];
$cus_name = $_POST['cus_name'];
$cus_lastname = $_POST['cus_lastname'];
$cus_phone = $_POST['cus_phone'];
$cus_email = $_POST['cus_email'];


$updatedData = fetchUpdatedData($cus_id, $con);
// สร้าง statement
$stmt = $con->prepare("UPDATE customer_table SET cus_name = ?, cus_lastname = ?, cus_phone = ?, cus_email = ? WHERE cus_id = ?");

// กำหนดค่าพารามิเตอร์
$stmt->bind_param("sssss", $cus_name, $cus_lastname, $cus_phone, $cus_email, $cus_id);

// ประมวลผลคำสั่ง SQL
if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Customer updated successfully', 'data' => $updatedData]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $con->error]);
}

// ปิด statementz
$stmt->close();

// ปิดการเชื่อมต่อกับฐานข้อมูล
mysqli_close($con);

function fetchUpdatedData($cus_id, $con) {
    $stmt = $con->prepare("SELECT * FROM customer_table WHERE cus_id = ?");
    $stmt->bind_param("s", $cus_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // ดึงข้อมูลและแปลงให้เป็น String
        $data = $result->fetch_assoc();
        $data['cus_id'] = (string)$data['cus_id'];
        return $data;
    }

    return null;
}


