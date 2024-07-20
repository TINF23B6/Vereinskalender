<?php

/*
Match(MatchID, Name, Date, Time_Period, Place, Type, 
Club0, Club1, Points0, Points1, Info_Text, Notice, Changelog), \
Club_Events(Club_EventID, Name, Date, Time_Period, Place, Type, Info_Text, Notice, Changelog), \
*/

$output = "";
$output .= "<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n";
$output .= "<!DOCTYPE events SYSTEM 'events.dtd'> \n";
$output .= "<events> \n";

$index = 0;

$sql = "SELECT `MatchID`, `Name`, `Date`, `Time_Period`, `Place`, `Type`, `Club0`, `Club1`, 
        `Points0`, `Points1`, `Info_Text`, `Notice`
        FROM `match`
        WHERE `Date` >= '$first_day'
        AND `Date` <= '$last_day'
        Order BY `Time_Period` DESC";

$result = getSQLQuery($sql);

if ($result->num_rows > 0) {
    // Ausgabe der Daten jeder Zeile
    while ($row = $result->fetch_assoc()) {
        $output .= "\t<event>\n";
        $output .= "\t\t<index>" . $index . "</index>\n";
        $output .= "\t\t<id>match_" . $row["MatchID"] . "</id>\n";
        $output .= "\t\t<event_type>match</event_type>\n";
        $output .= "\t\t<name>" . $row["Name"] . "</name>\n";
        $output .= "\t\t<date>" . $row["Date"] . "</date>\n";
        $output .= "\t\t<time_period>" . $row["Time_Period"] . "</time_period>\n";
        $output .= "\t\t<type>" . $row["Type"] . "</type>\n";
        $output .= "\t\t<place>" . $row["Place"] . "</place>\n";
        $output .= "\t\t<club0>" . $row["Club0"] . "</club0>\n";
        $output .= "\t\t<club1>" . $row["Club1"] . "</club1>\n";
        $output .= "\t\t<points0>" . $row["Points0"] . "</points0>\n";
        $output .= "\t\t<points1>" . $row["Points1"] . "</points1>\n";
        $output .= "\t\t<info_text>" . $row["Info_Text"] . "</info_text>\n";
        $output .= "\t\t<notice>" . $row["Notice"] . "</notice>\n";
        $output .= "\t</event>\n";
        $index++;
    }
}

$sql = "SELECT `Club_EventID`, `Name`, `Date`, `Time_Period`, `Place`, `Type`, `Info_Text`, `Notice`
        FROM `club_events`
        WHERE `Date` >= '$first_day'
        AND `Date` <= '$last_day'
        Order BY `Time_Period` DESC";

$result = getSQLQuery($sql);

if ($result->num_rows > 0) {
    // Ausgabe der Daten jeder Zeile
    while ($row = $result->fetch_assoc()) {
        $output .= "\t<event>\n";
        $output .= "\t\t<index>" . $index . "</index>\n";
        $output .= "\t\t<id>club_events_" . $row["Club_EventID"] . "</id>\n";
        $output .= "\t\t<event_type>club_events</event_type>\n";
        $output .= "\t\t<name>" . $row["Name"] . "</name>\n";
        $output .= "\t\t<date>" . $row["Date"] . "</date>\n";
        $output .= "\t\t<time_period>" . $row["Time_Period"] . "</time_period>\n";
        $output .= "\t\t<type>" . $row["Type"] . "</type>\n";
        $output .= "\t\t<place>" . $row["Place"] . "</place>\n";
        $output .= "\t\t<info_text>" . $row["Info_Text"] . "</info_text>\n";
        $output .= "\t\t<notice>" . $row["Notice"] . "</notice>\n";
        $output .= "\t</event>\n";
        $index++;
    }
}

$output .= "</events>";

file_put_contents("xml/events.xml", $output);
