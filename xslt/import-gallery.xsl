<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


<xsl:template match="images">
    <div class="image-gallery">
      <xsl:for-each select="image">
        <div class="image-thumbnail">
          <details>
            <summary>
              <img src="{@href}" alt="{@alt}" class="preview-img"/>
            </summary>
            <div class="full-image">
              <img src="{@href}" alt="{@alt}" class="full-img"/>
              <p class="caption"><xsl:value-of select="@caption"/></p>
            </div>
          </details>
        </div>
      </xsl:for-each>
    </div>
</xsl:template>
