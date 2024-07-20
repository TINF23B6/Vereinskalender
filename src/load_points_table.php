<?php
$year = "";
if (isset($_GET["year"])) {
    $year = $_GET["year"];
} else {
    $year = date("Y");
}

$output = "";
$output .= "<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n";
$output .= "<!DOCTYPE points_table SYSTEM 'points_table.dtd'> \n";
$output .= "<points_table> \n";

$sql = "SELECT `Club`, `Win`, `Draw`, `Lost`, `Points`, `Year`
        FROM `points_table` 
        WHERE `Year` = '$year' 
        ORDER BY `Points` DESC; ";
        
$result = getSQLQuery($sql);

// Points_Table(Club, Win, Draw, Lost, Points, Year), \

$our_club_name = "Acclaimed Gamers";

if ($result->num_rows > 0) {
    // Ausgabe der Daten jeder Zeile
    while($row = $result->fetch_assoc()) {
        $output .= "\t<team>\n";
        if (strcmp($row["Club"], $our_club_name) === 0) {
            $output .= "\t\t<our_club>true</our_club>\n";
        } 
        $output .= "\t\t<name>" . $row["Club"] . "</name>\n";
        $output .= "\t\t<win>" . $row["Win"] . "</win>\n";
        $output .= "\t\t<draw>" . $row["Draw"] . "</draw>\n";
        $output .= "\t\t<loss>" . $row["Lost"] . "</loss>\n";
        $output .= "\t\t<points>" . $row["Points"] . "</points>\n";
        $output .= "\t\t<year>" . $row["Year"] . "</year>\n";
        $output .= "\t</team>\n";
    }
}

$output .= "</points_table>";

file_put_contents("xml/points_table.xml", $output);

?>