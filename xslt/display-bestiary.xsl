<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="import-statblock.xsl"/>
  <xsl:import href="import-gallery.xsl"/>
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

        <div>
          <xsl:copy-of select="bestiary/public/*"/>
        </div>

        <details>
          <summary><strong>Spielleiterinformationen</strong></summary>
          <div>
            <xsl:copy-of select="bestiary/gm/*"/>
          </div>
        </details>

        <h2>Bilder</h2>
        <xsl:apply-templates select="bestiary/images"/>
       
        <h2>Statblocks</h2>
        <xsl:apply-templates select="bestiary/statblock"/>

        
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
