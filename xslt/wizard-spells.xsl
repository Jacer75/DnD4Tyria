<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Haupttemplate -->
  <xsl:template match="/elements">
    <html>
      <head>
        <title>Zauber des Zaubergelehrten</title>
        <link rel="stylesheet" href="../styles.css" />
      </head>
      <body>
        <h1>Zauber des Zaubergelehrten</h1>

        <!-- Gruppierung nach Stufe -->
        <xsl:for-each select="element[@type='Spell'][contains(concat(' ', normalize-space(supports), ' '), ' Wizard ')]">
          <xsl:sort select="set[@name='level']" data-type="number" order="ascending"/>
        </xsl:for-each>

        <!-- Um Levelüberschriften zu erzeugen, benötigen wir eine zweifache Schleife -->
        <xsl:for-each select="0,1,2,3,4,5,6,7,8,9">
          <xsl:variable name="lvl" select="."/>
          <xsl:if test="/elements/element[@type='Spell'][contains(concat(' ', normalize-space(supports), ' '), ' Wizard ')][set[@name='level'] = $lvl]">
            <h2>
              <xsl:choose>
                <xsl:when test="$lvl = 0">Zaubertricks</xsl:when>
                <xsl:otherwise>Zaubergrad <xsl:value-of select="$lvl"/></xsl:otherwise>
              </xsl:choose>
            </h2>
            <xsl:for-each select="/elements/element[@type='Spell'][contains(concat(' ', normalize-space(supports), ' '), ' Wizard ')][set[@name='level'] = $lvl]">
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
