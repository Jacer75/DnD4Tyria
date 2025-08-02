<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="import-statblock.xsl"/>
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/">
    <html lang="de">
      <head>
        <meta charset="UTF-8" />
        <title>4 <xsl:value-of select="bestiary/@name"/></title>
        <link rel="stylesheet" href="../../css/style.css" />
        <link rel="stylesheet" href="../../css/statblock.css" />
      </head>
     <body>
        <h1><xsl:value-of select="bestiary/@name"/></h1>

        <h2>Öffentliche Informationen</h2>
        <div>
          <xsl:copy-of select="bestiary/public/*"/>
        </div>

        <details>
          <summary><strong>Spielleiterinformationen</strong></summary>
          <div>
            <xsl:copy-of select="bestiary/gm/*"/>
          </div>
        </details>

        <h2>Statblocks</h2>
        <xsl:apply-templates select="bestiary/statblock"/>

       <xsl:template match="images">
    <div class="image-gallery">
      <xsl:for-each select="image">
        <div class="image-thumbnail">
          <details>
            <summary>
              <img src="{@href}" alt="{@alt}" class="preview-img"/>
            </summary>
            <div class="full-image">
              <img src="{@href}" alt="{@alt}" class="full-img"/>
              <p class="caption"><xsl:value-of select="@caption"/></p>
            </div>
          </details>
        </div>
      </xsl:for-each>
    </div>
</xsl:template>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
