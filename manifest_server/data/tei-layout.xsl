<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <title>
          <xsl:value-of select="normalize-space(//tei:titleStmt/tei:title)"/>
        </title>
        <style>
          body {
            margin: 2rem auto;
            max-width: 62rem;
            padding: 0 1rem;
            line-height: 1.6;
            font-family: "Georgia", "Times New Roman", serif;
            color: #1f1f1f;
            background: #fcfcfa;
          }
          .header {
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid #d5d5d5;
          }
          .header h1 {
            margin: 0 0 0.25rem 0;
            font-size: 1.3rem;
          }
          .msid {
            color: #555;
            font-size: 0.95rem;
          }
          .ab {
            white-space: normal;
          }
          .pb {
            display: block;
            margin: 1.2rem 0 0.25rem 0;
            padding-top: 0.8rem;
            border-top: 1px solid #e4e4e4;
            color: #666;
            font-size: 0.9rem;
          }
          .cb {
            display: inline-block;
            margin-right: 0.5rem;
            color: #7a7a7a;
            font-size: 0.9rem;
          }
          .lb {
            color: #9a9a9a;
            font-size: 0.8rem;
            margin-right: 0.35rem;
            user-select: none;
          }
          .milestone {
            color: #7c5f00;
            font-size: 0.85rem;
            margin: 0 0.35rem;
          }
          .note {
            color: #4f4f4f;
            background: #f3f3f0;
            border: 1px solid #e3e3de;
            padding: 0 0.2rem;
            border-radius: 0.2rem;
            font-size: 0.9em;
          }
          .title-inline {
            display: block;
            margin: 0.4rem 0 0.6rem 0;
            font-weight: bold;
          }
          .abbr {
            letter-spacing: 0.02em;
          }
        </style>
      </head>
      <body>
        <div class="header">
          <h1><xsl:value-of select="normalize-space(//tei:titleStmt/tei:title)"/></h1>
          <div class="msid">
            <xsl:text>MS: </xsl:text>
            <xsl:value-of select="normalize-space(//tei:msIdentifier/tei:idno)"/>
          </div>
        </div>
        <div class="edition">
          <xsl:apply-templates select="//tei:text/tei:body"/>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="tei:body|tei:div|tei:p">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="tei:ab">
    <div class="ab">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="tei:title">
    <span class="title-inline">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:pb">
    <span class="pb">
      <xsl:text>[f. </xsl:text>
      <xsl:value-of select="@n"/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="tei:cb">
    <span class="cb">
      <xsl:text>[col. </xsl:text>
      <xsl:value-of select="@n"/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="tei:lb">
    <br/>
    <span class="lb">
      <xsl:text>l.</xsl:text>
      <xsl:value-of select="@n"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='episode']">
    <span class="milestone">
      <xsl:text>{ep. </xsl:text>
      <xsl:value-of select="@n"/>
      <xsl:text>}</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="tei:abbr">
    <span class="abbr">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:note">
    <span class="note">
      <xsl:text>[note: </xsl:text>
      <xsl:apply-templates/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="tei:change|tei:teiHeader|tei:encodingDesc"/>

  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
