Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53E724FBDD
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 12:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgHXKqC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 06:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgHXKpz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 06:45:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F0C061573;
        Mon, 24 Aug 2020 03:45:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id md23so10502594ejb.6;
        Mon, 24 Aug 2020 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f6wdlEKoq+5Slr+UsziPsdyk2CY1PCYDCcZCpyAdvwo=;
        b=UskvNm3ErsbR8Pp/wFDQea/LOjrsQ4lwIZJjMWNn1JqQJYresYEAPXPejRzFL60qex
         VE2PGxG3z8KRswRMmM0oKcJxH4wfLw5UvtX4JnyAUPoKWu9sxdm0qD/ddj2zaeo5vMgE
         KZeoYRVzeupKX/SneIEZ9AqQDO61XOR3UAzcYoPFcwipi1OS8bSVvAxM+lct67wWGrRQ
         WoFGfSl7GIm+5MgTB/3tGzC54KHwQhZaDXdU/hYA/29sWSYgsMo2Xqb3cBh5O/NmY5R9
         K9vbAnDlVC3IpZUgmny3LW/UUBYTGqa+eXFV+oY6U5DqQJs1C4JQPbuhL3NgHMj6ka9y
         dPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f6wdlEKoq+5Slr+UsziPsdyk2CY1PCYDCcZCpyAdvwo=;
        b=BOUAhbn+dwgjhScJXvuiz4Va037vSwo5yd/BDLejfqcvC0VaDZ2mt9vowBb7GZKo7V
         N/uyQWbDQK8ATzkD3DLTD6NNPQoMretQFkENqTQLoIAo3NdwKVaUhQJ2ypHJLhwyg+AT
         rUPxHqqLYPzlJmQvRRZsuvbrxVI2KAplyckVV6X7ZlIomwlMlw5D98kCFofGmqunFuKC
         0wAQ/ZxgsE7jM2a6MFehnkCIZuTaKrWiMpmsHEdw6Bfoub23kFgMffh0w9hncAX+i4+k
         L1KlAD4XvdwiXHkB9yfM/fcUTK7/XvCTZj/Xe1sVzjgqzlfrTZLw5K6qy+TenoiVrZND
         i95w==
X-Gm-Message-State: AOAM532enl1T4w0Q4fdYmU947gUZXkr3Nxynbgb1xUJBd2LvgG2t/8mh
        YPznfxq8yHFQx/9qkPNFZY8Fo5k3riKia2wyo4o=
X-Google-Smtp-Source: ABdhPJzEP44NtBFAfTFi6m+U0B8L72BF9hYGNpMJgnWY8VcgZq+4UR0vLLyZ7HOS1sZEFPyg+vJmWEtgQHp7weUp5fA=
X-Received: by 2002:a17:906:2a04:: with SMTP id j4mr5218133eje.440.1598265947869;
 Mon, 24 Aug 2020 03:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200823161550.3981-1-krzk@kernel.org> <20200823161550.3981-21-krzk@kernel.org>
 <AM6PR04MB49668B0F67B02B2A33603B4880560@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20200824091102.GA20819@kozik-lap> <CAA+hA=S=2SoF8egOq8h-eB9wZGDqrAw66VtW-bU9oBmzFSj9Bw@mail.gmail.com>
 <VI1PR04MB52949085DFA5D29C2858094290560@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <20200824103237.GA26120@kozik-lap>
In-Reply-To: <20200824103237.GA26120@kozik-lap>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 24 Aug 2020 18:30:33 +0800
Message-ID: <CAA+hA=TD8bjmws7FXAP7zZR1dYgtLPzjFrhPg8XwZcpP2ef4ug@mail.gmail.com>
Subject: Re: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from USDHC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bough Chen <haibo.chen@nxp.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 6:32 PM Krzysztof Kozlowski <krzk@kernel.org> wrote=
:
>
> On Mon, Aug 24, 2020 at 10:31:31AM +0000, Bough Chen wrote:
> > > -----Original Message-----
> > > From: Dong Aisheng [mailto:dongas86@gmail.com]
> > > Sent: 2020=E5=B9=B48=E6=9C=8824=E6=97=A5 17:45
> > > To: Krzysztof Kozlowski <krzk@kernel.org>
> > > Cc: Aisheng Dong <aisheng.dong@nxp.com>; devicetree@vger.kernel.org;
> > > linux-serial@vger.kernel.org; Anson Huang <anson.huang@nxp.com>;
> > > linux-gpio@vger.kernel.org; Fabio Estevam <festevam@gmail.com>; Linus
> > > Walleij <linus.walleij@linaro.org>; linux-pm@vger.kernel.org;
> > > linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > linux-pwm@vger.kernel.org; Bartosz Golaszewski
> > > <bgolaszewski@baylibre.com>; Rob Herring <robh+dt@kernel.org>;
> > > linux-mtd@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; Peng=
utronix
> > > Kernel Team <kernel@pengutronix.de>; Thierry Reding
> > > <thierry.reding@gmail.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> > > Hauer <s.hauer@pengutronix.de>; linux-arm-kernel@lists.infradead.org;
> > > linux-watchdog@vger.kernel.org; Bough Chen <haibo.chen@nxp.com>
> > > Subject: Re: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatib=
le
> > > from USDHC
> > >
> > > On Mon, Aug 24, 2020 at 5:15 PM Krzysztof Kozlowski <krzk@kernel.org>
> > > wrote:
> > > >
> > > > On Mon, Aug 24, 2020 at 09:00:19AM +0000, Aisheng Dong wrote:
> > > > > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > > Sent: Monday, August 24, 2020 12:16 AM
> > > > > >
> > > > > > The USDHC on i.MX 8QXP has its own compatible described in
> > > > > > bindings and used in the driver (with its own quirks).  Remove
> > > > > > additional fsl,imx7d-usdhc compatible to fix dtbs_check warning=
s like:
> > > > > >
> > > > > >   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml:
> > > mmc@5b010000:
> > > > > >     compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too=
 long
> > > > > >     From schema:
> > > > > > /ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > > > > >
> > > > > >   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml:
> > > mmc@5b010000:
> > > > > >     compatible: Additional items are not allowed
> > > > > > ('fsl,imx7d-usdhc' was
> > > > > > unexpected)
> > > > > >
> > > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > >
> > > > > For Patch 19-22, I think we should fix dt binding doc.
> > > >
> > > > Are you sure that these USDHC controllers are compatible with i.MX =
7D?
> > > > Could they really run with fsl,imx7d-usdhc compatible?
> > >
> > > AFAIK uSDHC on QXP is derived from the former platforms with adding a=
 few
> > > more new features. e.g. HS400ES/CMDQ.
> > > Let me loop in uSDHC driver owner Haibo Chen to double confirm.
> >
> > Yes, usdhc of imx8qxp can work by using the compatible "fsl, imx7d-usdh=
c", but will not support HS400ES/Command Queue any more. Also imx8qxp suppo=
rt Auto CMD23, but imx7d not.
> > And imx8qxp need to re-config the clock rate after system PM, imx7d do =
not need to do this.
>
> Then we can leave the compatible in DTS and I will correct the device
> tree schema.

Haibo,

As Krzysztof is helping fix uSDHC binding doc in Patch 12/22,
please double check with IC for the whole uSDHC derive relationships on i.M=
X
and feedback to Krzysztof if anything is wrong.

Regards
Aisheng

>
> Best regards,
> Krzysztof
