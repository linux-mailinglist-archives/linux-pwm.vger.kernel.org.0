Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE80B24FAD7
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 12:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgHXKAm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHXKAg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 06:00:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63204C061573;
        Mon, 24 Aug 2020 03:00:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id oz20so6136734ejb.5;
        Mon, 24 Aug 2020 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wq5i4qHfu7yzPAz7g/0D7Mody4FjfdyYHDZ2FJMtb1k=;
        b=YGImFIW/QqX0VtY2y4IDgqNs/BJmalIZ2Dd4Q8hxUYJX9TionAEYCxGa69uT6kkf48
         TtSTxS+qTYcJ/LFw/HZ86cykFD5QUfQsfYqd4zh4PKnt+E3aE2PcFbZgWUVpoKhPwMc1
         rG7997c0kwrNKfBs+Bw+mvkEyMBknFfy/N4Mt0vM6oDYstNNzD5sEbDnV0zWkwUmnnT5
         tgDtCJ/n9a9KX9S7zoDtBD/LC08UM1do9LpviaCIHMt12QByNBcReKmph2KZGE0R7Yk9
         oMOV3MwC0P9DvjXablSGFfZGU5zr4NqQDNevFgTvgUlapw32d9ImZKwG6QzusIpNptjv
         vgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wq5i4qHfu7yzPAz7g/0D7Mody4FjfdyYHDZ2FJMtb1k=;
        b=oVWZIPHyUqS5XRXmSX96Rv7E9Ql5OPvfg/bkDBeVKgYYKLglv+9MV973tcoa2uA5uc
         YQkG19N0XeGeOOniVESNBsojjHYijct3+3Gb1ZhFYegw1EVQKhUroDIsDM+zJnVhhH5F
         P8n1PIegYzLUtW92SmfgNPlRXgsmxaXNpj3GSNTFDl+3PPgt+9VvbGfT+sSp8W/779sT
         +jjAkjLDE/2iIEw4I52ADPaZ+ida4divnCUEC1gck2rlvzQKlg8+FuYfqY2cC9ZtuuY0
         5ranyKxTA/XHqLYZYA01t/m1s+iaAb0wHuV9hXgVQKhERyF9fnctYB6UgmFb+7diw9bE
         +WfA==
X-Gm-Message-State: AOAM530fSJeKyIZnwKF4vzACzj1f0eUlV44KCS6QkiX1Ah9esqgcOT1l
        53nxUbXj4WpZN+yZlRxpkK9bXN/PAmKjwaupbFw=
X-Google-Smtp-Source: ABdhPJy4bHtBJhH+rU55qeWIWBpWq4c03JJngRVDXW3+ekGgoPQyxrRrrRmtsXz+xOF8t2CfIYckZu3WLWEfMjEgf5s=
X-Received: by 2002:a17:906:4dd4:: with SMTP id f20mr5077416ejw.170.1598263234026;
 Mon, 24 Aug 2020 03:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200823161550.3981-1-krzk@kernel.org> <20200823161550.3981-21-krzk@kernel.org>
 <AM6PR04MB49668B0F67B02B2A33603B4880560@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20200824091102.GA20819@kozik-lap>
In-Reply-To: <20200824091102.GA20819@kozik-lap>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 24 Aug 2020 17:45:19 +0800
Message-ID: <CAA+hA=S=2SoF8egOq8h-eB9wZGDqrAw66VtW-bU9oBmzFSj9Bw@mail.gmail.com>
Subject: Re: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from USDHC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
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
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 5:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Aug 24, 2020 at 09:00:19AM +0000, Aisheng Dong wrote:
> > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > Sent: Monday, August 24, 2020 12:16 AM
> > >
> > > The USDHC on i.MX 8QXP has its own compatible described in bindings and
> > > used in the driver (with its own quirks).  Remove additional fsl,imx7d-usdhc
> > > compatible to fix dtbs_check warnings like:
> > >
> > >   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: mmc@5b010000:
> > >     compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too long
> > >     From schema:
> > > /ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > >
> > >   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: mmc@5b010000:
> > >     compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was
> > > unexpected)
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > For Patch 19-22, I think we should fix dt binding doc.
>
> Are you sure that these USDHC controllers are compatible with i.MX 7D?
> Could they really run with fsl,imx7d-usdhc compatible?

AFAIK uSDHC on QXP is derived from the former platforms with adding a few
more new features. e.g. HS400ES/CMDQ.
Let me loop in uSDHC driver owner Haibo Chen to double confirm.

Regards
Aisheng

> The implementation (Linux kernel driver) is different, I guess on
> purpose...
>
> Best regards,
> Krzysztof
>
> >
> > Regards
> > Aisheng
> >
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > index 61bccb69f09e..26c4fcdfe290 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > @@ -362,7 +362,7 @@
> > >             };
> > >
> > >             usdhc1: mmc@5b010000 {
> > > -                   compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > > +                   compatible = "fsl,imx8qxp-usdhc";
> > >                     interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
> > >                     reg = <0x5b010000 0x10000>;
> > >                     clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>, @@
> > > -374,7 +374,7 @@
> > >             };
> > >
> > >             usdhc2: mmc@5b020000 {
> > > -                   compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > > +                   compatible = "fsl,imx8qxp-usdhc";
> > >                     interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
> > >                     reg = <0x5b020000 0x10000>;
> > >                     clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>, @@
> > > -388,7 +388,7 @@
> > >             };
> > >
> > >             usdhc3: mmc@5b030000 {
> > > -                   compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > > +                   compatible = "fsl,imx8qxp-usdhc";
> > >                     interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
> > >                     reg = <0x5b030000 0x10000>;
> > >                     clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
> > > --
> > > 2.17.1
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
