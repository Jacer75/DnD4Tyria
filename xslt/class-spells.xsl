<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="spell-display.xsl"/>
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <!-- Externe Datenquelle (Spells) laden -->
    <xsl:variable name="data" select="document(/root/external/@href)"/>
    <xsl:variable name="labels" select="document(/root/external[@href_labels]/@href_labels)"/>
    <xsl:variable name="levels" select="$labels/global/spell-levels"/>
    <!-- Haupttemplate -->
    <xsl:param name="className" select="/root/@class"/>
    <xsl:param name="classLabel" select="/root/@label"/>
    <xsl:template match="/root">
        <html>
            <head>
                <title>17 Zauber der Klasse: <xsl:value-of select="$classLabel"/>
                </title>
                <link rel="stylesheet" type="text/css" href="../../css/style.css"/>
            </head>
            <body>
                <h1>Zauber der Klasse: <xsl:value-of select="$classLabel"/>
                </h1>
                <p>Labels geladen: <xsl:value-of select="$labels/spell-levels/level[1]"/></p>
                <xsl:for-each select="$levels/level">
                    <xsl:variable name="lvl" select="."/>
                    <xsl:variable name="spells" select="$data/elements/element[@type='Spell'][contains(supports, $className) and setters/set[@name='level'] = $lvl]"/>
                    <xsl:if test="count($spells) > 0">
                        <h2>
                            <xsl:choose>
                                <xsl:when test="$lvl = 0">Zaubertricks</xsl:when>
                                <xsl:otherwise>Zaubergrad <xsl:value-of select="$lvl"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </h2>
                        <xsl:for-each select="$spells">
                            <xsl:sort select="@name"/>
                            <xsl:call-template name="spell-block">
                                <xsl:with-param name="spell" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
