<?php

$output = "";


$output .= "<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n";
$output .= "<!DOCTYPE calendar SYSTEM 'calendar_month.dtd'> \n";
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
$year = "";
if (isset($_GET["year"])) {
    $year = $_GET["year"];
} else {
    $year = date("Y");
}

$output .= "\t<month>$month</month>\n";
$output .= "\t<year>$year</year>\n";

// create links for the month buttons 

for ($i = 1; $i <= 12; $i++) {
    $output .= "\t<month_btn>\n";
    $output .= "\t\t<index>" . sprintf("%02d", $i) . "</index>\n";
    $output .= "\t\t<name_month>" . $months[$i] . "</name_month>\n";
    /*
    $output .= "\t\t<new_path_month>";
    $output .= "<![CDATA[" . $path . "&day=01&month=" . sprintf("%02d", $i) . "&year=" . $year . "]]>";
    $output .= "</new_path_month>\n";
    */
    $output .= "\t</month_btn>\n";
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

$path .= "?view=month";
$new_path_points_table_btn = $path;
$path .= "&pointsTableActive=$pointsTableActive";
$current_path = $path;

$output .= "\t<path_month_btn><![CDATA[$path]]></path_month_btn>\n";

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

$path_week = str_replace("view=month", "view=week", $current_path);
$path_year = str_replace("view=month", "view=year", $current_path);
$path_month = $current_path;

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

$date->modify('+1 month');
$day_right = "01";
$month_right = $date->format('m');
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

$date->modify('-1 month');
$day_left = "01";
$month_left = $date->format('m');
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

// get month and year
date_default_timezone_set('Europe/Paris');
$given_year = "";
if (isset($_GET["year"])) {
    $given_year = $_GET["year"];
} else {
    $given_year = date("Y");
}
$given_month = "";
if (isset($_GET["month"])) {
    $given_month = $_GET["month"];
} else {
    $given_month = date("m");
}
$shown_month = $given_year . "-" . $given_month;

// calculate the first day that is shown in the calendar (i_day)
$shown_month_unixTimestamp = strtotime($shown_month . "-1");
$number_weekday = date("w", $shown_month_unixTimestamp);
if ($number_weekday == 0) {
    $number_weekday = 7;
}
$number_days_before_first_of_the_month = 1 - $number_weekday;

$i_day = new DateTime($shown_month);
$i_day->modify("$number_days_before_first_of_the_month day");

// make arrays with the information to the shown days
$days_numbers_calendar = array();
$days_calendar = array();
$in_shown_month = array();
$number_days_shown = 41;
$small_calendar = false;
for ($i = 0; $i <= 41; $i++) {
    if ($i === 35) {
        if (!(strncmp($i_day->format('Y-m-d'), $shown_month, 7) === 0)) {
            $number_days_shown = 34;
            $small_calendar = true;
            break;
        }
    }
    $days_calendar[] = $i_day->format('d');
    $dates_calendar[] = $i_day->format('Y-m-d');
    if (strncmp($dates_calendar[$i], $shown_month, 7) === 0) {
        $in_shown_month[] = " in-month";
    } else {
        $in_shown_month[] = " outside-month";
    }

    $i_day->modify("+1 day");
}

if ($small_calendar) {
    $output .= "\t<calendar_size>small</calendar_size> \n";
} else {
    $output .= "\t<calendar_size></calendar_size> \n";
}

for ($i = 0; $i <= $number_days_shown; $i++) {
    $output .= "\t<day_month> \n";
    $output .= "\t\t<number>$i</number> \n";
    $output .= "\t\t<date>" . $dates_calendar[$i] . "</date> \n";
    $output .= "\t\t<day_number>" . $days_calendar[$i] . "</day_number> \n";
    $output .= "\t\t<in_shown_month>" . $in_shown_month[$i] . "</in_shown_month> \n";
    $output .= "\t</day_month> \n";
}

$output .= "</calendar>";

file_put_contents("xml/calendar.xml", $output);

?>	