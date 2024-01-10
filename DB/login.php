<?php
// Include database connection
require_once 'db_conn.php';

// Check if the request is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = isset($_POST['email']) ? $_POST['email'] : null;
    $password = isset($_POST['password']) ? $_POST['password'] : null;

    if (empty($email) || empty($password)) {
        echo json_encode(['status' => 'error', 'message' => 'Missing required fields']);
        exit;
    }

    // SQL to check if the user exists with the given email
    $sql = "SELECT UserID, PasswordHash FROM Users WHERE Email = :email LIMIT 1";

    try {
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':email', $email);
        $stmt->execute();

        if ($stmt->rowCount() == 1) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            if (password_verify($password, $user['PasswordHash'])) {
                // Password is correct
                // Here, you can set session variables, generate tokens, etc., as per your application requirement
                echo json_encode(['status' => 'success', 'message' => 'Login successful', 'userId' => $user['UserID']]);
            } else {
                // Password is incorrect
                echo json_encode(['status' => 'error', 'message' => 'Incorrect password']);
            }
        } else {
            // User not found
            echo json_encode(['status' => 'error', 'message' => 'User not found']);
        }
    } catch(PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}
?>
