<?php

// TODO
// make an Function that gets an SQL Query as input and returns result
include("api/db_api.php");

// Check if a User is logged in
include("src/login.php");

// Check if a new Event is generated or event is changed
include("src/event.php");

// Check if a new user is added, old one is deleted, password got changed
include("src/user.php");


// Makes calendar.xml for month view
if (isset($_GET["view"])) {
    switch ($_GET["view"]) {
        case "week":
            include("src/calendar_month.php");
            break;
        case "month":
            include("src/calendar_month.php");
            break;
        case "year":
            include("src/calendar_year.php");
            break;
    }
} else {
    include("src/calendar_month.php");
}

$first_day = $dates_calendar[0];
$last_day = $dates_calendar[array_key_last($dates_calendar)];

// TODO David
// Loads all events in time span from $first_day to $last_day in events1.xml
include("src/load_events.php");

if (isset($_SESSION['username'])) {
    // TODO David
    // Loads all users, excluding the logged in user
    include("src/load_users.php");
}

if (isset($_GET["pointsTableActive"]) && strcmp($_GET["pointsTableActive"], "true") === 0) {
    // TODO David
    // Reload the points_table1.xml content
    include("src/load_points_table.php");
}


// Load the XML document
$xml = new DOMDocument();
$xml->load('./xml/calendar.xml');

// Load the XSLT stylesheet
$xsl = new DOMDocument();

if (isset($_GET["view"])) {
    switch ($_GET["view"]) {
        case "week":
            $xsl->load('src/month.xsl');
            break;
        case "month":
            $xsl->load('src/month.xsl');
            break;
        case "year":
            $xsl->load('src/year.xsl');
            break;
    }
} else {
    $xsl->load('src/month.xsl');
}

// Create the XSLTProcessor object
$xsltProcessor = new XSLTProcessor();

// Load the XSLT stylesheet into the XSLTProcessor object
$xsltProcessor->importStylesheet($xsl);

// Apply the XSLT transformation to the XML document
$html = $xsltProcessor->transformToXML($xml);
$html = "<!DOCTYPE html>\n" . $html;

// Write Output in File
file_put_contents("output.html", $html);

// Output the transformed HTML
echo $html;
