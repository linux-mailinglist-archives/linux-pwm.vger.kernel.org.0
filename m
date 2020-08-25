Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96BC250F05
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHYCbJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:31:09 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35200 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHYCbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:31:08 -0400
Received: by mail-il1-f196.google.com with SMTP id q14so9148706ilm.2;
        Mon, 24 Aug 2020 19:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PXYDf+qDwAgwtB6BXfF4E9zdnola8K+rSCAg7rcKWX8=;
        b=NvLVokxZy6QYF/P7kXEwWb+1SboVHeNXx1SGgn/VFl1odoYsA/OLbpjLN2P9fz7qx4
         FpNl+CnWU6bHSpSxKTQ6SmAkuzUfn1wHlUuE+LUR6P2Xia08MCpDZ3lUdX3tthYLdyAp
         7FBKJXmXNtE8DsS8jQmfA9FTUmZ4X4FinwGqhrON2nSt2scu880BaczzYgjUhbIdY39l
         dRRA8zRPj5BZD6HSqS09KpP331pHh4IZjzHDNOieM+w9SCWja9pVqWw88bCceWMacZqf
         y/m1e/2ZRv6ob9JO2AYV7aboX17jtWom3YSEYtA0TBcBa3yl0KPiqgTUvQslJ6Ywr/Dw
         vDdw==
X-Gm-Message-State: AOAM531N+kZbSLclH9WMxmKBYTk+xNnBHvCBBcCXC4YEZR4kjdtXeOl4
        7tgUVuFd1zyEVI3UDeT1lw==
X-Google-Smtp-Source: ABdhPJyGDaoxihkaEsUnsTnN1juKRfLn0VDzxtnao8PSrNSlwaaCfOoXA1iVGDNuEkEW0fSsETPJ5g==
X-Received: by 2002:a92:ba02:: with SMTP id o2mr7216574ili.3.1598322665441;
        Mon, 24 Aug 2020 19:31:05 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q23sm7699137ior.47.2020.08.24.19.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:31:04 -0700 (PDT)
Received: (nullmailer pid 3824789 invoked by uid 1000);
        Tue, 25 Aug 2020 02:31:00 -0000
Date:   Mon, 24 Aug 2020 20:31:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        Frank Li <frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Han Xu <han.xu@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Will Deacon <will@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH v2 01/19] dt-bindings: gpio: fsl-imx-gpio: Add i.MX 8
 compatibles
Message-ID: <20200825023100.GA3824736@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:34 +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8 SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible:0: 'fsl,imx8mm-gpio' is not one of ['fsl,imx1-gpio', 'fsl,imx21-gpio', 'fsl,imx31-gpio', 'fsl,imx35-gpio', 'fsl,imx7d-gpio']
>     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible: ['fsl,imx8mm-gpio', 'fsl,imx35-gpio'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible: Additional items are not allowed ('fsl,imx35-gpio' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/gpio/fsl-imx-gpio.yaml           | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
