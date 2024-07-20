<?php 

include 'src_homepage/homepage.php';

// Load the XML document
$xml = new DOMDocument();
$xml->load('src_homepage/homepage.xml');

// Load the XSLT stylesheet
$xsl = new DOMDocument();
$xsl->load('src_homepage/homepage.xsl');

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

?>