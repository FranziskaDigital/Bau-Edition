<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" encoding="UTF-8"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Zettelkatalog</title>
      </head>
      <body>
        <h1>Zettelkatalog</h1>
        <ul>
          <li>
            <strong>
              <xsl:value-of select="//tei:classCode"/>
            </strong> –
            <a href="zettel_00008.html">Zettel 00008</a>
          </li>
          <!-- in Vorbereitung -->
          <li><strong>Kasten 2</strong> – <span class="in-progress">(in Vorbereitung)</span></li>
          <li><strong>Kasten 3</strong> – <span class="in-progress">(in Vorbereitung)</span></li>
          <li><strong>Kasten 4</strong> – <span class="in-progress">(in Vorbereitung)</span></li>
        </ul>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
