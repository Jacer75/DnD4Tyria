<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="spell-display.xsl"/>
  <!-- externe Zauberdaten -->

  <xsl:template match="render-statblock">
    <xsl:param name="node">
      <xsl:variable name="spellData" select="document('../de/aurora/d4t-spells.xml')"/>
        <div style="display: flex; flex-wrap: wrap; gap: 1em; justify-content: space-evenly;">
          <xsl:for-each select="$node">
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
                <!--<div class="statblock-meta-item"><strong>Sinne</strong>: <xsl:value-of select="meta/senses"/></div>-->
                <xsl:if test="spellcasting">
                  <div class="statblock-meta-item"><strong>Zauberattr</strong>: <xsl:value-of select="spellcasting/stat"/></div>
                  <div class="statblock-meta-item"><strong>Zauber-SG</strong>: <xsl:value-of select="spellcasting/saveDC"/></div>
                  <div class="statblock-meta-item"><strong>Zauberbonus</strong>: <xsl:value-of select="spellcasting/attackBonus"/></div>
                </xsl:if>
              </div>

              <div class="statblock-abilities statblock-section">
                <xsl:for-each select="abilities/ability">
                  <div class="statblock-ability">
                    <strong><xsl:value-of select="@name"/></strong><br/>
                    <xsl:value-of select="@score"/> (<xsl:value-of select="@bonus"/>)
                  </div>
                </xsl:for-each>
              </div>

              <!-- Senses -->
              <div class="statblock-saves statblock-section" style="text-align: left;">
                <div class="statblock-save">
                  <strong>Sinne</strong>: <xsl:value-of select="meta/senses"/>
                </div>
              </div>

              <!-- Resistance -->
              <div class="statblock-saves statblock-section" style="text-align: left;">
                <div class="statblock-save">
                  <strong>Resistent</strong>: <xsl:value-of select="meta/resistances"/>
                </div>
              </div>

              <!-- Immunitäten gegen Schaden -->
              <div class="statblock-saves statblock-section" style="text-align: left;">
                <div class="statblock-save">
                  <strong>Immun (Schaden)</strong>: <xsl:value-of select="meta/immunities"/>
                </div>
              </div>

              <!-- Immunitäten gegen Zustände -->
              <div class="statblock-saves statblock-section" style="text-align: left;">
                <div class="statblock-save">
                  <strong>Immun (Zustand)</strong>: <xsl:value-of select="meta/conditionImmunities"/>
                </div>
              </div>

              <!-- Saves -->
              <div class="statblock-saves statblock-section" style="text-align: left;">
                <div class="statblock-save">
                  <strong>Rettungswürfe</strong>: 
                  <xsl:for-each select="saves/save">
                    <xsl:if test="position() > 1">, </xsl:if>
                    <xsl:value-of select="@ability"/> <xsl:value-of select="@bonus"/>
                  </xsl:for-each>
                </div>
              </div>

              <!-- Skills -->
              <div class="statblock-skills statblock-section" style="text-align: left;">
                <div class="statblock-skill">
                  <strong>Fertigkeiten</strong>: 
                  <xsl:for-each select="skills/skill">
                    <xsl:if test="position() > 1">, </xsl:if>
                    <xsl:value-of select="@name"/> <xsl:value-of select="@bonus"/>
                  </xsl:for-each>
                </div>
              </div>

              <!-- Traits -->
              <details class="statblock-section">
                <summary>Eigenschaften</summary>
                <xsl:for-each select="traits/trait">
                  <p>
                    <p><strong><xsl:value-of select="@name"/>.</strong> <xsl:value-of select="description"/></p>
                  </p>
                </xsl:for-each>
              </details>

              
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

              <xsl:if test="spellcasting">
                <details class="statblock-section">
                  <summary>Zauber</summary>
                  <xsl:for-each select="spellcasting/spelllist/spell[not(@level = preceding-sibling::spell/@level)]">
                    <xsl:variable name="lvl" select="@level"/>
                    <xsl:variable name="slots" select="../../slots/slot[@level=$lvl]/@count"/>
                    <details class="spell-level">
                      <summary>
                        <xsl:choose>
                          <xsl:when test="$lvl = 0">Zaubertricks</xsl:when>
                          <xsl:otherwise>Zaubergrad <xsl:value-of select="$lvl"/>
                            <xsl:if test="$slots"> (Plätze: <xsl:value-of select="$slots"/>)</xsl:if>
                          </xsl:otherwise>
                        </xsl:choose>
                      </summary>
                        <xsl:for-each select="../../spelllist/spell[@level=$lvl]">
                          <xsl:variable name="ref" select="@id"/>
                          <xsl:variable name="entry" select="$spellData/elements/element[@id=$ref]"/>
                            <xsl:call-template name="spell-block">
                              <xsl:with-param name="spell" select="$entry"/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </details>
                  </xsl:for-each>
                </details>
              </xsl:if>

              <xsl:if test="actions">
                <details class="statblock-section">
                  <summary>Aktionen</summary>
                  <xsl:for-each select="actions/action">
                    <p><strong><xsl:value-of select="@name"/>.</strong> <xsl:value-of select="description"/></p>
                  </xsl:for-each>
                </details>
              </xsl:if>

              <xsl:if test="reactions">
                <details class="statblock-section">
                  <summary>Reaktionen</summary>
                  <xsl:for-each select="reactions/reaction">
                    <p><strong><xsl:value-of select="@name"/>.</strong> <xsl:value-of select="description"/></p>
                  </xsl:for-each>
                </details>
              </xsl:if>
            </div>
          </xsl:for-each>
        </div>
    </xsl:param>
  </xsl:template>
</xsl:stylesheet>
