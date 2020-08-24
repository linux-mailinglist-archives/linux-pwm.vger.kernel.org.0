Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4570324F2DD
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgHXG6R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 02:58:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48127 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHXG6N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 02:58:13 -0400
Received: from [2001:67c:670:100:1d::c0] (helo=ptx.hi.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kA6Qc-00039e-ED; Mon, 24 Aug 2020 08:58:02 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kA6Qb-0006nF-2p; Mon, 24 Aug 2020 08:58:01 +0200
Date:   Mon, 24 Aug 2020 08:58:01 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: Re: [PATCH 02/22] dt-bindings: gpio: fsl-imx-gpio: Add gpio-ranges
 property
Message-ID: <20200824065801.GH13023@pengutronix.de>
References: <20200823161550.3981-1-krzk@kernel.org>
 <20200823161550.3981-2-krzk@kernel.org>
 <20200824052446.GE13023@pengutronix.de>
 <20200824063806.GA2497@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824063806.GA2497@kozik-lap>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:53:51 up 186 days, 14:24, 148 users,  load average: 0.09, 0.16,
 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 08:38:06AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Aug 24, 2020 at 07:24:46AM +0200, Sascha Hauer wrote:
> > On Sun, Aug 23, 2020 at 06:15:30PM +0200, Krzysztof Kozlowski wrote:
> > > The GPIO controller node can have gpio-ranges property.  This fixes
> > > dtbs_check warnings like:
> > > 
> > >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000: 'gpio-ranges' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  .../devicetree/bindings/gpio/fsl-imx-gpio.yaml    | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > > index 454db20c2d1a..1fac69573bb9 100644
> > > --- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > > +++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > > @@ -51,6 +51,9 @@ properties:
> > >  
> > >    gpio-controller: true
> > >  
> > > +  gpio-ranges:
> > > +    maxItems: 1
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -62,6 +65,18 @@ required:
> > >  
> > >  additionalProperties: false
> > >  
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: fsl,imx8mp-gpio
> > > +    then:
> > > +      properties:
> > > +        gpio-ranges:
> > > +          minItems: 1
> > > +          maxItems: 2
> > 
> > Why do you limit this to fsl,imx8mp-gpio? The i.MX5,6,7 dtsi files use
> > gpio-ranges as well and other i.MX dtsi files could also use it.
> 
> All other cases use maximum one element in gpio-ranges, so they are
> covered so I assumed they are continuous. But if it not the case, I can
> make all them maximum 2.

I misread this, I thought you allow gpio-ranges only for imx8mp, but
it's only the maxItems you set differently for that SoC. Anyway,
arch/arm/boot/dts/imx6dl.dtsi has this:

&gpio1 {
        gpio-ranges = <&iomuxc  0 131 2>, <&iomuxc  2 137 8>, <&iomuxc 10 189 2>,
                      <&iomuxc 12 194 1>, <&iomuxc 13 193 1>, <&iomuxc 14 192 1>,
                      <&iomuxc 15 191 1>, <&iomuxc 16 185 2>, <&iomuxc 18 184 1>,
                      <&iomuxc 19 187 1>, <&iomuxc 20 183 1>, <&iomuxc 21 188 1>,
                      <&iomuxc 22 123 3>, <&iomuxc 25 121 1>, <&iomuxc 26 127 1>,
                      <&iomuxc 27 126 1>, <&iomuxc 28 128 1>, <&iomuxc 29 130 1>,
                      <&iomuxc 30 129 1>, <&iomuxc 31 122 1>;
};

I don't think it makes sense to specify maxItems.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
