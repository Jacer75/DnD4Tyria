<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Haupttemplate -->
  <xsl:template match="/">
    <xsl:variable name="data" select="document(/root/external/@href)"/>
    <xsl:variable name="labels" select="document(/root/external/@href_labels)"/>

    <html>
      <head>
        <title>4 <xsl:value-of select="$data/elements/element/@name"/></title>
        <link rel="stylesheet" type="text/css" href="../../css/style.css"/>
      </head>
      <body>
        <h1><xsl:value-of select="$data/elements/element/@name"/></h1>

        <div class="description">
          <!-- Nur die direkten Inhalte der Klassenbeschreibung anzeigen -->
          <xsl:for-each select="$data/elements/element[1]/description/node()">
            <xsl:copy-of select="."/>
          </xsl:for-each>
        </div>

        <!-- Zusätzliche Class Features anzeigen, aber keine Skill/Proficiency-Elemente -->
        <xsl:for-each select="$data/elements/element">
          <xsl:if test="@type='Class Feature' and not(contains(@id, 'PROFICIENCY'))">
            <h2><xsl:value-of select="@name"/></h2>
            <div class="feature-description">
              <xsl:copy-of select="description/node()"/>
            </div>
          </xsl:if>
        </xsl:for-each>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
