Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F825250F4C
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgHYCfd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:35:33 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41932 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCfa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:35:30 -0400
Received: by mail-il1-f195.google.com with SMTP id q14so9151339ilj.8;
        Mon, 24 Aug 2020 19:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nwawe6M2knG0oRqB4aAeMIgRNRbECD+1OsbG/izAEU4=;
        b=CR2Y4Ljv0uLZEZPEW15s/EnmISDB3CIB4c76cKygkogMMag8Fn+OkGu54SdbptS/vk
         BvJqX9gopLOMu+SVky/95MV1dkM4Sch9SIp20H8R6vrgYnabnQSWcZI+BQIhYO6QHtv/
         yWib8FESwSkTU6xxICuwqKXorHtq0iuZ1Cz4io4nuNl4c9uXd7ZeskvZ8x2JKGvMw8Tn
         7rSPIa3lRvq8EEo9OpjMayGdXNIyOPWgUV3zQnMXtzBpvEqV7rTRuMD315pdoY1haawt
         +JfJX+NOjpae2JorycT5d8IP1U2RCxsAYEThkcfcIVH/4Z/2bhqx2NJAJ8g+819EUCCh
         Jd7g==
X-Gm-Message-State: AOAM532jtvGmdOFCSMWxXPnE1Z2Hdsd3EjN6iYRApNpMHqLJCmqcBT/p
        NIwMxQ+SmRt6gC/RRneXlA0ydVLBNdTd
X-Google-Smtp-Source: ABdhPJwAj/iRt3ci1c1YwSz9E8RvpsvwdZ0N7LJ6yp0fW2ifq2U014hkO6qUMIKaIjZtLMXFYY7aWQ==
X-Received: by 2002:a92:a1c5:: with SMTP id b66mr3912145ill.71.1598322929606;
        Mon, 24 Aug 2020 19:35:29 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r2sm8312783ila.22.2020.08.24.19.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:35:29 -0700 (PDT)
Received: (nullmailer pid 3832494 invoked by uid 1000);
        Tue, 25 Aug 2020 02:35:26 -0000
Date:   Mon, 24 Aug 2020 20:35:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Li <frank.li@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 08/19] dt-bindings: watchdog: fsl-imx-wdt: Add i.MX 8M
 compatibles
Message-ID: <20200825023526.GA3832442@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-8-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:41 +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
>     compatible:0: 'fsl,imx8mm-wdt' is not one of ['fsl,imx21-wdt']
>     From schema: Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
>     compatible: ['fsl,imx8mm-wdt', 'fsl,imx21-wdt'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
>     compatible: Additional items are not allowed ('fsl,imx21-wdt' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml     | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
