Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475342513A7
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgHYHzw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 03:55:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45806 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgHYHzv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Aug 2020 03:55:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so4958434wrt.12;
        Tue, 25 Aug 2020 00:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBjVw1JG0tpm4bk51wIknFht9NwTSZ65KB4U3gClblQ=;
        b=pVQLT+8ijKQCPTJ9nJSzGdtsvR4/qHb2QG9MgKgdIdQ2hG1dj2KpBB8/UQzGdjBnrG
         YyCru7GkjEW1Z2avQWxiG/fCrKBPJ8QLh7Ak9F4nZ797j6oRUqOhRDx1vcJ0Didy1eh4
         pterNAMGOBwZ+SC1cypGNjD7gNwVaG1ORbIDM9wyKISr3dMwnhqVxIvWq+/cECtf1ZVT
         i2nYue89aCsbjA1z3gQLqGHe7hFUPHIhQUW8NA+ARK/3s5DEwLOyri6XUavdKa7MBTJJ
         yvhAgAaQK4/bMkq+sxNvowGly71mHlHX7xdg0tdijpLF57CchJpgSl+5bPAc9qDr96s5
         bjIw==
X-Gm-Message-State: AOAM531VaZJ9MZnL9VRgwXymUo0hQu1KXP7Pt3vjMMEplrw4cCwPLMhE
        xhxP7RtNtC49OSmDbRJDYO8=
X-Google-Smtp-Source: ABdhPJy11J0dvtltETiMUmgoqOGY5vwRYKznzFSM+Jn9Jhy70mulHl9VGChcIKqtFo0jH3ClWuVjng==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr9247503wrp.230.1598342147767;
        Tue, 25 Aug 2020 00:55:47 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id f9sm8049134wrm.5.2020.08.25.00.55.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 00:55:47 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:55:43 +0200
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
Subject: Re: [PATCH v2 17/19] dt-bindings: serial: fsl-lpuart: Fix compatible
 matching
Message-ID: <20200825075543.GA10369@kozik-lap>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-17-krzk@kernel.org>
 <20200825024226.GA3843643@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825024226.GA3843643@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 08:42:26PM -0600, Rob Herring wrote:
> On Mon, Aug 24, 2020 at 06:26:50PM +0200, Krzysztof Kozlowski wrote:
> > The i.MX 8QXP DTSes use two compatibles so update the binding to fix
> > dtbs_check warnings like:
> > 
> >   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
> >     compatible: ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> >     From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > 
> >   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
> >     compatible: Additional items are not allowed ('fsl,imx7ulp-lpuart' was unexpected)
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. New patch.
> > ---
> >  .../devicetree/bindings/serial/fsl-lpuart.yaml | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > index e82c2cf9fef7..8ee651f2ef0b 100644
> > --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > @@ -14,13 +14,17 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - fsl,vf610-lpuart
> > -      - fsl,ls1021a-lpuart
> > -      - fsl,ls1028a-lpuart
> > -      - fsl,imx7ulp-lpuart
> > -      - fsl,imx8qxp-lpuart
> > -      - fsl,imx8qm-lpuart
> > +    oneOf:
> > +      - enum:
> > +          - fsl,vf610-lpuart
> > +          - fsl,ls1021a-lpuart
> > +          - fsl,ls1028a-lpuart
> > +          - fsl,imx7ulp-lpuart
> > +          - fsl,imx8qxp-lpuart
> 
> This should be dropped.

Right.

Best regards,
Krzysztof

