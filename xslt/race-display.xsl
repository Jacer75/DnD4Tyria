<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Haupttemplate -->
  <xsl:template match="/">
    <xsl:variable name="data" select="document(/root/external/@href)"/>
    <xsl:variable name="racename" select="$data/elements/element[@type='Race']/@name"/>
    <!--<xsl:variable name="currentType" select="$data/elements/element/@type"/>-->
    <xsl:variable name="labels" select="document('labels-de.xml')"/>
    <xsl:variable name="breadcrumbLabel" select="$labels/labels/type[@name='Race']/@label"/>
    <xsl:variable name="breadcrumbPath" select="$labels/labels/type[@name='Race']/@path"/>
    <html>
      <head>
        <title><xsl:value-of select="$racename"/> - DnD4Tyria</title>
        <link rel="stylesheet" type="text/css" href="../../css/style.css" />
      </head>
      <body>

<div class="breadcrumbs">
  <a href="/DnD4Tyria/de/index.html">Start</a> &gt;
  <a>
    <xsl:attribute name="href">
      <xsl:text>/DnD4Tyria/de/</xsl:text>
      <xsl:value-of select="translate($breadcrumbLabel, 'ÄÖÜäöüß ', 'AOUaous_')"/>
      <xsl:text>/index.html</xsl:text>
    </xsl:attribute>
    <xsl:value-of select="$breadcrumbLabel"/>
  </a> &gt;
  <span><xsl:value-of select="$racename"/></span>
</div>

        <xsl:apply-templates select="$data/elements/element[@type='Race']"/>
        <xsl:apply-templates select="$data/elements/element[@type='Racial Trait'][not(supports='Race Alignments')]"/>
      </body>
    </html>
  </xsl:template>

  <!-- Template für das Hauptelement der Rasse -->
  <xsl:template match="element[@type='Race']">
    <h1><xsl:value-of select="@name"/></h1>
    <xsl:apply-templates select="description/*[not(self::p[contains(., 'Volksmerkmale.')]) and not(self::p[span[@class='feature']])]"/>
    <div class="traits">
      <xsl:apply-templates select="description/p[span[@class='feature']]"/>
    </div>
  </xsl:template>

  <!-- Template für Rassen-Eigenschaftszeilen -->
  <!--<xsl:template match="p[span[@class='feature']]">
  <xsl:for-each select="span[@class='feature']">
    <div class="trait">
      <span class="trait-label">
        <xsl:value-of select="."/>
      </span>
      <xsl:apply-templates select="following-sibling::span[@class='feature-description'][1]"/>
    </div>
  </xsl:for-each>
</xsl:template>-->
<!-- Template für Rassen-Eigenschaftszeilen als Tabelle -->
<xsl:template match="p[span[@class='feature']]">
  <table class="traits">
    <!--<tr>
      <th>Merkmal</th>
      <th>Beschreibung</th>
    </tr>-->
    <xsl:for-each select="span[@class='feature']">
      <tr>
        <td>
          <xsl:value-of select="."/>
        </td>
        <td>
          <xsl:apply-templates select="following-sibling::span[@class='feature-description'][1]"/>
        </td>
      </tr>
    </xsl:for-each>
  </table>
</xsl:template>
  

  <!-- Template für Rassenmerkmale -->
  <xsl:template match="element[@type='Racial Trait']">
    <h2><xsl:value-of select="@name"/></h2>
    <xsl:apply-templates select="description/*"/>
  </xsl:template>

  <!-- Standard HTML-Elemente übernehmen -->
  <xsl:template match="p|h4|div|span">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Text und Attribute übernehmen -->
  <xsl:template match="@*|text()">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>
