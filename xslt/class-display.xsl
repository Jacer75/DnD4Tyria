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
        <title>15 <xsl:value-of select="$data/elements/element/@name"/></title>
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
          <xsl:if test="@type='Class Feature' and not(supports)">
            <h2><xsl:value-of select="@name"/></h2>
            <div class="feature-description">
              <xsl:copy-of select="description/node()"/>
            </div>
          </xsl:if>
        </xsl:for-each>

              <!-- Archetypen anzeigen mit einklappbaren Archetype Features -->
        <xsl:for-each select="$data/elements/element[@type='Archetype']">
          <h2><xsl:value-of select="@name"/></h2>
          <div class="archetype-description">
            <xsl:copy-of select="description/node()"/>
          </div>

          <!-- Zugehörige Archetype Features -->
          <xsl:for-each select="rules/grant[@type='Archetype Feature']">
            <xsl:variable name="featureId" select="@id"/>
            <xsl:for-each select="$data/elements/element[@type='Archetype Feature' and @id = $featureId]">
              <details>
                <summary><xsl:value-of select="@name"/></summary>
                <div class="feature-description">
                  <xsl:copy-of select="description/node()"/>
                </div>

                <!-- Erweiterte Auswahl: Alle Elemente mit passendem supports-Wert anzeigen -->
                <xsl:for-each select="rules/select">
                  <xsl:variable name="supportKey" select="@supports"/>
                  <xsl:for-each select="$data/elements/element[@type='Archetype Feature' and supports = $supportKey]">
                    <details>
                      <summary><xsl:value-of select="@name"/></summary>
                      <div class="feature-description">
                        <xsl:copy-of select="description/node()"/>
                      </div>
                    </details>
                  </xsl:for-each>
                </xsl:for-each>
              </details>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
