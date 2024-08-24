<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit;
}

// Firebase credentials
define('FIREBASE_URL', 'https://medipill-87485-default-rtdb.firebaseio.com');
define('FIREBASE_SECRET', 'thLtei5K7rBv8EqYhEjHSGHwQCANRDJO7mFppsNxT'); 

// Function to send data to Firebase
function sendToFirebase($url, $data, $method = 'POST') {
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    
    // Bypass SSL certificate verification
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);

    $response = curl_exec($ch);

    if ($response === false) {
        $error = curl_error($ch);
        curl_close($ch);
        return ['success' => false, 'message' => "cURL error: $error"];
    }

    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode >= 200 && $httpCode < 300) {
        return ['success' => true, 'message' => $response];
    } else {
        return ['success' => false, 'message' => "HTTP error: $httpCode, Response: $response"];
    }
}

// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "pill_dispensary";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user_id = $_SESSION['user_id'];
    $patient_name = $_POST['patient_name'];
    $patient_age = $_POST['patient_age'];
    $medicine1 = $_POST['medicine1'];
    $medicine2 = $_POST['medicine2'];
    $medicine3 = $_POST['medicine3'];

    $stmt = $conn->prepare("INSERT INTO medicine_selections (user_id, patient_name, patient_age, aspirin, panadol, azee) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("isiiii", $user_id, $patient_name, $patient_age, $medicine1, $medicine2, $medicine3);
    
    if ($stmt->execute()) {
        echo "SQL Selection recorded successfully!";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();

    $data = [
        'user_id' => $user_id,
        'patient_name' => $patient_name,
        'patient_age' => $patient_age,
        'aspirin' => (int)$medicine1,
        'panadol' => (int)$medicine2,
        'azee' => (int)$medicine3
    ];

    $url = FIREBASE_URL . '/records.json?auth=' . FIREBASE_SECRET;
    $result = sendToFirebase($url, $data);

    if ($result['success']) {
        echo "Firebase Selection recorded successfully!";
    } else {
        echo "Error sending data to Firebase: " . $result['message'];
    }

    // Replace medicine counts at the root level
    $updates = [
        'Aspirin' => (int)$medicine1,
        'Panadol' => (int)$medicine2,
        'Azee' => (int)$medicine3
    ];

    foreach ($updates as $medicine => $count) {
        $url = FIREBASE_URL . '/' . $medicine . '.json?auth=' . FIREBASE_SECRET;
        $updateResult = sendToFirebase($url, $count, 'PUT');

        if (!$updateResult['success']) {
            echo "Error updating medicine count for $medicine: " . $updateResult['message'];
        }
    }




    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Selection</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('image3.jpg');
            background-size: cover;
            margin: 0;
            font-family: 'Arial', sans-serif;
        }

        .medicine-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 40px 50px;
            border-radius: 15px;
            border: 4px solid #007bff;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            width: 500px;
            text-align: center;
        }

        h1, h2 {
            margin-bottom: 20px;
            color: #ff6347;
            font-weight: bold;
        }

        h2 {
            color: green;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group.flex-group {
            display: flex;
            justify-content: space-between;
        }

        .input-group.flex-group .flex-item {
            width: 48%;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #007bff;
            border-radius: 8px;
            font-size: 16px;
            color: #333;
            background-color: #f9f9f9;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus {
            border-color: #ff6347;
        }

        .patient-details input {
            font-size: 15px;
            font-weight: normal;
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background-color: #28a745;
            color: #ffffff;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #218838;
        }

        .welcome-container {
            text-align: center;
            margin-top: 30px;
        }

        .welcome-container a {
            display: block;
            margin-top: 15px;
            text-decoration: none;
            color: #007bff;
            font-size: 16px;
            transition: color 0.3s ease;
        }

        .welcome-container a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="medicine-container">
        <div class="welcome-container">
            <h1>Welcome, <?php echo htmlspecialchars($_SESSION['username']); ?>!</h1>
            <h2>Select patients medicines and quantities:</h2>

            <form action="" method="POST">
                <div class="input-group flex-group">
                    <div class="flex-item patient-details">
                        <label for="patient_name">Patient Name</label>
                        <input type="text" id="patient_name" name="patient_name" required>
                    </div>
                    <div class="flex-item patient-details">
                        <label for="patient_age">Patient Age</label>
                        <input type="number" id="patient_age" name="patient_age" required>
                    </div>
                </div>
                <div class="input-group">
                    <label for="medicine1">Aspirin</label>
                    <select id="medicine1" name="medicine1">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>
                <div class="input-group">
                    <label for="medicine2">Panadol</label>
                    <select id="medicine2" name="medicine2">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>
                <div class="input-group">
                    <label for="medicine3">Azee</label>
                    <select id="medicine3" name="medicine3">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>
                <button type="submit">Proceed</button>
            </form>
        </div>
    </div>
</body>
</html>
