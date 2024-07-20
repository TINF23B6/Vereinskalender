<?php

$output = "";

$output .= "<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n";
$output .= "<!DOCTYPE calendar SYSTEM 'calendar_year.dtd'> \n";
$output .= "<calendar> \n";

if ($failed_login){
    $output .= "\t<failedLogin>true</failedLogin>\n";
} else {
    $output .= "\t<failedLogin>false</failedLogin>\n";
}

$username = "";
if (isset($_SESSION['username'])) {
    $username = strval($_SESSION['username']) ;
    $output .= "\t<userLoggedIn>true</userLoggedIn>\n";
} else {
    $output .= "\t<userLoggedIn>false</userLoggedIn>\n";
}
$output .= "\t<username><![CDATA[". $username ."]]></username>\n";

$is_admin = "";
if (isset($_SESSION['isAdmin'])) {
    $is_admin = strval($_SESSION['isAdmin']) ;
}
$output .= "\t<isAdmin>". $is_admin ."</isAdmin>\n";

// name, date-day, date-month, date-year, time-period-beginn, time-period-ende
// place, type, clubs0, clubs1, points0, points1, info-text, notice

$output .= "\t<dateWrong>". strval($date_wrong) ."</dateWrong>\n";
$output .= "\t<timeWrong>". strval($time_wrong) ."</timeWrong>\n";
$output .= "\t<newEventType>". strval($new_event_type) ."</newEventType>\n";
$output .= "\t<editEvent>". strval($edit_event) ."</editEvent>\n";

$new_event_fields = array("id", "name", "date-day", "date-month", "date-year", "time-period-beginn", 
    "time-period-ende", "place", "type", "clubs0", "clubs1", "points0", "points1", 
    "info-text", "notice");

function fieldFormatter($string) {
    return str_replace("-", "_", $string);
}

function returnIfPostSet($value) {
    if(isset($_POST[$value])){
        	return strval($_POST[$value]);
    } else {
            return "";
    }
}

foreach ($new_event_fields as $new_event_field) {
    $output .= "\t<". fieldFormatter($new_event_field) ."><![CDATA[". 
        returnIfPostSet($new_event_field) . 
        "]]></". fieldFormatter($new_event_field) .">\n";
}


if (isset($_GET["pointsTableActive"])) {
    $pointsTableActive = strval($_GET["pointsTableActive"]);
} else {
    $pointsTableActive = "false";
}

$output .= "\t<pointsTableActive>$pointsTableActive</pointsTableActive>\n";

// get shown month
$month = "";
$months = array(
    "", "Januar", "Februar", "März",
    "April", "Mai", "Juni", "Juli", "August",
    "September", "Oktober", "November", "Dezember"
);
if (isset($_GET["month"])) {
    $month = $months[intval($_GET["month"])];
} else {
    $month = $months[intval(date("m"))];
}
//$year = "";
if (isset($_GET["year"])) {
    $year = $_GET["year"];
} else {
    $year = date("Y");
}

$output .= "\t<year>$year</year>\n";

// create links for the month buttons 

for ($i = 1; $i <= 12; $i++) {
    $output .= "\t<month>\n";
    $output .= "\t\t<index>" . $i . "</index>\n";
    $output .= "\t\t<month_name>" . $months[$i] . "</month_name>\n";
    $output .= "\t\t<date>". $year ."-". sprintf("%02d", $i) ."-01</date>\n";
    $output .= "\t</month>\n";
}

// link to Home
$home_path = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS']
    === 'on' ? "https" : "http") . "://" .
    $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
$home_path = str_replace("calendar.php", "home.php", $home_path);

$output .= "\t<home_path><![CDATA[$home_path]]></home_path>\n";

// make link with the current path except the $_GET parameter for the date
$path = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS']
    === 'on' ? "https" : "http") . "://" .
    $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
// GET variablen: view, pointsTableActive, day, month, year

$path .= "?view=year";
$new_path_points_table_btn = $path;
$path .= "&pointsTableActive=$pointsTableActive";
$current_path = $path;

$output .= "\t<path_year_btn><![CDATA[$path]]></path_year_btn>\n";

// create link for new_path_pointsTableBtn

if (strcmp($pointsTableActive, "false") === 0) {
    $new_path_points_table_btn .= "&pointsTableActive=true";
} else {
    $new_path_points_table_btn .= "&pointsTableActive=false";
}

if (isset($_GET["year"])) {
    $new_path_points_table_btn .= "&day=" . $_GET["day"] . "&month=" . $_GET["month"] . "&year=" . $_GET["year"];
    $current_path .= "&day=" . $_GET["day"] . "&month=" . $_GET["month"] . "&year=" . $_GET["year"];
} else {
    $new_path_points_table_btn  .= "&day=" . date('d') . "&month=" . date('m') . "&year=" . date('Y');
    $current_path  .= "&day=" . date('d') . "&month=" . date('m') . "&year=" . date('Y');
}

$output .= "\t<current_path><![CDATA[$current_path]]></current_path>\n";
$output .= "\t<new_path_points_table_btn><![CDATA[$new_path_points_table_btn]]></new_path_points_table_btn>\n";

$path_week = str_replace("view=year", "view=week", $current_path);
$path_month = str_replace("view=year", "view=month", $current_path);
$path_year = $current_path;

$output .= "\t<path_week><![CDATA[$path_week]]></path_week>\n";
$output .= "\t<path_year><![CDATA[$path_year]]></path_year>\n";
$output .= "\t<path_month><![CDATA[$path_month]]></path_month>\n";


// create links for left, today and right button

$new_path_right = $path;

$day_right = $month_right = $year_right = "";
if (isset($_GET["view"])) {
    $date = new DateTime($_GET["year"] . "-" . $_GET["month"] .
        "-" . $_GET["day"], new DateTimeZone('Europe/Berlin'));
} else {
    $date = new DateTime(date('Y-m-d'), new DateTimeZone('Europe/Berlin'));
}

$date->modify('+1 year');
$day_right = "01";
$month_right = "01";
$year_right = $date->format('Y');

$new_path_right .= "&day=" . $day_right .
    "&month=" . $month_right .
    "&year=" . $year_right;

$new_path_left = $path;

$day_left = $month_left = $year_left = "";
if (isset($_GET["view"])) {
    $date = new DateTime($_GET["year"] . "-" . $_GET["month"] .
        "-" . $_GET["day"], new DateTimeZone('Europe/Berlin'));
} else {
    $date = new DateTime(date('Y-m-d'), new DateTimeZone('Europe/Berlin'));
}

$date->modify('-1 year');
$day_left = "01";
$month_left = "01";
$year_left = $date->format('Y');

$new_path_left .= "&day=" . $day_left .
    "&month=" . $month_left .
    "&year=" . $year_left;

$new_path_today = $path . "&day=" . date('d') .
    "&month=" . date('m') .
    "&year=" . date('Y');

$output .= "\t<new_path_left><![CDATA[$new_path_left]]></new_path_left>\n";
$output .= "\t<new_path_today><![CDATA[$new_path_today]]></new_path_today>\n";
$output .= "\t<new_path_right><![CDATA[$new_path_right]]></new_path_right>\n";

$output .= "\t<date_today>" . date('Y-m-d') . "</date_today>\n";

// first and last day
$dates_calendar[] = $year . "-01-01";

$date = new DateTime($year +1 ."-01-01");
$date->modify('-1 day');
$dates_calendar[] = $date->format('Y-m-d');

$output .= "</calendar>";

file_put_contents("xml/calendar.xml", $output);

?>