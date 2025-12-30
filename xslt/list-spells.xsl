<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <!-- Helper: Setterwert holen -->
  <xsl:template name="get-set">
    <xsl:param name="node"/>
    <xsl:param name="name"/>
    <xsl:value-of select="$node/setters/set[@name=$name]"/>
  </xsl:template>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>DnD4Tyria – Spell Tag Report</title>
        <style>
          body { font-family: system-ui, Arial, sans-serif; padding: 16px; }
          table { border-collapse: collapse; width: 100%; }
          th, td { border: 1px solid #ccc; padding: 6px 8px; vertical-align: top; }
          th { position: sticky; top: 0; background: #f6f6f6; }
          .warn { background: #fff3cd; } /* gelb */
          .bad  { background: #f8d7da; } /* rot */
          .mono { font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace; }
          .small { font-size: 12px; color: #555; }
        </style>
      </head>
      <body>
        <h1>Spell Tag Report</h1>
        <p class="small">
          Quelle: spells.xml – Liste aller Spells und ihrer Setter. Markiert fehlende Pflichtwerte.
        </p>

        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th class="mono">id</th>
              <th>supports</th>
              <th>level</th>
              <th>school</th>
              <th>keywords</th>
              <th>time</th>
              <th>range</th>
              <th>duration</th>
              <th>V</th>
              <th>S</th>
              <th>M</th>
              <th>material</th>
              <th>conc</th>
              <th>ritual</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="//element[@type='Spell']">
              <!-- Sortierung: Level, dann Name -->
              <xsl:sort select="number(setters/set[@name='level'])" data-type="number" order="ascending"/>
              <xsl:sort select="@name" data-type="text" order="ascending"/>

              <xsl:variable name="lvl" select="setters/set[@name='level']"/>
              <xsl:variable name="school" select="setters/set[@name='school']"/>
              <xsl:variable name="time" select="setters/set[@name='time']"/>
              <xsl:variable name="range" select="setters/set[@name='range']"/>
              <xsl:variable name="duration" select="setters/set[@name='duration']"/>

              <tr>
                <td><xsl:value-of select="@name"/></td>
                <td class="mono"><xsl:value-of select="@id"/></td>
                <td><xsl:value-of select="supports"/></td>

                <!-- Pflichtfelder mit Warn-Markierung -->
                <td>
                  <xsl:attribute name="class">
                    <xsl:if test="not($lvl) or string-length(normalize-space($lvl))=0">bad</xsl:if>
                  </xsl:attribute>
                  <xsl:value-of select="$lvl"/>
                </td>

                <td>
                  <xsl:attribute name="class">
                    <xsl:if test="not($school) or string-length(normalize-space($school))=0">bad</xsl:if>
                  </xsl:attribute>
                  <xsl:value-of select="$school"/>
                </td>

                <td>
                  <xsl:attribute name="class">
                    <xsl:if test="not(setters/set[@name='keywords'])">warn</xsl:if>
                  </xsl:attribute>
                  <xsl:value-of select="setters/set[@name='keywords']"/>
                </td>

                <td>
                  <xsl:attribute name="class">
                    <xsl:if test="not($time) or string-length(normalize-space($time))=0">bad</xsl:if>
                  </xsl:attribute>
                  <xsl:value-of select="$time"/>
                </td>

                <td>
                  <xsl:attribute name="class">
                    <xsl:if test="not($range) or string-length(normalize-space($range))=0">bad</xsl:if>
                  </xsl:attribute>
                  <xsl:value-of select="$range"/>
                </td>

                <td>
                  <xsl:attribute name="class">
                    <xsl:if test="not($duration) or string-length(normalize-space($duration))=0">bad</xsl:if>
                  </xsl:attribute>
                  <xsl:value-of select="$duration"/>
                </td>

                <!-- Components -->
                <td class="mono"><xsl:value-of select="setters/set[@name='hasVerbalComponent']"/></td>
                <td class="mono"><xsl:value-of select="setters/set[@name='hasSomaticComponent']"/></td>
                <td class="mono"><xsl:value-of select="setters/set[@name='hasMaterialComponent']"/></td>

                <td>
                  <xsl:attribute name="class">
                    <xsl:if test="setters/set[@name='hasMaterialComponent']='true' and string-length(normalize-space(setters/set[@name='materialComponent']))=0">warn</xsl:if>
                  </xsl:attribute>
                  <xsl:value-of select="setters/set[@name='materialComponent']"/>
                </td>

                <td class="mono"><xsl:value-of select="setters/set[@name='isConcentration']"/></td>
                <td class="mono"><xsl:value-of select="setters/set[@name='isRitual']"/></td>
              </tr>

            </xsl:for-each>
          </tbody>
        </table>

        <h2>Quick Checks</h2>
        <ul>
          <li>Zauber ohne <span class="mono">keywords</span> sind gelb markiert.</li>
          <li>Pflichtfelder (level, school, time, range, duration) fehlen → rot.</li>
          <li><span class="mono">hasMaterialComponent=true</span> aber kein <span class="mono">materialComponent</span> → gelb.</li>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
