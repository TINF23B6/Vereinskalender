<?php

// Check and create default admin user if it doesn't exist
function createDefaultAdminUser() {
    $default_username = 'admin';
    $default_password = 'admin';
    $hashed_password = password_hash($default_password, PASSWORD_BCRYPT);
    $default_isAdmin = "1";

    // Check if the default admin user already exists
    $sql = "SELECT COUNT(*) AS userCount FROM `user` WHERE `Username` = '$default_username'";
    $result = getSQLQuery($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            if ($row['userCount'] == 0) {
                // Create the default admin user
                $sql = "SELECT MAX(UserID) FROM `user`";
                $result = getSQLQuery($sql);
                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        $maxUserID = $row["MAX(UserID)"];
                    }
                } else {
                    $maxUserID = 0;
                }
                $maxUserID = $maxUserID + 1;

                $sql = "INSERT INTO `user` (`UserID`, `Username`, `Password`, `IsAdmin`) 
                VALUES ('$maxUserID', '$default_username', '$hashed_password', '$default_isAdmin')";
                getSQLQuery($sql);
            }
        }
    }
}

createDefaultAdminUser();

if (isset($_POST["create-new-user"])) {

    $new_user_name = strval($_POST["username"]);
    $new_user_password = strval($_POST["password"]);

    // Hash the password
    $hashed_password = password_hash($new_user_password, PASSWORD_BCRYPT);

    if (isset($_POST["admin"])) {
        $new_user_isAdmin = "1";
    } else {
        $new_user_isAdmin = "0";
    }

    $sql = "SELECT MAX(UserID) FROM `user`";
    $result = getSQLQuery($sql);
    if ($result->num_rows > 0) {
        // Ausgabe der Daten jeder Zeile
        while ($row = $result->fetch_assoc()) {
            $maxUserID = $row["MAX(UserID)"];
        }
    }
    $maxUserID = $maxUserID + 1;

    $sql = "INSERT INTO `user` (`UserID`, `Username`, `Password`, `IsAdmin`) 
    VALUES ('$maxUserID', '$new_user_name', '$hashed_password', '$new_user_isAdmin')";

    getSQLQuery($sql);

} else if (isset($_POST["users-set-new-username"])) {

    $new_username = strval($_POST["new-username"]);
    $id = strval($_POST["id"]);

    $sql = "UPDATE `user` SET `Username`='$new_username' WHERE `UserID` = $id";

    getSQLQuery($sql);

} else if (isset($_POST["users-set-new-password"])) {

    $new_password = strval($_POST["new-password"]);
    $id = strval($_POST["id"]);

    // Hash the new password
    $hashed_password = password_hash($new_password, PASSWORD_BCRYPT);

    $sql = "UPDATE `user` SET `Password`='$hashed_password' WHERE `UserID` = $id";

    getSQLQuery($sql);

} else if (isset($_POST["users-delete-user"])) {

    $id = strval($_POST["id"]);

    $sql = "DELETE FROM `user` WHERE `UserID` = $id";

    getSQLQuery($sql);

}

?>
