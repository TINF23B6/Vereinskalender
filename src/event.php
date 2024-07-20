<?php

$new_event_type = "";
$date_wrong = false;
$time_wrong = false;
$edit_event = false;

function isValidDate($date, $format = 'Y-m-d')
{
    $d = DateTime::createFromFormat($format, $date);
    return $d && $d->format($format) === $date;
}

function addZeroIfOneChar($string)
{
    if (strlen($string) == 1) {
        return '0' . $string;
    }
    return $string;
}

function isValidTime($time)
{
    if (empty($time)) {
        return true;
    } else {
        $pattern = "/^(?:2[0-3]|[01][0-9]):[0-5][0-9]$/";

        return preg_match($pattern, $time);
    }
}

function isDateWrong()
{
    $date = strval($_POST["date-year"]) . "-" . addZeroIfOneChar(strval($_POST["date-month"])) .
        "-" . addZeroIfOneChar(strval($_POST["date-day"]));
    if (!isValidDate($date)) {
        return true;
    }
    return false;
}

function isTimeWrong()
{
    if ((!isValidTime(strval($_POST["time-period-beginn"]))) ||
        (!isValidTime(strval($_POST["time-period-ende"])))
    ) {
        return true;
    }
    return false;
}

function add0($string)
{
    if (strlen($string) == 1) {
        return '0' . $string;
    }
    return $string;
}

