<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Externe Datenquelle (Spells) laden -->
  <xsl:variable name="data" select="document(/root/external/@href)"/>

  <!-- Haupttemplate -->
  <xsl:template match="/root">
    <html>
      <head>
        <title>Alle Zauber</title>
        <link rel="stylesheet" type="text/css" href="../../css/style.css" />
      </head>
      <body>
        <h1>Alle Zauber</h1>

        <xsl:for-each select="$data/elements/element[@type='Spell']">
          <xsl:sort select="@name"/>
          <details>
            <summary><xsl:value-of select="@name"/></summary>
            <table class="spell-details">
              <tr><th>Grad</th><td><xsl:value-of select="setters/set[@name='level']"/></td></tr>
              <tr><th>Schule</th><td><xsl:value-of select="setters/set[@name='school']"/></td></tr>
              <tr><th>Reichweite</th><td><xsl:value-of select="setters/set[@name='range']"/></td></tr>
              <tr><th>Dauer</th><td><xsl:value-of select="setters/set[@name='duration']"/></td></tr>
              <tr><th>Wirkzeit</th><td><xsl:value-of select="setters/set[@name='time']"/></td></tr>
              <tr><th>Komponenten</th>
                <td>
                  <xsl:if test="setters/set[@name='hasVerbalComponent']='true'">Verbal</br></xsl:if>
                  <xsl:if test="setters/set[@name='hasSomaticComponent']='true'">Geste</br></xsl:if>
                  <xsl:if test="setters/set[@name='hasMaterialComponent']='true'">
                    <xsl:text>Material: (</xsl:text>
                    <xsl:value-of select="setters/set[@name='materialComponent']"/>
                    <xsl:text>)</xsl:text>
                  </xsl:if>
                </td>
              </tr>
              <tr><th>Konzentration</th>
                <td>
                  <xsl:choose>
                    <xsl:when test="setters/set[@name='isConcentration']='true'">Ja</xsl:when>
                    <xsl:otherwise>Nein</xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </table>
            <div class="description" style="margin-top: 0.5em; font-size: 0.95em;">
              <xsl:copy-of select="description/*"/>
            </div>
          </details>
        </xsl:for-each>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
