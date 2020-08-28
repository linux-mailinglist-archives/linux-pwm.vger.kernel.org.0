Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204BC25573C
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Aug 2020 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgH1JMK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 05:12:10 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45208 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgH1JMH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 05:12:07 -0400
Received: by mail-ej1-f67.google.com with SMTP id si26so542424ejb.12;
        Fri, 28 Aug 2020 02:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RBT1OCzQ02U3NCjA6vShk0xXCvUozK7o2xDuaQszpRk=;
        b=TvccGzRkZO9Yu3GfGDi1oKDH4qFZFKxMRBEdwfVkquCmWvKCkG7e06KvfjXecSYVIP
         Q6wBJ0hBgzoWEtfpA4XSSZXv664ycTZGw3a3AGtWCZA1hNSkkhsABVt8DSMoSVcKg6FP
         h3TAVWlCn6/iXyohxSXashNrfUyjVggDMGm4izCGmjCo1Su54I1ciHg9FOyjnHvRLMro
         +8tDFh4i+mBrZWBW049+RKLTyF+Wg3y8YaaEsMyPMJZD87W8ymdkQURQmLACx6+ZyRo4
         DD0fiV0h1eDibzWigRmLrnQ2MvmDYwkgvqHsF2tFYA4KzJmmatzEjyzMuajDwaa0g3zv
         /abQ==
X-Gm-Message-State: AOAM531lwtRcruNZKFAK71vx3i7fmR28GzdVF6syUsjbWr8Mhv8ppbQ2
        vTdudhnnvKNvcpkgxW4RqXk=
X-Google-Smtp-Source: ABdhPJw3xCQnxyK7qlNke96fwa8aWRja8fL7fhhy3QWYB7wgkOEFUlEEvMzYUPI2MkBVhFAa2/goAg==
X-Received: by 2002:a17:906:40e:: with SMTP id d14mr762072eja.455.1598605924082;
        Fri, 28 Aug 2020 02:12:04 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id bn14sm334810ejb.115.2020.08.28.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:12:03 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:12:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-serial@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 12/19] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8
 compatible matching
Message-ID: <20200828091200.GB17786@pi3>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-13-krzk@kernel.org>
 <CAPDyKFp9m6xBJMGn2TgwD8VEUZ0JwzgowU32qUbL1qgEPua-GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFp9m6xBJMGn2TgwD8VEUZ0JwzgowU32qUbL1qgEPua-GA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 28, 2020 at 10:45:40AM +0200, Ulf Hansson wrote:
> On Tue, 25 Aug 2020 at 21:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
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
> 
> Rob, Krzysztof - do you want me to pick this one?

dt-bindings are independent so they can be applied individually.

I don't mind you taking it but still Rob's ack/review would be needed.

Other choice is that entire dt-bindings series go through Rob's tree.

Rob, what's your preference?

Best regards,
Krzysztof
