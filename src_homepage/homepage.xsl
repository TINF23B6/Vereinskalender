<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"></xsl:output>
    <xsl:template match="/">
        <html lang="de">
            <head>
                <meta name="viewport" content="initial-scale=1, width=device-width" />

                <link rel="stylesheet" type="text/css" href="src_homepage/homepage.css" />
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto" />

                <title>Homepage</title>
            </head>
            <body>
                <nav class="navigation">
                    <ul>
                        <li class="active">
                            <a href="">Home</a>
                        </li>
                        <li>
                            <a href="">Klub</a>
                        </li>
                        <li>
                            <a href="">Neues &amp; Medien</a>
                        </li>
                        <li>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="homepage/calendar_path"></xsl:value-of>
                                </xsl:attribute>
                                Veranstaltungen
                            </a>
                        </li>
                        <li>
                            <a href="">Kontakt</a>
                        </li>
                        <li class="login">
                            <a href="">Login</a>
                        </li>
                    </ul>
                    <!-- <div class="part2">
                        <a class="login" href="">Login</a>
                    </div>
                -->
                </nav>

                <div class="body">

                    <div class="introduction">
                        <h1>Wer ist Acclaimed Gamers?</h1>
                        <p>
                        Die Geschichte dieses Vereins reicht fast 70 Jahre zurück. Dennis Schläger gründete den Klub damals in der Hoffnung, ihn auf internationales Niveau zu bringen. 
                        Mit nur 24 Jahren kämpfte er selbst auf dem Spielfeld, um dieses Ziel zu erreichen. Tatsächlich gelang es ihm und seinem Team, in die Premier League aufzusteigen und um europäische Plätze zu kämpfen. 
                        Trotz aller Anstrengungen konnte sich der Verein, nachdem Dennis Schläger bereits seine Fußballkarriere beendet hatte, nicht im oberen Tabellendrittel halten und stieg schließlich in die zweite Liga ab. 
                        Derzeit setzen wir alles daran, wieder aufzusteigen und den Top-Teams der Liga Konkurrenz zu machen.
                        </p>
                    </div>

                    <div class="infoCardContainer">
                        <div class="infoBox left">
                            <button type="button" class="button1">
                                <xsl:attribute name="onclick">
                                    <xsl:text>window.location.href = '</xsl:text>
                                    <xsl:value-of select="homepage/calendar_path"></xsl:value-of>
                                    <xsl:text>'</xsl:text>
                                </xsl:attribute>                             
                            Kalender
                            </button>
                            <p class="infoText">
                            Hier finden Sie unsere kommenden Veranstaltungen, sowie vergangene!
                            </p>
                        </div>
                        <div class="infoBox">
                            <button type="button" class="button2">Tickets</button>
                            <p class="infoText">
                            Sie möchten einem Spiel beiwohnen und eine aufregende Zeit genießen?<br></br>
                            Holen Sie sich hier Tickets für die nächsten Spiele!
                            </p>
                        </div>
                        <div class="infoBox right">
                            <button type="button" class="button3">Fan Shop</button>
                            <p class="infoText"> 
                            Sie mögen diesen Verein und/oder möchten uns unterstützen?<br></br>
                            Dann kommen Sie in unseren Shop und schauen sich unsere Angebote an!
                            </p>
                        </div>
                    </div>
                </div>
            </body>
            <script>
                // set em according to window width for responsive design
    	        var windowWidth = window.innerWidth; // initial programmed for 1280px
                fontSize = windowWidth / 1280;
                document.body.style.fontSize = fontSize + 'em';
            </script>
        </html>
    </xsl:template>
</xsl:stylesheet>