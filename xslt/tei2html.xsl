<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" encoding="UTF-8"/>

  <!-- ===============================
       HAUPTSEITE
       =============================== -->
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

        <!-- Klickbox-Script -->
        <script>
          function toggleComment(id) {
            const el = document.getElementById('comment-' + id);
            el.classList.toggle('visible');
          }
        </script>

      </body>
    </html>
  </xsl:template>


  <!-- ===============================
       SEGMENTE MIT KLICKBOXEN
       =============================== -->
  <xsl:template match="tei:seg">
    <xsl:variable name="segId" select="@xml:id"/>
    <xsl:variable name="comment"
      select="//tei:note[
        contains(
          concat(' ', normalize-space(@target), ' '),
          concat(' #', $segId, ' ')
        )
      ]"/>

    <span class="seg" onclick="toggleComment('{$segId}')">
      <xsl:value-of select="."/>

      <span class="comment-box" id="comment-{$segId}">
        <xsl:value-of select="$comment"/>
      </span>
    </span>
    <br/>
  </xsl:template>

</xsl:stylesheet>
