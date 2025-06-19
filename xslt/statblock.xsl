<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <!-- externe Zauberdaten -->
  <!--<xsl:key name="spell-by-id" match="spell" use="@id"/>-->
  <xsl:variable name="spellData" select="document('../aurora/d4t-spells.xml')"/>
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/">
    <html lang="de">
      <head>
        <meta charset="UTF-8" />
        <title>
          <xsl:value-of select="encounter/info/name"/>
        </title>
        <link rel="stylesheet" href="../../css/statblock.css" />
      </head>
      <body>
        <div style="display: flex; flex-wrap: wrap; gap: 1em; justify-content: space-evenly;">
          <xsl:for-each select="encounter/statblock">
            <div class="statblock">
              <div class="statblock-header">
                <xsl:value-of select="@name"/>
              </div>

              <details class="statblock-section">
                <summary>Allgemeines</summary>
                <div><strong>Größe</strong>: <xsl:value-of select="meta/size"/></div>
                <div><strong>Typ</strong>: <xsl:value-of select="meta/type"/></div>
                <div><strong>Ausrichtung</strong>: <xsl:value-of select="meta/alignment"/></div>
                <div><strong>Sprachen</strong>: <xsl:value-of select="meta/languages"/></div>
                <div><strong>HG</strong>: <xsl:value-of select="meta/challenge"/></div>
              </details>

              <div class="statblock-meta statblock-section">
                <div class="statblock-meta-item"><strong>RK</strong>: <xsl:value-of select="meta/ac"/></div>
                <div class="statblock-meta-item"><strong>TP</strong>: <xsl:value-of select="meta/hp"/></div>
                <div class="statblock-meta-item"><strong>Bewegung</strong>: <xsl:value-of select="meta/speed"/></div>
                <div class="statblock-meta-item"><strong>Sinne</strong>: <xsl:value-of select="meta/senses"/></div>
                <div class="statblock-meta-item"><strong>Zauber-SG</strong>: <xsl:value-of select="spellcasting/saveDC"/></div>
                <div class="statblock-meta-item"><strong>Zauberbonus</strong>: <xsl:value-of select="spellcasting/attackBonus"/></div>
              </div>

              <div class="statblock-abilities statblock-section">
                <xsl:for-each select="abilities/ability">
                  <div class="statblock-ability">
                    <strong><xsl:value-of select="@name"/></strong><br/>
                    <xsl:value-of select="@score"/> (<xsl:value-of select="@bonus"/>)
                  </div>
                </xsl:for-each>
              </div>

              <div class="statblock-saves statblock-section" style="text-align: left;">
                <div class="statblock-save">
                  <strong>Rettungswürfe</strong>: 
                  <xsl:for-each select="saves/save">
                    <xsl:if test="position() > 1">, </xsl:if>
                    <xsl:value-of select="@ability"/> <xsl:value-of select="@bonus"/>
                  </xsl:for-each>
                </div>
              </div>

              <div class="statblock-skills statblock-section" style="text-align: left;">
                <div class="statblock-skill">
                  <strong>Fertigkeiten</strong>: 
                  <xsl:for-each select="skills/skill">
                    <xsl:if test="position() > 1">, </xsl:if>
                    <xsl:value-of select="@name"/> <xsl:value-of select="@bonus"/>
                  </xsl:for-each>
                </div>
              </div>

              <details class="statblock-section">
                <summary>Angriffe</summary>
                <xsl:for-each select="attacks/attack">
                  <p>
                    <strong><xsl:value-of select="@name"/>.</strong>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="type"/>,
                    <xsl:text> </xsl:text><xsl:value-of select="bonus"/>,
                    <xsl:text> Reichweite </xsl:text><xsl:value-of select="range"/>,
                    <xsl:text> </xsl:text><xsl:value-of select="target"/>,
                    <xsl:text> </xsl:text><xsl:value-of select="damage"/>
                  </p>
                </xsl:for-each>
              </details>

              <details class="statblock-section">
                <summary>Zauber</summary>
                <div class="statblock-spellcasting">
                  <p><strong>Zauberattribut</strong>: <xsl:value-of select="spellcasting/stat"/></p>

                  <details class="spell-level">
                    <summary>Zaubertricks</summary>
                    <ul>
                      <xsl:for-each select="spellcasting/cantrips/spell">
                        <li>
  <!--<xsl:variable name="ref" select="@id"/>
  <xsl:variable name="entry" select="key('spell-by-id', $ref, $spellData)"/>
  <details>
    <summary><xsl:value-of select="."/></summary>
    <xsl:if test="$entry">
      <p><xsl:value-of select="$entry/description"/></p>
    </xsl:if>
  </details>-->
</li>
                      </xsl:for-each>
                    </ul>
                  </details>

                  <xsl:for-each select="spellcasting/level1">
                    <details class="spell-level">
                      <summary>Zaubergrad 1 (Plätze: <xsl:value-of select="@slots"/>)</summary>
                      <ul>
                        <xsl:for-each select="spell">
                          <li>
  <!--<xsl:variable name="ref" select="@id"/>
  <xsl:variable name="entry" select="key('spell-by-id', $ref, $spellData)"/>

  <details>
    <summary><xsl:value-of select="."/></summary>
    <xsl:if test="$entry">
      <p><xsl:value-of select="$entry/description"/></p>
    </xsl:if>
  </details>-->
</li>
                        </xsl:for-each>
                      </ul>
                    </details>
                  </xsl:for-each>
                </div>
              </details>

              <details class="statblock-section">
                <summary>Aktionen</summary>
                <xsl:for-each select="actions/action">
                  <p><strong><xsl:value-of select="@name"/>.</strong> <xsl:value-of select="description"/></p>
                </xsl:for-each>
              </details>

              <details class="statblock-section">
                <summary>Reaktionen</summary>
                <xsl:for-each select="reactions/reaction">
                  <p><strong><xsl:value-of select="@name"/>.</strong> <xsl:value-of select="description"/></p>
                </xsl:for-each>
              </details>

            </div>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
