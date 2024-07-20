<?php

$output = "";
$output .= "<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n";
$output .= "<!DOCTYPE users SYSTEM 'users.dtd'> \n";
$output .= "<users> \n";


$sql = "SELECT UserID, Username, IsAdmin 
        FROM user";

$result = getSQLQuery($sql);

if ($result->num_rows > 0) {
    // Ausgabe der Daten jeder Zeile
    while ($row = $result->fetch_assoc()) {
        if (!(strcmp(strval($row["UserID"]), $_SESSION['userID']) == 0)) {
            $output .= "\t<user>\n";
            $output .= "\t\t<id>" . $row["UserID"] . "</id>\n";
            $output .= "\t\t<name>" . $row["Username"] . "</name>\n";
            $output .= "\t\t<isAdmin>" . $row["IsAdmin"] . "</isAdmin>\n";
            $output .= "\t</user>\n";
        }
    }
}

$output .= "</users>";

file_put_contents("xml/users.xml", $output);
