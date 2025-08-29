<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <!-- Root-Match -->
  <xsl:template match="/root">
    <html>
      <head>
        <title>DnD4Tyria Feats</title>
        <meta charset="UTF-8"/>
        <style>
          table { border-collapse: collapse; width: 100%; }
          th, td { border: 1px solid #aaa; padding: 4px; vertical-align: top; }
          th { background: #eee; }
        </style>
      </head>
      <body>
        <h1>Feats Übersicht</h1>
        <table>
          <tr>
            <th>Name</th>
            <th>Beschreibung</th>
          </tr>
          <!-- Feats aus externer Datei laden -->
          <xsl:apply-templates select="document(external/@href)//element[@type='Feat']"/>
        </table>
      </body>
    </html>
  </xsl:template>

  <!-- Darstellung eines einzelnen Feats -->
  <xsl:template match="element[@type='Feat']">
    <tr>
      <td><xsl:value-of select="@name"/></td>
      <td>
        <xsl:apply-templates select="description"/>
      </td>
    </tr>
  </xsl:template>

  <!-- Beschreibung darf HTML enthalten -->
  <xsl:template match="description">
    <xsl:value-of select="." disable-output-escaping="yes"/>
  </xsl:template>

</xsl:stylesheet>
