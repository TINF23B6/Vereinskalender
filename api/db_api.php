<?php

function connectDB() {
    $servername = getenv('DB_SERVER') ?: "localhost";
    $username = getenv('DB_USERNAME') ?: "root";
    $password = getenv('DB_PASSWORD') ?: "";
    $dbname = getenv('DB_NAME') ?: "vereinskalender";
    $port = getenv('DB_PORT') ?: 3306;  // Default port for MySQL

    // Create connection
    $conn = new mysqli($servername, $username, $password, "", $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Check if database exists, if not create it
    if (!databaseExists($conn, $dbname)) {
        if (!$conn->query("CREATE DATABASE $dbname")) {
            die("Database creation failed: " . $conn->error);
        }
    }

    // Select the database
    $conn->select_db($dbname);
    return $conn;
}

function databaseExists($conn, $dbname) {
    $sql = "SHOW DATABASES LIKE '$dbname'";
    $result = $conn->query($sql);
    return $result->num_rows > 0;
}

function checkIfTablesExist($conn) {
    $sql = "SHOW TABLES";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        // Tables exist
        return true;
    } else {
        // No tables exist
        return false;
    }
}

function executeSQLFromFile($filePath, $conn) {
    $sql = file_get_contents($filePath);
    if ($sql === false) {
        die("Unable to load SQL file: $filePath");
    }

    if (!$conn->multi_query($sql)) {
        die("Multi query failed: " . $conn->error);
    }

    do {
        if ($result = $conn->store_result()) {
            $result->free();
        }
    } while ($conn->next_result());
}

function getSQLQuery($sql){
    $conn = connectDB();
    // Check if any tables exist, if not, load and execute SQL from file
    if (!checkIfTablesExist($conn)) {
        executeSQLFromFile("db/vereinskalender.sql", $conn);
    }
    $result = $conn->query($sql);
    $conn->close();
    return $result;
}

?>