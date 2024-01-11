<?php
// CORS Headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

require_once 'db_conn.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $email = $data['email'] ?? null;
    $password = $data['password'] ?? null;

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
                echo json_encode(['status' => 'success', 'message' => 'Login successful', 'userId' => $user['UserID']]);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Pogrešan imejl ili lozinka']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Pogrešan imejl ili lozinka']);
        }
    } catch(PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}
?>
