<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="spell-display.xsl"/>
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Externe Datenquelle (Spells) laden -->
  <xsl:variable name="data" select="document(/root/external/@href)"/>

  <!-- Haupttemplate -->
  <xsl:param name="className" select="/root/@class"/>
  <xsl:param name="classLabel" select="/root/@label"/>

  <xsl:template match="/root">
    <html>
      <head>
        <title>Zauber der Klasse: <xsl:value-of select="$classLabel"/></title>
        <link rel="stylesheet" type="text/css" href="../../css/style.css" />
      </head>
      <body>
        <h1>Zauber der Klasse: <xsl:value-of select="$classLabel"/></h1>

        <xsl:for-each select="$data/elements/element[@type='Spell'][contains(concat(' ', normalize-space(supports), ' '), concat(' ', $className, ' '))]">
          <xsl:sort select="@name"/>
          <xsl:call-template name="spell-block">
            <xsl:with-param name="spell" select="."/>
          </xsl:call-template>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
