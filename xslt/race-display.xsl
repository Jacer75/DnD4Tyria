<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">

    <html>
      <head>
        <title>Sylvari – DnD4Tyria</title>
        <style>
          body { font-family: sans-serif; max-width: 800px; margin: auto; line-height: 1.6; padding: 2rem; }
          h1 { color: #2a5; }
          h2 { margin-top: 2rem; }
        </style>
      </head>
      <body>
        <xsl:variable name="data" select="document('../aurora/de/races/d4t-race-sylvari.xml')"/>
        <xsl:apply-templates select="$data/elements/element[@type='Race']"/>
      </body>
    </html>

  </xsl:template>

  <xsl:template match="element[@type='Race']">
    <h1><xsl:value-of select="@name"/></h1>
    <xsl:apply-templates select="description/*"/>
  </xsl:template>

  <!-- Standard HTML-Elemente -->
  <xsl:template match="p|h4|div|span">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Text etc. -->
  <xsl:template match="@*|text()">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>
