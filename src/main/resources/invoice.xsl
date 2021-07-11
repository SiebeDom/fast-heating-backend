<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4" page-height="29.7cm" page-width="21.0cm" margin-top="1cm" margin-left="2cm" margin-right="2cm" margin-bottom="1cm">
                    <!-- Page template goes here -->
                    <fo:region-body margin-bottom=".5in" margin-top=".80in"/>
                    <fo:region-before region-name="xsl-region-before" extent="5cm"/>
                    <fo:region-after region-name="xsl-region-after" extent="4cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="A4">
                <!-- Page content goes here -->
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block>
                        <fo:table>
                            <fo:table-column column-width="8.5cm"/>
                            <fo:table-column column-width="8.5cm"/>
                            <fo:table-body>
                                <fo:table-row font-size="18pt" line-height="30px" background-color="#3e73b9" color="white">
                                    <fo:table-cell padding-left="5pt">
                                        <fo:block>
                                            Fast heating
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block text-align="right">
                                            Factuur
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding-left="5pt" padding-top="5pt">
                                        <fo:block>
                                            Fast heating&#x2028;
                                            Europalaan 31 2620 Hemiksem
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block line-height="20pt">
                        <fo:block font-weight="bold">
                            Terms &amp; Conditions
                        </fo:block>
                        <fo:block space-after="15pt">
                            Payment is due within <xsl:value-of select="invoice/terms" />
                        </fo:block>
                        <fo:block>
                            Bank of Toontown&#x2028;
                            Account number: 1234567890
                        </fo:block>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" line-height="20pt">
                    <xsl:apply-templates />
                    <fo:block>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template match="invoice">
        <fo:block space-before="120pt" width="17cm" >
            <fo:table>
                <fo:table-column column-width="5.5cm"/>
                <fo:table-column column-width="5.5cm"/>
                <fo:table-column column-width="3cm"/>
                <fo:table-column column-width="3cm"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <fo:inline font-weight="bold">Bill To</fo:inline>
                                <xsl:call-template name="address">
                                    <xsl:with-param name="address" select="./address[@type='billto']"></xsl:with-param>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <fo:inline font-weight="bold">Ship To</fo:inline>
                                <xsl:call-template name="address">
                                    <xsl:with-param name="address" select="./address[@type='shipto']"></xsl:with-param>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block text-align="right">
                                <fo:inline font-weight="bold">Invoice #</fo:inline>&#x2028;
                                <fo:inline font-weight="bold">Invoice Date</fo:inline>&#x2028;
                                <fo:inline font-weight="bold"> P.O.#</fo:inline>&#x2028;
                                <fo:inline font-weight="bold">Due Date</fo:inline>&#x2028;
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block text-align="right">
                                <xsl:value-of select="./invoicenumber"></xsl:value-of>&#x2028;
                                <xsl:value-of select="./invoicedate"></xsl:value-of>&#x2028;
                                <xsl:value-of select="./purchaseordernumber"></xsl:value-of>&#x2028;
                                <xsl:value-of select="./duedate"></xsl:value-of>&#x2028;
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block space-before="35pt">
            <fo:table line-height="30px">
                <fo:table-column column-width="2cm"/>
                <fo:table-column column-width="8cm"/>
                <fo:table-column column-width="3.5cm"/>
                <fo:table-column column-width="3.5cm"/>
                <fo:table-header>
                    <fo:table-row background-color="#f5f5f5" text-align="center" font-weight="bold">
                        <fo:table-cell border="1px solid #b8b6b6">
                            <fo:block>QTY</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1px solid #b8b6b6">
                            <fo:block>DESCRIPTION</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1px solid #b8b6b6">
                            <fo:block>UNIT PRICE</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1px solid #b8b6b6">
                            <fo:block>AMOUNT</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:apply-templates select="lineitems/lineitem"></xsl:apply-templates>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="3" text-align="right" padding-right="3pt">
                            <fo:block>Subtotal</fo:block>
                        </fo:table-cell>
                        <fo:table-cell  text-align="right" padding-right="3pt" border-left="1px solid #b8b6b6" border-right="1px solid #b8b6b6" >
                            <fo:block>
                                <xsl:value-of select="subtotal" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="3" text-align="right" padding-right="3pt">
                            <fo:block>Sales tax 5%</fo:block>
                        </fo:table-cell>
                        <fo:table-cell  text-align="right" padding-right="3pt" border-left="1px solid #b8b6b6" border-right="1px solid #b8b6b6" >
                            <fo:block>
                                <xsl:value-of select="tax" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-weight="bold">
                        <fo:table-cell number-columns-spanned="3" text-align="right" padding-right="3pt">
                            <fo:block>Total</fo:block>
                        </fo:table-cell>
                        <fo:table-cell  text-align="right" padding-right="3pt" background-color="#f5f5f5" border="1px solid #b8b6b6" >
                            <fo:block>
                                <xsl:value-of select="total" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    <xsl:template name="address">
        <xsl:param name="address"></xsl:param>
        <fo:block>
            <xsl:value-of select="$address/name" />&#x2028;
            <xsl:value-of select="$address/street" />&#x2028;
            <xsl:value-of select="$address/zipcode" />&#160;<xsl:value-of select="$address/city" />
        </fo:block>
    </xsl:template>
    <xsl:template match="lineitem">
        <fo:table-row>
            <fo:table-cell border="1px solid #b8b6b6" text-align="center">
                <fo:block>
                    <xsl:value-of select="quantity"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border="1px solid #b8b6b6" padding-left="3pt">
                <fo:block>
                    <xsl:value-of select="description"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border="1px solid #b8b6b6" text-align="right" padding-right="3pt">
                <fo:block>
                    <xsl:value-of select="unitprice"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border="1px solid #b8b6b6" text-align="right" padding-right="3pt">
                <fo:block>
                    <xsl:value-of select="amount"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>

    </xsl:template>
</xsl:stylesheet>