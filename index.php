<?php
// index.php

// Die header Funktion wird verwendet, um einen HTTP-Header zu senden
// In diesem Fall wird der Location-Header verwendet, um auf home.php weiterzuleiten
header('Location: home.php');

// Sicherstellen, dass kein weiterer Code ausgeführt wird
exit;
?>
