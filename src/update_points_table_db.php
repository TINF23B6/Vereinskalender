<?php

// reset points_table
$sql = "DELETE FROM `points_table`;";
getSQLQuery($sql);

$table = []; // Initialize the array
$first_year = null;
$last_year = null;

$sql = "SELECT MAX(`Date`) AS `max_date`, MIN(`Date`) AS `min_date`
        FROM `match`";

$result = getSQLQuery($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $min_date = $row["min_date"];
        $max_date = $row["max_date"];
        
        if ($min_date !== null && $max_date !== null) {
            $first_year = substr($min_date, 0, 4);
            $last_year = substr($max_date, 0, 4);
        }
    }
}

// Wenn keine Daten vorhanden sind, initialisieren wir Standardwerte
if ($first_year === null) {
    $first_year = date("Y");
}
if ($last_year === null) {
    $last_year = date("Y");
}

for ($i_year = $first_year; $i_year <= $last_year; $i_year++) {
    $table[strval($i_year)] = [];

    $sql = "SELECT `Club0`, `Club1`, `Points0`, `Points1`
            FROM `match` 
            WHERE LEFT(`Date`, 4) = '$i_year' 
            AND `Points0` IS NOT NULL
            AND `Points1` IS NOT NULL";

    $result = getSQLQuery($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            if (!isset($table[strval($i_year)][$row["Club0"]])) {
                $table[strval($i_year)][$row["Club0"]] = ["win" => 0, "loss" => 0, "draw" => 0, "points" => 0];
            }
            if (!isset($table[strval($i_year)][$row["Club1"]])) {
                $table[strval($i_year)][$row["Club1"]] = ["win" => 0, "loss" => 0, "draw" => 0, "points" => 0];
            }

            if ((int)$row["Points0"] < (int)$row["Points1"]) {
                $table[strval($i_year)][$row["Club0"]]["loss"]++;
                $table[strval($i_year)][$row["Club1"]]["win"]++;
                $table[strval($i_year)][$row["Club1"]]["points"] += 3;
            } else if ((int)$row["Points0"] > (int)$row["Points1"]) {
                $table[strval($i_year)][$row["Club0"]]["win"]++;
                $table[strval($i_year)][$row["Club0"]]["points"] += 3;
                $table[strval($i_year)][$row["Club1"]]["loss"]++;
            } else {
                $table[strval($i_year)][$row["Club0"]]["draw"]++;
                $table[strval($i_year)][$row["Club0"]]["points"] += 1;
                $table[strval($i_year)][$row["Club1"]]["draw"]++;
                $table[strval($i_year)][$row["Club1"]]["points"] += 1;
            }
        }
    }
}

// upload to points Table
$values = [];
foreach ($table as $year => $clubs) {
    foreach ($clubs as $clubName => $clubDetails) {
        $values[] = "('$year', '$clubName', '" . $clubDetails["win"] . "', '" . $clubDetails["draw"] . "', '" . $clubDetails["loss"] . "', '" . $clubDetails["points"] . "')";
    }
}

if (count($values) > 0) {
    $sql = "INSERT INTO `points_table` (`Year`, `Club`, `Win`, `Draw`, `Lost`, `Points`) VALUES " . implode(", ", $values);
    getSQLQuery($sql);
}
?>