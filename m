Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7A256509
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Aug 2020 08:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgH2GYe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Aug 2020 02:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgH2GYe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 29 Aug 2020 02:24:34 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B6220E65;
        Sat, 29 Aug 2020 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598682273;
        bh=rO56MVIvVtBfpXUiJzwAJauYsn+0k3epFv4DZf0v930=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QlJAZyqSAmECnl4bbQSHcum5VHSkJCTsozVueyferoSttjlBPB/FITNMUinzNR1BP
         5xEy1WY8WdAAqz+oR5fUnewT/d2Jrxy4VwXsfln3ZXy7B0hLk/iwFmCmwHnYd+3zn6
         ALHbwBKZkLSF2l/4sgXjHvhaGv2AGyHDtZdZk/UA=
Received: by mail-ej1-f41.google.com with SMTP id o18so1918888eje.7;
        Fri, 28 Aug 2020 23:24:33 -0700 (PDT)
X-Gm-Message-State: AOAM531dv0fxsJg5a958//jsj61rs8FEMmgBm/sEsYn8VDBZAmI7ooJw
        2K6Z7nScYxwExkLkuDekajpfaWPRfRmgT7QT9LI=
X-Google-Smtp-Source: ABdhPJxPqtl25Mm9VQlnooxEKiADTie13uCG9BQK2ZeTNWjK59f8umoolhx1AO7I9ld//ckn9tNf3hs4c0nADZ6+a0Y=
X-Received: by 2002:a17:906:3b4b:: with SMTP id h11mr2194097ejf.381.1598682271779;
 Fri, 28 Aug 2020 23:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200825193536.7332-1-krzk@kernel.org> <20200825193536.7332-13-krzk@kernel.org>
 <20200828213850.GA3444012@bogus>
In-Reply-To: <20200828213850.GA3444012@bogus>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 29 Aug 2020 08:24:20 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcMApvGpVAy4HSrNXu+LAdQS83FqHy+cfu3bdMBYE3jnA@mail.gmail.com>
Message-ID: <CAJKOXPcMApvGpVAy4HSrNXu+LAdQS83FqHy+cfu3bdMBYE3jnA@mail.gmail.com>
Subject: Re: [PATCH v3 12/19] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8
 compatible matching
To:     Rob Herring <robh@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Fugang Duan <fugang.duan@nxp.com>, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>, Han Xu <han.xu@nxp.com>,
        linux-serial@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frank Li <frank.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 28 Aug 2020 at 23:38, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 25 Aug 2020 21:35:29 +0200, Krzysztof Kozlowski wrote:
> > The i.MX 8 DTSes use two compatibles so update the binding to fix
> > dtbs_check warnings like:
> >
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
> >     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
> >     From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> >
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
> >     compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
> >
> >   arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: mmc@30b40000:
> >     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v2:
> > 1. Remove moved compatibles.
> >
> > Changes since v1:
> > 1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
> > ---
> >  .../bindings/mmc/fsl-imx-esdhc.yaml           | 37 ++++++++++---------
> >  1 file changed, 20 insertions(+), 17 deletions(-)
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: compatible: ['fsl,imx8qxp-usdhc'] is not valid under any of the given schemas (Possible causes of the failure):
>         /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: compatible: ['fsl,imx8qxp-usdhc'] is too short

I will send a v4 just for this one patch. All others seem to be good.

Best regards,
Krzysztof
