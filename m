Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94489250FA7
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHYCmd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:42:33 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33459 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgHYCmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:42:33 -0400
Received: by mail-il1-f196.google.com with SMTP id r13so9170719iln.0;
        Mon, 24 Aug 2020 19:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/WdM/o7ZMD0IqugYhx8lyxEOEFTESZXMB5cmr4fyzog=;
        b=KGz+DKFXZ+hPPv4JNfMYdsotO714XMDNvjdadm4UphgLqE6irclrnZZBbyK0BpXOx+
         j/y4sVqhTWD/rLyBCfQagoHPkruBSlgPQRYCHWxj60vOwOTXWzIA9nsH1R5gHjhrZEeK
         hR0P1bmd7EViiR/palF8JxHXy2ihCXhIrvjdh4ZZwnaluR0oE3XU1yCIepAAhO4KRQw7
         sfi7vajXWMn6dAUHooy4nH8ZlClFly+Ei/Ggz/+y2tLlZU1I9cH67iwVv9a+qLCyDD1r
         yCAxF7QiatKgp5aQ+HMKc3s+nMd/wzxbwJJ8DcwSuc9kW7Du4IWdiNSN0OidLacLkizJ
         3s6g==
X-Gm-Message-State: AOAM533KzaUmN+IBiklakk6VvyjbjZpw07mUGZloLUzc/BtKv2YWtSHV
        o9epbsQHPwSxD7DPVJds/w==
X-Google-Smtp-Source: ABdhPJwidQ7yo/gzPK50UABO+YMGeGvK85w0t85XXeOwlGQeq2eG79hrcePzshy++cECjBr5Fj4wfg==
X-Received: by 2002:a05:6e02:cb0:: with SMTP id 16mr7178015ilg.147.1598323351719;
        Mon, 24 Aug 2020 19:42:31 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 79sm8642555ilc.9.2020.08.24.19.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:42:31 -0700 (PDT)
Received: (nullmailer pid 3844411 invoked by uid 1000);
        Tue, 25 Aug 2020 02:42:26 -0000
Date:   Mon, 24 Aug 2020 20:42:26 -0600
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
Subject: Re: [PATCH v2 17/19] dt-bindings: serial: fsl-lpuart: Fix compatible
 matching
Message-ID: <20200825024226.GA3843643@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-17-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-17-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 06:26:50PM +0200, Krzysztof Kozlowski wrote:
> The i.MX 8QXP DTSes use two compatibles so update the binding to fix
> dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
>     compatible: ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
>     From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
>     compatible: Additional items are not allowed ('fsl,imx7ulp-lpuart' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch.
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.yaml | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index e82c2cf9fef7..8ee651f2ef0b 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -14,13 +14,17 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,vf610-lpuart
> -      - fsl,ls1021a-lpuart
> -      - fsl,ls1028a-lpuart
> -      - fsl,imx7ulp-lpuart
> -      - fsl,imx8qxp-lpuart
> -      - fsl,imx8qm-lpuart
> +    oneOf:
> +      - enum:
> +          - fsl,vf610-lpuart
> +          - fsl,ls1021a-lpuart
> +          - fsl,ls1028a-lpuart
> +          - fsl,imx7ulp-lpuart
> +          - fsl,imx8qxp-lpuart

This should be dropped.

> +          - fsl,imx8qm-lpuart
> +      - items:
> +          - const: fsl,imx8qxp-lpuart
> +          - const: fsl,imx7ulp-lpuart
>  
>    reg:
>      maxItems: 1
> -- 
> 2.17.1
> 
