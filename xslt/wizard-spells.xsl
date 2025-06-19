<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Externe Datenquelle (Spells) laden -->
  <xsl:variable name="data" select="document(/root/external/@href)"/>

  <!-- Hilfsvariable: Zauberstufen 0–9 -->
  <xsl:variable name="spell-levels">
    <level>0</level>
    <level>1</level>
    <level>2</level>
    <level>3</level>
    <level>4</level>
    <level>5</level>
    <level>6</level>
    <level>7</level>
    <level>8</level>
    <level>9</level>
  </xsl:variable>

  <!-- Haupttemplate -->
  <xsl:template match="/root">
    <html>
      <head>
        <title>Zauber des Zaubergelehrten</title>
        <link rel="stylesheet" type="text/css" href="../../css/style.css" />
      </head>
      <body>
        <h1>Zauber des Zaubergelehrten</h1>

        <xsl:for-each select="$spell-levels/level">
          <xsl:variable name="lvl" select="."/>
          <xsl:if test="$data/elements/element[@type='Spell'][contains(concat(' ', normalize-space(supports), ' '), ' Wizard ')][set[@name='level'] = $lvl]">
            <h2>
              <xsl:choose>
                <xsl:when test="$lvl = 0">Zaubertricks</xsl:when>
                <xsl:otherwise>Zaubergrad <xsl:value-of select="$lvl"/></xsl:otherwise>
              </xsl:choose>
            </h2>
            <xsl:for-each select="$data/elements/element[@type='Spell'][contains(concat(' ', normalize-space(supports), ' '), ' Wizard ')][set[@name='level'] = $lvl]">
              <xsl:sort select="@name"/>
              <details>
                <summary><xsl:value-of select="@name"/></summary>
                <div>
                  <p><strong>Grad:</strong> <xsl:value-of select="set[@name='level']"/></p>
                  <p><strong>Schule:</strong> <xsl:value-of select="set[@name='school']"/></p>
                  <p><strong>Reichweite:</strong> <xsl:value-of select="set[@name='range']"/></p>
                  <p><strong>Dauer:</strong> <xsl:value-of select="set[@name='duration']"/></p>
                  <p><strong>Wirkzeit:</strong> <xsl:value-of select="set[@name='time']"/></p>
                  <p><strong>Komponenten:</strong>
                    <xsl:if test="set[@name='hasVerbalComponent']='true'">V</xsl:if>
                    <xsl:if test="set[@name='hasSomaticComponent']='true'">, G</xsl:if>
                    <xsl:if test="set[@name='hasMaterialComponent']='true'">
                      <xsl:text>, M (</xsl:text>
                      <xsl:value-of select="set[@name='materialComponent']"/>
                      <xsl:text>)</xsl:text>
                    </xsl:if>
                  </p>
                  <p><strong>Konzentration:</strong>
                    <xsl:choose>
                      <xsl:when test="set[@name='isConcentration']='true'">Ja</xsl:when>
                      <xsl:otherwise>Nein</xsl:otherwise>
                    </xsl:choose>
                  </p>
                  <div class="description">
                    <xsl:copy-of select="description/*"/>
                  </div>
                </div>
              </details>
            </xsl:for-each>
          </xsl:if>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
