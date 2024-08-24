<?php
$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    if ($password !== $confirm_password) {
        $error = 'Passwords do not match.';
    } else {
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        $host = 'localhost';
        $db = 'pill_dispensary';
        $user = 'root';
        $pass = '';

        $conn = new mysqli($host, $user, $pass, $db);

        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        $stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
        $stmt->bind_param("ss", $username, $hashed_password);

        if ($stmt->execute()) {
            $success = "User registered successfully.";
        } else {
            $error = "Error: " . $stmt->error;
        }

        $stmt->close();
        $conn->close();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pill Dispensary App - Register</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url(image2.jpg);
            background-size: cover;
            font-family: 'Helvetica Neue', Arial, sans-serif;
        }

        .register-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
            width: 400px;
            text-align: center;
        }

        .register-container h2 {
            margin-bottom: 25px;
            color: red;
            font-size: 35px;
        }

        .register-container .input-group {
            margin-bottom: 25px;
            text-align: left;
        }

        .register-container label {
            display: block;
            margin-bottom: 10px;
            color: #555;
            font-weight: bold;
        }

        .register-container input {
            width: 100%;
            padding: 15px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
            color: #495057;
        }

        .register-container button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #ffffff;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .register-container button:hover {
            background-color: #0056b3;
        }

        .register-container .error {
            color: red;
            margin-bottom: 20px;
        }

        .register-container .success {
            color: green;
            margin-bottom: 20px;
        }

        .header-title {
            position: absolute;
            top: 20px;
            font-size: 36px;
            font-weight: bold;
            color: #333;
            text-align: center;
            width: 100%;
        }

        .register-container .login-link {
            margin-top: 20px;
            display: block;
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
        }

        .register-container .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header-title"><h1>PILL DISPENSARY APP</h1></div>
    <div class="register-container">
        <h2>Register</h2>
        <?php if ($error): ?>
            <div class="error"><?php echo $error; ?></div>
        <?php endif; ?>
        <?php if ($success): ?>
            <div class="success"><?php echo $success; ?></div>
        <?php endif; ?>
        <form action="" method="POST">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="input-group">
                <label for="confirm_password">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" required>
            </div>
            <button type="submit">Register</button>
        </form>
        <a href="login.php" class="login-link">Go to Login Page</a>
    </div>
</body>
</html>
