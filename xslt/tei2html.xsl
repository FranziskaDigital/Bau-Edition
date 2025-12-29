<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" encoding="UTF-8"/>

  <!-- Haupttemplate -->
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8" />
        <title>
          <xsl:value-of select="//tei:title"/>
        </title>
        <link rel="stylesheet" href="css/style.css"/>
      </head>
      <body>

        <div class="container">

          <!-- Bild -->
          <div class="image">
            <img>
              <xsl:attribute name="src">
                <xsl:value-of select="//tei:graphic/@url"/>
              </xsl:attribute>
              <xsl:attribute name="alt">
                <xsl:value-of select="//tei:idno"/>
              </xsl:attribute>
            </img>
          </div>

          <!-- Transkription -->
          <div class="text">
            <xsl:apply-templates select="//tei:seg"/>
          </div>

        </div>

      </body>
    </html>
  </xsl:template>

  <!-- Segmente mit Tooltip -->
  <xsl:template match="tei:seg">
    <xsl:variable name="segId" select="@xml:id"/>

    <span class="seg">
      <!-- Kommentartext suchen: note[target enthält #segId] -->
      <xsl:attribute name="data-comment">
        <xsl:value-of
          select="//tei:note[
                    contains(
                      concat(' ', normalize-space(@target), ' '),
                      concat(' #', $segId, ' ')
                    )
                 ]"
        />
      </xsl:attribute>

      <xsl:value-of select="."/>
    </span>
    <br/>
  </xsl:template>

</xsl:stylesheet>
