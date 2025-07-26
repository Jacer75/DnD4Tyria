<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="import-statblock.xsl"/>
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/">
    <html lang="de">
      <head>
        <meta charset="UTF-8" />
        <title><xsl:value-of select="bestiary/@name"/></title>
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
      </body>
    </html>
  </xsl:template>

  <xsl:template match="statblock">
    <!-- Der folgende Block stammt aus statblock.xsl -->
    <div class="statblock">
      <div class="statblock-header"><xsl:value-of select="@name"/></div>
      <!-- Du kannst hier die Kopie aus statblock.xsl einfügen oder modular aufrufen -->
    </div>
  </xsl:template>
</html>
</xsl:stylesheet>
