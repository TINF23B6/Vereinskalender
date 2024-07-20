<?php

$failed_login = false;

function checkLogin($username, $password)
{
    // Fetch the hashed password and other details from the database
    $sql = "SELECT `Password`, `IsAdmin`, `UserID`
            FROM `user`
            WHERE `Username` = '$username'";
    $result = getSQLQuery($sql);
    if ($result->num_rows > 0) {
        // Ausgabe der Daten jeder Zeile
        while ($row = $result->fetch_assoc()) {
            $hashed_password = $row["Password"];
            if (password_verify($password, $hashed_password)) {
                $userID = $row["UserID"];
                $_SESSION['userID'] = $userID;
                if ($row["IsAdmin"] == 1) {
                    return 2; // Admin user
                } else {
                    return 1; // Regular user
                }
            }
        }
    }
    return 0; // Invalid login
}

session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    if (isset($_POST['logout'])) {
        unset($_SESSION['username']);
        unset($_SESSION['isAdmin']);
        unset($_SESSION['userID']);
        session_destroy();
    } else if (isset($_POST["login"])) {

        $username = strval($_POST['username']);
        $password = strval($_POST['password']);

        $login_result = checkLogin($username, $password);
        if ($login_result === 1) {
            $_SESSION['username'] = $username;
            $_SESSION['isAdmin'] = "false";
            unset($_POST);
        } else if ($login_result === 2) {
            $_SESSION['username'] = $username;
            $_SESSION['isAdmin'] = "true";
            unset($_POST);
        } else {
            $failed_login = true;
            unset($_POST);
        }
    }
}

?>