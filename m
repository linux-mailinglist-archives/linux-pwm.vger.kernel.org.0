Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE7250F47
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgHYCe7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:34:59 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34453 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCe6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:34:58 -0400
Received: by mail-il1-f195.google.com with SMTP id t4so9171550iln.1;
        Mon, 24 Aug 2020 19:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJoEimkJnnwHgVvCDUgwBHtlZ+InQ3zd0Y0pHOOD44A=;
        b=JVp6KchwZTcAglR4U1uIwYPUGk++UMKCtkjyzgjWrPtViW7ay3Suh8D9C1BgJ1+Jju
         c6sGw8GjgAUWNlnbIMth5lSqXyhyOwirGBKBlK2SZaTAkzQ98zSW3vZia2d+iFz1HsEv
         jObe3G2RYh9KBwTI/hvGap7pLLet/FiOKXVCfatiH4ZuB5hucSm+yVUPmeGUvWvNQpum
         cAyYzTEMndWjI3r13NYvQIS7NtHP6WIpQ3od8/BumkQm4pfI0BIengKpd76J3mNHDfS4
         CAsOvQxu4yyWH1fQwBPZtDEstQFBxcpOLae3bX5NiJVIBw9jhn+7QYHACW33+RaTJI+t
         ti8Q==
X-Gm-Message-State: AOAM5314qHrcpDgxJBAP971J69p5NGiy1xTmRsmvP74EpQIMr+Y45oYo
        5SMTucGqpufVvMMfsDD6pg==
X-Google-Smtp-Source: ABdhPJxJDM8Rm0sqb3pMsMUWmt3xwf6oKOYlRQcH0/WBoIjcLgToUP0hvDtz23rTAV3yN9ZWGmPtow==
X-Received: by 2002:a92:cccb:: with SMTP id u11mr4379380ilq.54.1598322897200;
        Mon, 24 Aug 2020 19:34:57 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r9sm8237287iln.18.2020.08.24.19.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:34:56 -0700 (PDT)
Received: (nullmailer pid 3831534 invoked by uid 1000);
        Tue, 25 Aug 2020 02:34:54 -0000
Date:   Mon, 24 Aug 2020 20:34:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, Frank Li <frank.li@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Han Xu <han.xu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-mtd@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 07/19] dt-bindings: serial: fsl-imx-uart: Add i.MX 8M
 compatibles
Message-ID: <20200825023454.GA3831482@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-7-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:40 +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
>     compatible:0: 'fsl,imx8mm-pwm' is not one of ['fsl,imx1-pwm', 'fsl,imx27-pwm']
>     From schema: Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
>     compatible: ['fsl,imx8mm-pwm', 'fsl,imx27-pwm'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
>     compatible: Additional items are not allowed ('fsl,imx27-pwm' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Fix subject prefix
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
