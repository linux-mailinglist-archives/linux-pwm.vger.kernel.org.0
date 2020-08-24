Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAD24FB7C
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHXKcq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 24 Aug 2020 06:32:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44609 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXKco (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 06:32:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so8105705wrs.11;
        Mon, 24 Aug 2020 03:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3kC1j2VGz3irmMnTu7OSvcIF5sgB8GN7svCyG6bNmQc=;
        b=GwtRoBAqEhZXPoO6GRQC0NFLkAKbwreCd8CzvDJlOnNI+CyR7tVsp5c2wAr7Y6At26
         ZiDKoD2iOmyNbkaqpnH/sm8Z6uV9OrKiMLUWcyjLic0r5Vn2L8MsEaPSIojq8ALuW3eT
         Nj3oiME+eEnLIP0S8MPayC4j2o7dGagtLdLVI/uk5IZsLNA+z9qLfKjyQyZYIcp82I87
         UEo37ielR9G8fZL5XypFRzEk4+Re6HEj7qdIJB58lNaP7cup8PVsGfbNKuLuOuNRL281
         bh/rkTv4VvGQTZIccPWtfAzhhfnVgwJ8jE2kk7gsSM43qQ9L3CW7Uvdykb83LunqpvvU
         E0sg==
X-Gm-Message-State: AOAM530AdW6lg5HRHJaFr+Lz8okp38HGiJNxNx8GMDrLq+KFLP+HZsdL
        SpGtqE3B5EZW3h1c7/gImEE=
X-Google-Smtp-Source: ABdhPJweVUT7a41DfLWZjKJnJ7ppNGMhfph8/pfsheA41o3Lgtr9MDX7LDVdL1I0kuB6ivdiZ0Q/PQ==
X-Received: by 2002:adf:e68f:: with SMTP id r15mr5135544wrm.196.1598265161023;
        Mon, 24 Aug 2020 03:32:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id b1sm614772wmj.8.2020.08.24.03.32.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:32:40 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:32:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Dong Aisheng <dongas86@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from
 USDHC
Message-ID: <20200824103237.GA26120@kozik-lap>
References: <20200823161550.3981-1-krzk@kernel.org>
 <20200823161550.3981-21-krzk@kernel.org>
 <AM6PR04MB49668B0F67B02B2A33603B4880560@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20200824091102.GA20819@kozik-lap>
 <CAA+hA=S=2SoF8egOq8h-eB9wZGDqrAw66VtW-bU9oBmzFSj9Bw@mail.gmail.com>
 <VI1PR04MB52949085DFA5D29C2858094290560@VI1PR04MB5294.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <VI1PR04MB52949085DFA5D29C2858094290560@VI1PR04MB5294.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 10:31:31AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Dong Aisheng [mailto:dongas86@gmail.com]
> > Sent: 2020年8月24日 17:45
> > To: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Aisheng Dong <aisheng.dong@nxp.com>; devicetree@vger.kernel.org;
> > linux-serial@vger.kernel.org; Anson Huang <anson.huang@nxp.com>;
> > linux-gpio@vger.kernel.org; Fabio Estevam <festevam@gmail.com>; Linus
> > Walleij <linus.walleij@linaro.org>; linux-pm@vger.kernel.org;
> > linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-pwm@vger.kernel.org; Bartosz Golaszewski
> > <bgolaszewski@baylibre.com>; Rob Herring <robh+dt@kernel.org>;
> > linux-mtd@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; Pengutronix
> > Kernel Team <kernel@pengutronix.de>; Thierry Reding
> > <thierry.reding@gmail.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> > Hauer <s.hauer@pengutronix.de>; linux-arm-kernel@lists.infradead.org;
> > linux-watchdog@vger.kernel.org; Bough Chen <haibo.chen@nxp.com>
> > Subject: Re: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible
> > from USDHC
> > 
> > On Mon, Aug 24, 2020 at 5:15 PM Krzysztof Kozlowski <krzk@kernel.org>
> > wrote:
> > >
> > > On Mon, Aug 24, 2020 at 09:00:19AM +0000, Aisheng Dong wrote:
> > > > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > Sent: Monday, August 24, 2020 12:16 AM
> > > > >
> > > > > The USDHC on i.MX 8QXP has its own compatible described in
> > > > > bindings and used in the driver (with its own quirks).  Remove
> > > > > additional fsl,imx7d-usdhc compatible to fix dtbs_check warnings like:
> > > > >
> > > > >   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml:
> > mmc@5b010000:
> > > > >     compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too long
> > > > >     From schema:
> > > > > /ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > > > >
> > > > >   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml:
> > mmc@5b010000:
> > > > >     compatible: Additional items are not allowed
> > > > > ('fsl,imx7d-usdhc' was
> > > > > unexpected)
> > > > >
> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > >
> > > > For Patch 19-22, I think we should fix dt binding doc.
> > >
> > > Are you sure that these USDHC controllers are compatible with i.MX 7D?
> > > Could they really run with fsl,imx7d-usdhc compatible?
> > 
> > AFAIK uSDHC on QXP is derived from the former platforms with adding a few
> > more new features. e.g. HS400ES/CMDQ.
> > Let me loop in uSDHC driver owner Haibo Chen to double confirm.
> 
> Yes, usdhc of imx8qxp can work by using the compatible "fsl, imx7d-usdhc", but will not support HS400ES/Command Queue any more. Also imx8qxp support Auto CMD23, but imx7d not.
> And imx8qxp need to re-config the clock rate after system PM, imx7d do not need to do this.

Then we can leave the compatible in DTS and I will correct the device
tree schema.

Best regards,
Krzysztof
