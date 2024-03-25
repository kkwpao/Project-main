<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: X-Requested-With, content-type, access-control-allow-origin, access-control-allow-methods, access-control-allow-headers");

require "connect.php";

// Check connection
if (!$con) {
    die("Connection error: " . mysqli_connect_error());
}

$search_date = isset($_POST['search_date']) ? $_POST['search_date'] : '';

if (empty($search_date)) {
    echo json_encode(['error' => 'Invalid search date']);
    exit;
}

$sql = "SELECT jq.*, ut.user_name, ut.user_phone, ut.user_lastname  
        FROM jobqueue AS jq
        LEFT JOIN user_table AS ut ON jq.user_id = ut.user_id
        WHERE DATE(job_startdate) = ?";
$stmt = $con->prepare($sql);
$stmt->bind_param('s', $search_date);
$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    $data = array();

    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = array(
            'user_id' => $row['user_id'],
            'user_lastname' => $row['user_lastname'],
            'user_phone' => $row['user_phone'],
            'user_name' => $row['user_name'],
            'job_startdate' => $row['job_startdate']
        );
    }

    echo json_encode(array(
        "result" => 1,
        "message" => "Success",
        "data" => $data
    ));
} else {
    // Error in the SQL query
    echo json_encode(['error' => mysqli_error($con)]);
}

// Stop execution after sending JSON response
exit();
?>
