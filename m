Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874FB250F73
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHYCiI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:38:08 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39277 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCiH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:38:07 -0400
Received: by mail-il1-f194.google.com with SMTP id f12so9149554ils.6;
        Mon, 24 Aug 2020 19:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vHuWCZoFM8KEH9OXdGLnKVh8KdDE2ghgJSP6XVVfi1k=;
        b=GT7Kh7dmpwbmyxkGNjv+dHJDPuNnQ+NFdrpkD5EvRNRnDJR/qqNQ1H9hwodzN2swXD
         2Qxjcd9Z++Noc1m4pVmYH4vIMLbskvE5Sr74Gek5NDnyo9NX3OsRYj+2uvGqHqie0JyP
         8RmF0yxyiU0hzrX3TAQkiUGSSD6upXE3eqw3XgmacQ+no24w18ceLNWlQLrgfzMwostl
         pmiug5iT57bE3c1uKDaogs5ALFx8UEon4eNk3kromz5DuDI+0auwffu7yFtFFMQAfQuR
         SwfpbccyWN8/moRy58tj5LgykNaMVZZ+tArSQ9M+pRJoMyZhC1zAneS9n/rOPZPf5cfG
         nVZQ==
X-Gm-Message-State: AOAM531Q1XeOK5A4n0D2dv/YlGj6hBAoA4ypHLvc7W20/NxVjhs7rtdn
        sfHuSP6SOzRPFTwv9Rj3bQ==
X-Google-Smtp-Source: ABdhPJxyDT616uQdPaHejXQOiu9bcoPn9AkiEkg6Sluynt9CbmKjrnrd75RY7Yu+d7MHI+Z/K1B02Q==
X-Received: by 2002:a92:5209:: with SMTP id g9mr7627159ilb.72.1598323085959;
        Mon, 24 Aug 2020 19:38:05 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c12sm8217104ilq.79.2020.08.24.19.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:38:05 -0700 (PDT)
Received: (nullmailer pid 3836883 invoked by uid 1000);
        Tue, 25 Aug 2020 02:38:01 -0000
Date:   Mon, 24 Aug 2020 20:38:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
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
Subject: Re: [PATCH v2 12/19] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8
 compatible matching
Message-ID: <20200825023801.GA3835035@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-12-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-12-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 06:26:45PM +0200, Krzysztof Kozlowski wrote:
> The i.MX 8 DTSes use two compatibles so update the binding to fix
> dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
>     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
>     From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
>     compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
> 
>   arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: mmc@30b40000:
>     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
> ---
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 40 +++++++++++--------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 10b45966f1b8..54f05e2a4246 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -21,23 +21,29 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx25-esdhc
> -      - fsl,imx35-esdhc
> -      - fsl,imx51-esdhc
> -      - fsl,imx53-esdhc
> -      - fsl,imx6q-usdhc
> -      - fsl,imx6sl-usdhc
> -      - fsl,imx6sx-usdhc
> -      - fsl,imx6ull-usdhc
> -      - fsl,imx7d-usdhc
> -      - fsl,imx7ulp-usdhc
> -      - fsl,imx8mq-usdhc
> -      - fsl,imx8mm-usdhc
> -      - fsl,imx8mn-usdhc
> -      - fsl,imx8mp-usdhc
> -      - fsl,imx8qm-usdhc
> -      - fsl,imx8qxp-usdhc
> +    oneOf:
> +      - enum:
> +          - fsl,imx25-esdhc
> +          - fsl,imx35-esdhc
> +          - fsl,imx51-esdhc
> +          - fsl,imx53-esdhc
> +          - fsl,imx6q-usdhc
> +          - fsl,imx6sl-usdhc
> +          - fsl,imx6sx-usdhc
> +          - fsl,imx6ull-usdhc
> +          - fsl,imx7d-usdhc
> +          - fsl,imx7ulp-usdhc

> +          - fsl,imx8mq-usdhc
> +          - fsl,imx8mm-usdhc
> +          - fsl,imx8qxp-usdhc

These should be dropped.

> +      - items:
> +          - enum:
> +              - fsl,imx8mm-usdhc
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
> +              - fsl,imx8mq-usdhc
> +              - fsl,imx8qxp-usdhc
> +          - const: fsl,imx7d-usdhc
>  
>    reg:
>      maxItems: 1
> -- 
> 2.17.1
> 
