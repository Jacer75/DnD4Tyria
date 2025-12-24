<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- Optional: nur nötig, wenn du diese Templates wirklich nutzt -->
  <xsl:import href="import-statblock.xsl"/>
  <xsl:import href="import-gallery.xsl"/>

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/">
    <html lang="de">
      <head>
        <meta charset="UTF-8" />
        <title><xsl:value-of select="lore/@title"/></title>

        <!-- Pfad wie bei dir: ggf. an die Ordner-Tiefe anpassen -->
        <link rel="stylesheet" href="/DnD4Tyria/css/style.css" />
        <link rel="stylesheet" href="/DnD4Tyria/css/statblock.css" />
      </head>

      <body>
        <h1><xsl:value-of select="entry/@title"/></h1>

        <!-- Public -->
        <div>
          <xsl:copy-of select="entry/public/*"/>
        </div>

        <!-- GM: nur anzeigen, wenn es Inhalt gibt -->
        <xsl:if test="entry/gm/*">
          <details>
            <summary><strong>Spielleiterinformationen</strong></summary>
            <div>
              <xsl:copy-of select="entry/gm/*"/>
            </div>
          </details>
        </xsl:if>

        <!-- Bilder: nur wenn vorhanden -->
        <xsl:if test="entry/images/*">
          <h2>Bilder</h2>
          <xsl:apply-templates select="entry/images"/>
        </xsl:if>

        <!-- Statblocks: nur wenn vorhanden -->
        <xsl:if test="entry/statblocks/*">
          <h2>Statblocks</h2>
          <xsl:apply-templates select="entry/statblocks/*"/>
        </xsl:if>

      </body>
    </html>
  </xsl:template>

  <!-- Minimaler Fallback für images, falls import-gallery.xsl noch nichts macht -->
  <xsl:template match="images">
    <div class="gallery">
      <xsl:for-each select="image">
        <div class="gallery-item">
          <img>
            <xsl:attribute name="src"><xsl:value-of select="@href"/></xsl:attribute>
            <xsl:attribute name="alt"><xsl:value-of select="@alt"/></xsl:attribute>
          </img>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

</xsl:stylesheet>
