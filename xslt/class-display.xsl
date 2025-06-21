<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="spell-display.xsl"/>

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Haupttemplate -->
  <xsl:template match="/">
    <xsl:variable name="data" select="document(/root/external/@href)"/>
    <xsl:variable name="labels" select="document(/root/external/@href_labels)"/>
    <xsl:variable name="spellList" select="document(/root/external/@href_spells)"/>

    <html>
      <head>
        <title>26 <xsl:value-of select="$data/elements/element/@name"/></title>
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

        <h1><xsl:value-of select="$labels/global/label[@id='class.features']"/></h1>
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
        <h1><xsl:value-of select="$labels/global/label[@id='class.archetypes']"/></h1>
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
                <xsl:for-each select="rules/select[not(@supports = preceding-sibling::select/@supports)]">
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

        <xsl:variable name="spellcasting" select="$data//spellcasting"/>
        <xsl:variable name="baseList" select="substring-before($spellcasting/list, ',')"/>

        <h1><xsl:value-of select="$labels/global/label[@id='class.spells']"/></h1>
        <p>
          BaseList: <xsl:value-of select="$baseList"/> |
          School 1: <xsl:value-of select="$spellcasting/schools/school[1]"/> |
          School 2: <xsl:value-of select="$spellcasting/schools/school[2]"/>
        </p>
        
        <xsl:for-each select="$labels/global/spell-levels/level">
          <xsl:variable name="lvl" select="."/>
          <!--<xsl:variable name="spells" select="$data/elements/element[@type='Spell' and contains(supports, $baseList) and setters/set[@name='level'] = $lvl and (
            not($spellcasting/schools) or 
            $spellcasting/schools/school = setters/set[@name='school'])]"/>-->
          <xsl:variable name="spells" select="$spellList/elements/element[@type='Spell' and contains(supports, $baseList) and setters/set[@name='level'] = $lvl]"/>
          <xsl:if test="count($spells) > 0">
            <xsl:if test="not($spellcasting/schools) or $spellcasting/schools/school = setters/set[@name='school']">
            <h2><xsl:value-of select="@label"/></h2>
            <xsl:for-each select="$spells">
              <xsl:sort select="@name"/>
              <xsl:call-template name="spell-block">
                <xsl:with-param name="spell" select="."/>
              </xsl:call-template>
            </xsl:for-each>
              </xsl:if>
          </xsl:if>
        </xsl:for-each>
        
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
