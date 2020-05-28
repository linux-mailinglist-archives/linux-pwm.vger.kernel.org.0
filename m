Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25C1E5428
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2020 04:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgE1CrQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 May 2020 22:47:16 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38001 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1CrP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 May 2020 22:47:15 -0400
Received: by mail-il1-f194.google.com with SMTP id q18so5046819ilm.5;
        Wed, 27 May 2020 19:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DyKeOTT5ayES89536EIkfmSdE8pie6WqWxuv+WC96Uc=;
        b=BAy1fUqavC/vBaGip4tuaCcD5TUBHDRypNl16nDBNK/Ae+dLT9xRye+qOlYO9y5F73
         7kxU6LTAzrx4pOnzy975Autvl12mxq/Y1gOeYJAoYFZhTtBlDOyOKlsjvSfG53wiqEyv
         ZApdkZzIFgTLR6QHNYKimlKbo/Q2WqwYHFiyL2EJAMJdIeQNdESjfw+QE2vHEEpgQPck
         e9fWcUiMdAbNdXeQ1AA2cVgOa9x0zlqwdbneEvn4/yOgV6xks3KFNC1DQ71KRnfeUsXO
         0NI7htfzjvldTxpdaAp2IO8qUfMMXGtGDn4bTNRRNsePs2smlkxPr4mbZo9VsYlhNXxE
         iirw==
X-Gm-Message-State: AOAM531c3ROlupl/utIMhTAU8j+kmh9TVPIpLHpG5P09D503x39ihtzd
        WOL6CjAY7t+/ZeHO3+3jmg==
X-Google-Smtp-Source: ABdhPJy2sXNW5d3TvaBR69TXcEPbrmESs/mfGAN1Xlh1FUcZkRjXJt+7LBlSAQNHed62UWXHktKI/Q==
X-Received: by 2002:a05:6e02:138b:: with SMTP id d11mr991383ilo.183.1590634033306;
        Wed, 27 May 2020 19:47:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l6sm1973875ioh.32.2020.05.27.19.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:47:12 -0700 (PDT)
Received: (nullmailer pid 3268338 invoked by uid 1000);
        Thu, 28 May 2020 02:47:11 -0000
Date:   Wed, 27 May 2020 20:47:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Convert imx pwm to json-schema
Message-ID: <20200528024711.GA3265614@bogus>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966EC7122B2BFB9FEEDD74280B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4966EC7122B2BFB9FEEDD74280B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 18, 2020 at 05:58:42AM +0000, Aisheng Dong wrote:
> > From: Anson Huang <Anson.Huang@nxp.com>
> > Sent: Thursday, May 14, 2020 2:54 PM
> > 
> > Convert the imx pwm binding to DT schema format using json-schema.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt  | 27 ---------
> > Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 66
> > ++++++++++++++++++++++
> >  2 files changed, 66 insertions(+), 27 deletions(-)  delete mode 100644
> > Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > deleted file mode 100644
> > index 22f1c3d..0000000
> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > +++ /dev/null
> > @@ -1,27 +0,0 @@
> > -Freescale i.MX PWM controller
> > -
> > -Required properties:
> > -- compatible : should be "fsl,<soc>-pwm" and one of the following
> > -   compatible strings:
> > -  - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
> > -  - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
> > -- reg: physical base address and length of the controller's registers
> > -- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.yaml
> > -  in this directory for a description of the cells format.
> > -- clocks : Clock specifiers for both ipg and per clocks.
> > -- clock-names : Clock names should include both "ipg" and "per"
> > -See the clock consumer binding,
> > -	Documentation/devicetree/bindings/clock/clock-bindings.txt
> > -- interrupts: The interrupt for the pwm controller
> > -
> > -Example:
> > -
> > -pwm1: pwm@53fb4000 {
> > -	#pwm-cells = <3>;
> > -	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
> > -	reg = <0x53fb4000 0x4000>;
> > -	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
> > -		 <&clks IMX5_CLK_PWM1_HF_GATE>;
> > -	clock-names = "ipg", "per";
> > -	interrupts = <61>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > new file mode 100644
> > index 0000000..4b62af2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevice
> > +tree.org%2Fschemas%2Fpwm%2Fimx-pwm.yaml%23&amp;data=02%7C01%
> > 7Caisheng.d
> > +ong%40nxp.com%7C9b5cc1814a4b47d1cb0d08d7f7d4f594%7C686ea1d3bc
> > 2b4c6fa92c
> > +d99c5c301635%7C0%7C0%7C637250366331627865&amp;sdata=M2RPcty
> > wz61WZrpAW6S
> > +O3NJbr2wj2qXwnMMmBwCbInk%3D&amp;reserved=0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevice
> > +tree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Caishen
> > g.dong%
> > +40nxp.com%7C9b5cc1814a4b47d1cb0d08d7f7d4f594%7C686ea1d3bc2b4c
> > 6fa92cd99c
> > +5c301635%7C0%7C0%7C637250366331627865&amp;sdata=UxgYSClanyOjt
> > BmlyNrMZyF
> > +3%2F5awD%2FM3yaVPqgNKgxs%3D&amp;reserved=0
> > +
> > +title: Freescale i.MX PWM controller
> > +
> > +maintainers:
> > +  - Philipp Zabel <p.zabel@pengutronix.de>
> > +
> > +properties:
> > +  "#pwm-cells":
> > +    description: |
> > +      Should be 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.yaml
> > +      in this directory for a description of the cells format.
> 
> Should we add the reference to pwm.yaml?
> BTW, strange, I didn't see format description in pwm.yaml.

No need to. That's generally only needed when there's some structure 
like SPI or I2C bus to include.

Rob