if (isset($_POST["new-match"])) {

    $new_event_type = "match";


    // Variables in $_POST 
    // name, date-day, date-month, date-year, time-period-beginn, time-period-ende
    // place, type, clubs0, clubs1, points0, points1, info-text, notice

    $date_wrong = isDateWrong();
    $time_wrong = isTimeWrong();

    if (!($date_wrong || $time_wrong)) {

        // TODO Write to database
        // 1. höchste MatchID auslesen
        $sql = "SELECT MAX(MatchID) FROM `match`";
        $result = getSQLQuery($sql);
        if ($result->num_rows > 0) {
            // Ausgabe der Daten jeder Zeile
            while ($row = $result->fetch_assoc()) {
                $maxMatchID = $row["MAX(MatchID)"];
            }
        }
        $maxMatchID = $maxMatchID + 1;
        $time_period;
        $points0;
        $points1;

        if (strcmp($_POST["time-period-ende"], '') == 0) {
            $time_period = $_POST["time-period-beginn"];
        } else {
            $time_period = "{$_POST["time-period-beginn"]}-{$_POST["time-period-ende"]}";
        }

        if (strcmp($_POST["points0"], '') == 0) {
            $points0 = "NULL";
        } else {
            $points0 = $_POST["points0"];
        }

        if (strcmp($_POST["points1"], '') == 0) {
            $points1 = "NULL";
        } else {
            $points1 = $_POST["points1"];
        }

        $sql = "INSERT INTO `match` (`MatchID`, `Name`, `Date`, `Time_Period`, `Place`, `Type`, `Club0`, `Club1`, `Points0`, `Points1`, `Info_Text`, `Notice`, `Changelog`) 
        VALUES ('$maxMatchID', '" . $_POST["name"] . "', '" . $_POST["date-year"] . "-" . add0($_POST["date-month"]) . "-" . add0($_POST["date-day"]) . "', '$time_period', '" . $_POST["place"] . "', '" . $_POST["type"] . "', '" . $_POST["clubs0"] . "', '" . $_POST["clubs1"] . "', $points0, $points1, '" . $_POST["info-text"] . "', '" . $_POST["notice"] . "', 'Erstellt von " . $_SESSION['username'] . "')";

        getSQLQuery($sql);

        unset($_POST);

        include("src/update_points_table_db.php");
    }
} else if (isset($_POST["new-club-event"])) {

    $new_event_type = "club-event";

    $date_wrong = isDateWrong();
    $time_wrong = isTimeWrong();


    if (!($date_wrong || $time_wrong)) {

        // TODO Write to database
        $sql = "SELECT MAX(Club_EventID) FROM `club_events`";
        $result = getSQLQuery($sql);
        if ($result->num_rows > 0) {
            // Ausgabe der Daten jeder Zeile
            while ($row = $result->fetch_assoc()) {
                $maxClub_EventID = $row["MAX(Club_EventID)"];
            }
        }
        $maxClub_EventID = $maxClub_EventID + 1;
        $time_period;

        if (strcmp($_POST["time-period-ende"], '') == 0) {
            $time_period = $_POST["time-period-beginn"];
        } else {
            $time_period = "{$_POST["time-period-beginn"]}-{$_POST["time-period-ende"]}";
        }

        $sql = "INSERT INTO `club_events` (`Club_EventID`, `Name`, `Date`, `Time_Period`, `Place`, `Type`, `Info_Text`, `Notice`, `Changelog`) 
        VALUES ('$maxClub_EventID', '" . $_POST["name"] . "', '" . $_POST["date-year"] . "-" . add0($_POST["date-month"]) . "-" . add0($_POST["date-day"]) . "', '$time_period', '" . $_POST["place"] . "', '" . $_POST["type"] . "', '" . $_POST["info-text"] . "', '" . $_POST["notice"] . "', 'Erstellt von " . $_SESSION['username'] . "')";

        getSQLQuery($sql);

        unset($_POST);
    }
} else if (isset($_POST["edit-event"])) {

    $edit_event = true;
} else if (isset($_POST["edit-event-submitted"])) {

    $edit_event = true;

    $date_wrong = isDateWrong();
    $time_wrong = isTimeWrong();

    if (!($date_wrong || $time_wrong)) {
        $edit_event = false;
        // $event_type = 0 -> match
        // $event_type = 1 -> club_event
        $event_type = -1;
        $event_id;

        // TODO Write changes to database

        if (str_contains($_POST["id"], "match")) {
            $event_type = 0;
            $event_id = substr($_POST["id"], 6);
        }
        if (str_contains($_POST["id"], "club_events_")) {
            $event_type = 1;
            $event_id = substr($_POST["id"], 12);
        }

        if ($event_type == 0) {
            $time_period;
            $points0;
            $points1;

            if (strcmp($_POST["time-period-ende"], '') == 0) {
                $time_period = $_POST["time-period-beginn"];
            } else {
                $time_period = "{$_POST["time-period-beginn"]}-{$_POST["time-period-ende"]}";
            }

            if (strcmp($_POST["points0"], '') == 0) {
                $points0 = "NULL";
            } else {
                $points0 = $_POST["points0"];
            }

            if (strcmp($_POST["points1"], '') == 0) {
                $points1 = "NULL";
            } else {
                $points1 = $_POST["points1"];
            }

            $sql = "UPDATE `match`
            SET 
                `Name` = '" . $_POST["name"] . "', 
                `Date` = '" . $_POST["date-year"] . "-" . add0($_POST["date-month"]) . "-" . add0($_POST["date-day"]) . "', 
                `Time_Period` = '$time_period', 
                `Place` = '" . $_POST["place"] . "', 
                `Type` = '" . $_POST["type"] . "', 
                `Club0` = '" . $_POST["clubs0"] . "', 
                `Club1` = '" . $_POST["clubs1"] . "', 
                `Points0` = $points0,
                `Points1` = $points1,
                `Info_Text` = '" . $_POST["info-text"] . "', 
                `Notice` = '" . $_POST["notice"] . "', 
                `Changelog` = CONCAT(`Changelog`,  CHAR(10),  'Bearbeitet von " . $_SESSION['username'] . "')
            WHERE `MatchID` = $event_id";

            getSQLQuery($sql);

            include("src/update_points_table_db.php");

        } elseif ($event_type == 1) {
            $time_period;

            if (strcmp($_POST["time-period-ende"], '') == 0) {
                $time_period = $_POST["time-period-beginn"];
            } else {
                $time_period = "{$_POST["time-period-beginn"]}-{$_POST["time-period-ende"]}";
            }

            $sql = "UPDATE `club_events`
            SET 
                `Name` = '" . $_POST["name"] . "', 
                `Date` = '" . $_POST["date-year"] . "-" . add0($_POST["date-month"]) . "-" . add0($_POST["date-day"]) . "', 
                `Time_Period` = '$time_period', 
                `Place` = '" . $_POST["place"] . "', 
                `Type` = '" . $_POST["type"] . "', 
                `Info_Text` = '" . $_POST["info-text"] . "', 
                `Notice` = '" . $_POST["notice"] . "', 
                `Changelog` = CONCAT(`Changelog`,  CHAR(10),  'Bearbeitet von " . $_SESSION['username'] . "') 
                WHERE `Club_EventID` = $event_id";

            getSQLQuery($sql);
        }

        unset($_POST);
    }
} elseif (isset($_POST["delete-event-submitted"])) {

    $event_type = -1;
    if (str_contains($_POST["id"], "match")) {
        $event_type = 0;
        $event_id = substr($_POST["id"], 6);
    }
    if (str_contains($_POST["id"], "club_events_")) {
        $event_type = 1;
        $event_id = substr($_POST["id"], 12);
    }

    if ($event_type == 0) {
        $sql = "DELETE FROM `match` WHERE `MatchID` = $event_id";
        getSQLQuery($sql);
    }
    if ($event_type == 1) {
        $sql = "DELETE FROM `club_events` WHERE `Club_EventID` = $event_id";
        getSQLQuery($sql);
    }
}
