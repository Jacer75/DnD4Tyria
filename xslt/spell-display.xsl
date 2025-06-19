<xsl:template name="spell-block">
  <xsl:param name="spell"/>

  <details>
    <summary><xsl:value-of select="$spell/@name"/></summary>
    <table class="spell-details">
      <tr><th>Grad</th><td><xsl:value-of select="$spell/setters/set[@name='level']"/></td></tr>
      <tr><th>Schule</th><td><xsl:value-of select="$spell/setters/set[@name='school']"/></td></tr>
      <tr><th>Reichweite</th><td><xsl:value-of select="$spell/setters/set[@name='range']"/></td></tr>
      <tr><th>Dauer</th><td><xsl:value-of select="$spell/setters/set[@name='duration']"/></td></tr>
      <tr><th>Wirkzeit</th><td><xsl:value-of select="$spell/setters/set[@name='time']"/></td></tr>
      <tr><th>Komponenten</th>
        <td>
          <xsl:if test="$spell/setters/set[@name='hasVerbalComponent']='true'">Verbal<br/></xsl:if>
          <xsl:if test="$spell/setters/set[@name='hasSomaticComponent']='true'">Geste<br/></xsl:if>
          <xsl:if test="$spell/setters/set[@name='hasMaterialComponent']='true'">
            <xsl:text>Material: (</xsl:text>
            <xsl:value-of select="$spell/setters/set[@name='materialComponent']"/>
            <xsl:text>)</xsl:text>
          </xsl:if>
        </td>
      </tr>
      <tr><th>Konzentration</th>
        <td>
          <xsl:choose>
            <xsl:when test="$spell/setters/set[@name='isConcentration']='true'">Ja</xsl:when>
            <xsl:otherwise>Nein</xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
    </table>
    <div class="description" style="margin-top: 0.5em; font-size: 0.95em;">
      <xsl:copy-of select="$spell/description/*"/>
    </div>
  </details>
</xsl:template>
