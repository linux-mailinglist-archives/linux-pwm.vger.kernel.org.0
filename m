Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB9250F54
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHYCgE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:36:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41900 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCgD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:36:03 -0400
Received: by mail-io1-f65.google.com with SMTP id m23so10343575iol.8;
        Mon, 24 Aug 2020 19:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQ/f/ktHuo1XxTsZxthGryHuQelRFo2/zrEV3gWiCCI=;
        b=bJi34DX1GzBsJCMACbeu4YJwRYLSm/7mO/rW5BkSiG/h+V9JMBvJWzarCU8iQMclz7
         ZtC42FF0Q/IwB2EYjq/jdLLoR3UgCh8/zKihogV8xfGTOT/9A3sY56FqeloL4ppAgsJF
         8J0/6JbhQf9JD0tctZRvJXsyHLzrd1fgqRJ9HffVm9mqWD7Mxy9fM3/I2zfgluk0i1Fe
         TPf1bXZzHvdOzZsabttqCuJPOnJ5G/5NAMFAu/VLX/7HVbEecGxtsGUt+mvf+wP8XDEt
         XgTXRHBLrbT1f5YeODFVtl5uCy4g+u1KO/GtQahxnpm4m018N7u63eoctTOi0A/YnhS1
         nNEQ==
X-Gm-Message-State: AOAM532GhYIWfu4FvgAq/ykY3NigGpfeJgzJ7TWdoPuFyUdsCgALvJTR
        EBl6psjR87wWovAirmjb0A==
X-Google-Smtp-Source: ABdhPJyqr+8XB4kd9Ht8ECj8oo1spWYjkt5y3c5arw85YNAcQmOqVROEEoEukdDbTOXBxw8fo47EXA==
X-Received: by 2002:a5e:df42:: with SMTP id g2mr7297543ioq.117.1598322961781;
        Mon, 24 Aug 2020 19:36:01 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id s143sm8568791ilc.14.2020.08.24.19.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:36:01 -0700 (PDT)
Received: (nullmailer pid 3833404 invoked by uid 1000);
        Tue, 25 Aug 2020 02:35:56 -0000
Date:   Mon, 24 Aug 2020 20:35:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Han Xu <han.xu@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Fugang Duan <fugang.duan@nxp.com>, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 09/19] dt-bindings: mtd: gpmi-nand: Add i.MX 8M
 compatibles
Message-ID: <20200825023556.GA3833348@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-9-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:42 +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
>     compatible:0: 'fsl,imx8mm-gpmi-nand' is not one of ['fsl,imx23-gpmi-nand', 'fsl,imx28-gpmi-nand', 'fsl,imx6q-gpmi-nand', 'fsl,imx6sx-gpmi-nand', 'fsl,imx7d-gpmi-nand']
>     From schema: Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
>     compatible: ['fsl,imx8mm-gpmi-nand', 'fsl,imx7d-gpmi-nand'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
>     compatible: Additional items are not allowed ('fsl,imx7d-gpmi-nand' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/mtd/gpmi-nand.yaml     | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
