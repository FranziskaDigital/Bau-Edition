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
        <meta charset="UTF-8"/>
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

            <!-- Bestandsnummer (ZB 140) -->
            <div class="shelfmark">
              <xsl:value-of select="//tei:idno[@type='shelfmark']"/>
            </div>

            <!-- gesamter Textkörper -->
            <xsl:apply-templates select="//tei:body"/>

          </div>

        </div>

        <!-- Klickbox-Skripte -->
        <script>
          function toggleComment(id) {
            const el = document.getElementById('comment-' + id);
            el.classList.toggle('visible');
          }

          function togglePerson(id) {
            const el = document.getElementById('person-' + id);
            el.classList.toggle('visible');
          }

          function toggleBibl(id) {
            const el = document.getElementById('bibl-' + id);
            el.classList.toggle('visible');
          }
        </script>

      </body>
    </html>
  </xsl:template>



  <!-- ===============================
       STRUKTUR: body / p / ab / lb
       =============================== -->

  <xsl:template match="tei:body">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:p | tei:ab">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>



  <!-- ===============================
       FORMATIERUNGEN
       =============================== -->

  <!-- Unterstreichen -->
  <xsl:template match="tei:hi[@rend='underline']">
    <span style="text-decoration: underline;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Signaturzeile -->
  <xsl:template match="tei:signed">
    <span class="signed-line">
      <xsl:apply-templates/>
    </span>
    <br/>
  </xsl:template>



  <!-- ===============================
       SEGMENTE MIT KOMMENTARBOX
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
      <xsl:apply-templates/>

      <span class="comment-box" id="comment-{$segId}">
        <xsl:value-of select="$comment"/>
      </span>
    </span>
    <br/>
  </xsl:template>



  <!-- ===============================
       LITERATUR — INFOBOX RECHTS
       =============================== -->
  <xsl:template match="tei:biblStruct">
    <xsl:variable name="bid" select="@xml:id"/>

    <div class="bibl" onclick="toggleBibl('{$bid}')">
      <xsl:apply-templates/>

      <div class="bibl-box" id="bibl-{$bid}">
        <strong>Publikation:</strong><br/>
        <xsl:apply-templates select="." mode="clean"/>

        <br/><br/>
        <a href="{@corresp}" target="_blank">Zur Veröffentlichung (DOI)</a>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="tei:biblStruct" mode="clean">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>



  <!-- ===============================
       PERSONEN — POPUP MIT GND
       =============================== -->
  <xsl:template match="tei:persName">
    <xsl:variable name="pid" select="@xml:id"/>

    <span class="person" onclick="togglePerson('{$pid}')">
      <xsl:apply-templates/>

      <span class="person-box" id="person-{$pid}">
        Zorll, Ulrich —
        <a href="{@ref}" target="_blank">GND-Datensatz</a>
      </span>
    </span>
  </xsl:template>

</xsl:stylesheet>
