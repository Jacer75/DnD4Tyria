<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Externe Datenquelle (Items) laden -->
  <xsl:variable name="data" select="document(/root/external[1]/@href)"/>

  <!-- Haupttemplate -->
  <xsl:template match="/root">
    <html>
      <head>
        <title>Grundnahrungsmittel</title>
        <link rel="stylesheet" type="text/css" href="../../css/style.css" />
      </head>
      <body>
        <h1>Grundnahrungsmittel</h1>

        <table class="list items">
          <thead>
            <tr>
              <th>Name</th>
              <th>Typ</th>
              <th>Grad</th>
              <th>DC</th>
              <th>Region</th>
              <th>Beschreibung</th>
              <th>Kosten</th>
              <th>Gewicht</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="$data/elements/element[@type='Item'][setters/set[@name='category']='Grundnahrungsmittel']">
              <xsl:sort select="number(setters/set[@name='grade'])" data-type="number" order="ascending"/>
              <xsl:sort select="@name" data-type="text" order="ascending"/>

              <tr>
                <td><xsl:value-of select="@name"/></td>

                <td><xsl:value-of select="setters/set[@name='type']"/></td>

                <td><xsl:value-of select="setters/set[@name='grade']"/></td>

                <td><xsl:value-of select="setters/set[@name='dc']"/></td>

                <td><xsl:value-of select="setters/set[@name='region']"/></td>

                <td><xsl:value-of select="description/p[1]"/></td>

                <td>
                  <xsl:value-of select="setters/set[@name='cost']"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="setters/set[@name='cost']/@currency"/>
                </td>

                <td><xsl:value-of select="setters/set[@name='weight']"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
