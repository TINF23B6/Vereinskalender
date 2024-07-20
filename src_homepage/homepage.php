<?php

$output = "";


$output .= "<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n";
$output .= "<homepage> \n";

// link to Home
$calendar_path = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS']
    === 'on' ? "https" : "http") . "://" .
    $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
$calendar_path = str_replace("home.php", "calendar.php", $calendar_path);

$output .= "\t<calendar_path><![CDATA[$calendar_path]]></calendar_path>\n";

$output .= "</homepage>";

file_put_contents("src_homepage/homepage.xml", $output);


?>