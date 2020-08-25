Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578B82512E9
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 09:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgHYHTO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 03:19:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41704 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgHYHTM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Aug 2020 03:19:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so5931634wrj.8;
        Tue, 25 Aug 2020 00:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WzjocZ6AbgdZxSRavuClgS3bWv6X8HTLysz12xiMgeg=;
        b=qyVhXj9agD5+H3XVK+tGkvhZNeQX6hvhMZSkWy/nLUggaEVvTuapXW7pPIk6cU8A+K
         nuZwvr16njwOmCPuhbfNSaYUSm/wW2RcplMrJjJGrnfkw0EC9OfZ3Vd/AqaB9ydKN88Z
         VwCe5YDfCKE+3LptNqpWKyrj/C+Y97JUV5IReEapkIPmPeI16SryBOTUP9l/2IHbEnZk
         IQtlCVM5/vt00leFHp2O2D1ipL20vQ8Qn91XNyi5YtMc6pzkrcV6IujgEdWvuGn9F5OW
         NXOspjyjzl2cK8rdda58N2BQOb3WlXwXyKBSBh3svaRl+uMGyCtbXrNwiH4uABvqLG8w
         rzDA==
X-Gm-Message-State: AOAM533G7Z/K85Dollgia6nd7o08jhVncziIKOhq/nmJGdYEE5b1nhpt
        isX4TtDpsynKsLZEK/7wAik=
X-Google-Smtp-Source: ABdhPJwkhdWQGkLwZ00kAqnPEmqc8N+HVtkEdsjRUBu5ZaCv9oCeqT0wAbIggVlRGDIzjGcy8OFy8Q==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr9451383wrv.104.1598339948999;
        Tue, 25 Aug 2020 00:19:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id c6sm1611593wrr.15.2020.08.25.00.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 00:19:08 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:19:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 13/19] dt-bindings: nvmem: imx-ocotp: Update i.MX 8M
 compatibles
Message-ID: <20200825071905.GE3458@kozik-lap>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-13-krzk@kernel.org>
 <20200825023904.GA3837236@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825023904.GA3837236@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 08:39:04PM -0600, Rob Herring wrote:
> On Mon, Aug 24, 2020 at 06:26:46PM +0200, Krzysztof Kozlowski wrote:
> > DTSes with new i.MX 8M SoCs use two compatibles so update the binding to
> > fix dtbs_check warnings like:
> > 
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000: compatible:1: 'syscon' was expected
> >     From schema: Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> > 
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
> >     compatible: ['fsl,imx8mn-ocotp', 'fsl,imx8mm-ocotp', 'syscon'] is too long
> > 
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
> >     compatible: Additional items are not allowed ('syscon' was unexpected)
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 39 ++++++++++++-------
> >  1 file changed, 24 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> > index 1c9d7f05f173..b5b250185afd 100644
> > --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> > @@ -19,21 +19,30 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - fsl,imx6q-ocotp
> > -          - fsl,imx6sl-ocotp
> > -          - fsl,imx6sx-ocotp
> > -          - fsl,imx6ul-ocotp
> > -          - fsl,imx6ull-ocotp
> > -          - fsl,imx7d-ocotp
> > -          - fsl,imx6sll-ocotp
> > -          - fsl,imx7ulp-ocotp
> > -          - fsl,imx8mq-ocotp
> > -          - fsl,imx8mm-ocotp
> > -          - fsl,imx8mn-ocotp
> > -          - fsl,imx8mp-ocotp
> > -      - const: syscon
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,imx6q-ocotp
> > +              - fsl,imx6sl-ocotp
> > +              - fsl,imx6sx-ocotp
> > +              - fsl,imx6ul-ocotp
> > +              - fsl,imx6ull-ocotp
> > +              - fsl,imx7d-ocotp
> > +              - fsl,imx6sll-ocotp
> > +              - fsl,imx7ulp-ocotp
> > +              - fsl,imx8mq-ocotp
> > +              - fsl,imx8mm-ocotp
> 
> > +              - fsl,imx8mn-ocotp
> > +              - fsl,imx8mp-ocotp
> 
> Should be dropped.

OK

Best regards,
Krzysztof

