Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8C250F36
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgHYCd7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:33:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34062 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHYCd6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:33:58 -0400
Received: by mail-io1-f67.google.com with SMTP id w20so7612409iom.1;
        Mon, 24 Aug 2020 19:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Oeflr950v3vzi5vgtx6gn5KhGz/f3JvqtlRnQZ3nOI=;
        b=PVi2pcktfcTxlMK6P0BUFPF0w5KYlJAJ/yCXjtAYg83knpF/lKsGYz5K98nfOw5T0W
         wIMCB/GfyNpaxfD+K/xcWd2FJpW+FIaqNoGyAV92TiNDqPETsjykK4kC4ke5mz7Acxvw
         CownwI3aN7G0pFw/JHtS7c832NNCFKvqD0h0HMqiBBcwr4V6c5irXDDNTVEtZeX+zUq+
         MMcZTbZURrfKAZ8IxBxOxKfUdug7RA1afXf8xIyNH7AxXJtbBx3UoiwtjcbiBr7ByA8r
         x3AUeG1tR+VyoxW765R9CyknjP3tCcNZUvWjbKsXaiPBot4kbPLMyA15/XB2FGuQLPWf
         NAig==
X-Gm-Message-State: AOAM532HoEG1QeLAqz6ohnBqFbkZYmdXCHJL7YuiWCt1UIzh0SS2REZb
        wQ+r1konfaoE6hhpIQ0ELQ==
X-Google-Smtp-Source: ABdhPJxcLnIE5DG8OXE3nWKElArXouriTFLBAy0h+AmmjKjL5G26cEcxX6Jf8o8sMG44HpmpURSJUA==
X-Received: by 2002:a02:8791:: with SMTP id t17mr8167190jai.68.1598322836741;
        Mon, 24 Aug 2020 19:33:56 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id e22sm180808ioc.43.2020.08.24.19.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:33:56 -0700 (PDT)
Received: (nullmailer pid 3829700 invoked by uid 1000);
        Tue, 25 Aug 2020 02:33:52 -0000
Date:   Mon, 24 Aug 2020 20:33:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        linux-gpio@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-serial@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Frank Li <frank.li@nxp.com>, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 05/19] dt-bindings: perf: fsl-imx-ddr: Add i.MX 8M
 compatibles
Message-ID: <20200825023352.GA3829646@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-5-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:38 +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: ddr-pmu@3d800000:
>     compatible:0: 'fsl,imx8mm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
>     From schema: Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: ddr-pmu@3d800000:
>     compatible: ['fsl,imx8mm-ddr-pmu', 'fsl,imx8m-ddr-pmu'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: ddr-pmu@3d800000:
>     compatible: Additional items are not allowed ('fsl,imx8m-ddr-pmu' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Handle also fsl,imx8mp-ddr-pmu
> ---
>  .../devicetree/bindings/perf/fsl-imx-ddr.yaml    | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
