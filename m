Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6478D25628A
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Aug 2020 23:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgH1Vi6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 17:38:58 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40618 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgH1Viz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 17:38:55 -0400
Received: by mail-il1-f196.google.com with SMTP id y2so1905101ilp.7;
        Fri, 28 Aug 2020 14:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z9aNuFEY8MHLzwmbgIdHHAKZXLe3aQgkptJsyFL+HWw=;
        b=mI8y56Vyety6L8Vk+sh058Im4xbh3izhfaoT6GLfZDM3AdOy2ZST0dwUBlrTg4KMuK
         EJ3FMpw1J/jb3cR6ru5oQ63hebgS4w/rYL1qqHx/de36z/9M0zPXk2Wh9C2OjUyWkzyZ
         mH/zUPvDhe3q+PK4wX5jAvFkROTCzBj9Zq0zTp6YI6HRLuV8nwsRkWEW0P5eQmCaEFV3
         pZzK+Ro5bq+EGubseHbdB1JRpw311ZitRQJTHDoak8pEryJunDPCqGt6QG6Lcu/TT0gx
         PyA3VeWNePfKFU7tfyFURiFwuuzK6pVSwY8m7+OI+Z2zS7km3m7GP6Z9ZbEJvK9LRmUK
         g9LA==
X-Gm-Message-State: AOAM53032OGGthGk8GkKi4defUO/af1YhPXZ4VkL4xt7smWkqhc4X7cf
        lh/XoRqi1y5SWpkcBs8Pcg==
X-Google-Smtp-Source: ABdhPJzS3P2Iz0zwjThn5mGNinrojy9M8UeF8yi+ZuR6dvHqFhATIGtKUGFyG79NQ/sI23b+DIN6qw==
X-Received: by 2002:a92:79ca:: with SMTP id u193mr669859ilc.185.1598650734133;
        Fri, 28 Aug 2020 14:38:54 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a9sm224951iol.9.2020.08.28.14.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:38:53 -0700 (PDT)
Received: (nullmailer pid 3445893 invoked by uid 1000);
        Fri, 28 Aug 2020 21:38:50 -0000
Date:   Fri, 28 Aug 2020 15:38:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Fugang Duan <fugang.duan@nxp.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
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
Subject: Re: [PATCH v3 12/19] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8
 compatible matching
Message-ID: <20200828213850.GA3444012@bogus>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-13-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825193536.7332-13-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Aug 2020 21:35:29 +0200, Krzysztof Kozlowski wrote:
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
> Changes since v2:
> 1. Remove moved compatibles.
> 
> Changes since v1:
> 1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
> ---
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 37 ++++++++++---------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: compatible: ['fsl,imx8qxp-usdhc'] is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: compatible: ['fsl,imx8qxp-usdhc'] is too short
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: compatible:0: 'fsl,imx8qxp-usdhc' is not one of ['fsl,imx25-esdhc', 'fsl,imx35-esdhc', 'fsl,imx51-esdhc', 'fsl,imx53-esdhc', 'fsl,imx6q-usdhc', 'fsl,imx6sl-usdhc', 'fsl,imx6sx-usdhc', 'fsl,imx6ull-usdhc', 'fsl,imx7d-usdhc', 'fsl,imx7ulp-usdhc']

	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml


See https://patchwork.ozlabs.org/patch/1351360

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

