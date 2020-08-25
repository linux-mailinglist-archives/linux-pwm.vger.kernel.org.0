Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC751250F3D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHYCec (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:34:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43297 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHYCeb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:34:31 -0400
Received: by mail-io1-f65.google.com with SMTP id s1so10941446iot.10;
        Mon, 24 Aug 2020 19:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x+blyISBX8O+J87PmHV8yJOc3lzp4xRnM8u5p0pFFIg=;
        b=fPKBKb3kFZDOZ5BBRvyWG+TVBwXi1Oh1ebHNFiSe2uvZ/60puEk/syIctvb/fo3v7b
         rkbfTooAFUpeLV1oYKjyEBjb87ERRv5oCKV7Z/ysb/4k+qPPMWwp6rI6jsmCms6kDtrz
         7w8DADWAIuLQUKAY41KRqOzS3a+YphOEfQ23Tu7AD5rzqPXQVg2RB64vSqxJJvOtJKyG
         5Qv1veHSnhb97z6bxryyRTU52vBIwzNhJPlDgusxHqV+rk3xXzrN9ReuBKH8kiEkCyKJ
         a1zJIdQwfb4gf1EV6/qrK20rWLOZwdGdqx6sndDRYjgG1a/VA13u8BfupRlvsr6Mw3vT
         vkDw==
X-Gm-Message-State: AOAM531+8zA5pVIFrVWPBL96rjQaK3FRKUC31RQIk7B/bBfaKHsHoLdK
        JbdBdLP18CFfQdeI7aaDXQ==
X-Google-Smtp-Source: ABdhPJyaOC5zeFjmqOlCITvDcH+xyOJiMMlCTxiAPZs0Jp5TJvT2SOBvfY371hTr4bWxDJkDMg8Z7A==
X-Received: by 2002:a6b:dc07:: with SMTP id s7mr7154074ioc.162.1598322870182;
        Mon, 24 Aug 2020 19:34:30 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id l2sm8443510ilt.2.2020.08.24.19.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:34:29 -0700 (PDT)
Received: (nullmailer pid 3830713 invoked by uid 1000);
        Tue, 25 Aug 2020 02:34:26 -0000
Date:   Mon, 24 Aug 2020 20:34:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Will Deacon <will@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fugang Duan <fugang.duan@nxp.com>, Frank Li <frank.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, linux-watchdog@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 06/19] dt-bindings: pwm: imx-pwm: Add i.MX 8M
 compatibles
Message-ID: <20200825023426.GA3830470@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-6-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:39 +0200, Krzysztof Kozlowski wrote:
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
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
