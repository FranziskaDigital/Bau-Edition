<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" encoding="UTF-8"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Zettel</title>
        <link rel="stylesheet" href="css/style.css"/>
      </head>
      <body>

        <div class="container">

          <div class="image">
            <img>
              <xsl:attribute name="src">
                <xsl:value-of select="//tei:graphic/@url"/>
              </xsl:attribute>
            </img>
          </div>

          <div class="text">
            <xsl:apply-templates select="//tei:seg"/>
          </div>

        </div>

      </body>
    </html>
  </xsl:template>

  <xsl:template match="tei:seg">
    <span class="seg">
      <xsl:attribute name="data-comment">
        <xsl:value-of select="//tei:note[@target = concat('#', @xml:id)]"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </span>
    <br/>
  </xsl:template>

</xsl:stylesheet>
