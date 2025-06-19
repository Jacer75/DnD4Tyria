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
        <title>2 Alle Zauber</title>
        <link rel="stylesheet" type="text/css" href="../../css/style.css" />
      </head>
      <body>
        <h1>Alle Zauber</h1>

        <xsl:for-each select="$data/elements/element[@type='Spell']">
          <xsl:sort select="@name"/>
          <details>
            <summary><xsl:value-of select="@name"/></summary>
            <div>
              <p><strong>Grad:</strong> <xsl:value-of select="setters/set[@name='level']"/></p>
              <p><strong>Schule:</strong> <xsl:value-of select="setters/set[@name='school']"/></p>
              <p><strong>Reichweite:</strong> <xsl:value-of select="setters/set[@name='range']"/></p>
              <p><strong>Dauer:</strong> <xsl:value-of select="setters/set[@name='duration']"/></p>
              <p><strong>Wirkzeit:</strong> <xsl:value-of select="setters/set[@name='time']"/></p>
              <p><strong>Komponenten:</strong>
                <xsl:if test="setters/set[@name='hasVerbalComponent']='true'">V</xsl:if>
                <xsl:if test="setters/set[@name='hasSomaticComponent']='true'">, G</xsl:if>
                <xsl:if test="setters/set[@name='hasMaterialComponent']='true'">
                  <xsl:text>, M (</xsl:text>
                  <xsl:value-of select="setters/set[@name='materialComponent']"/>
                  <xsl:text>)</xsl:text>
                </xsl:if>
              </p>
              <p><strong>Konzentration:</strong>
                <xsl:choose>
                  <xsl:when test="setters/set[@name='isConcentration']='true'">Ja</xsl:when>
                  <xsl:otherwise>Nein</xsl:otherwise>
                </xsl:choose>
              </p>
              <div class="description">
                <xsl:copy-of select="description/*"/>
              </div>
            </div>
          </details>
        </xsl:for-each>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
