<?php
// Include database connection
require_once 'db_conn.php';

// Check if the request is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = isset($_POST['username']) ? $_POST['username'] : null;
    $email = isset($_POST['email']) ? $_POST['email'] : null;
    $password = isset($_POST['password']) ? $_POST['password'] : null;

    if (empty($username) || empty($email) || empty($password)) {
        echo json_encode(['status' => 'error', 'message' => 'Missing required fields']);
        exit;
    }

    $passwordHash = password_hash($password, PASSWORD_DEFAULT);

    $sql = "INSERT INTO Users (Username, Email, PasswordHash) VALUES (:username, :email, :passwordHash)";

    try {
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':passwordHash', $passwordHash);
        $stmt->execute();

        echo json_encode(['status' => 'success', 'message' => 'Account created successfully']);
    } catch(PDOException $e) {
        if ($e->getCode() == 23000) {
            // Handle unique constraint violation, which indicates a duplicate username or email
            echo json_encode(['status' => 'error', 'message' => 'Username or email already exists']);
        } else {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}
?>
