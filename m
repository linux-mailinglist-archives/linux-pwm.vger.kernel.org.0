Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF1250F1A
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHYCce (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:32:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37139 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgHYCcd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:32:33 -0400
Received: by mail-io1-f65.google.com with SMTP id b16so10953992ioj.4;
        Mon, 24 Aug 2020 19:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7KciK30hDT4IlL7lDKGSYcOlh8cg0x0DxyNMRO7d9s=;
        b=ocP77fQHvBptY5B8v2ZRXs1+1ZGCIeC/fbK9h8lGUyUg6DQ45SV6pyJ95si0nyS0JU
         QzU/ziZpxnlC1aHmyn5yIvyhyh9qDNUTdpnIMI7rzocCo5Z/Htp13BYGX2e0smDzfWUf
         G4JSbrUr+6Hh8v2P/DtMooXMlcQfixDM6puJe1x+wXR8i3VwLC9c0XdOABRkWzyWczWW
         zGjO7gAHbZEBMnNQRdykVhytbQ8Kp0phduBA8CwxN09fh4kio6dXhvmTlg7el8qJWN5j
         lJhjI3l90Kmdw7Gf31wCiVHw10Sk7qWbA49emYtExw0Dxz7hO2PlH+22xLA0eqIlF2tO
         9Oqg==
X-Gm-Message-State: AOAM5334xWxkmI/J35PjJZY5sz8xZioFcAyB9nMAEpHaGRppTrEmnWTn
        ui9nicVBnWwrdyct+mbPaQ==
X-Google-Smtp-Source: ABdhPJyfnrC4tnlsuKbCBqgnhoTbJuRG/yfQAT84rblWL1SmBAkv4OCRcUi6JkOfCOiyBjBdYvAh4g==
X-Received: by 2002:a05:6602:13d3:: with SMTP id o19mr7442287iov.32.1598322752468;
        Mon, 24 Aug 2020 19:32:32 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q133sm4299314iod.38.2020.08.24.19.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:32:31 -0700 (PDT)
Received: (nullmailer pid 3827162 invoked by uid 1000);
        Tue, 25 Aug 2020 02:32:26 -0000
Date:   Mon, 24 Aug 2020 20:32:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-mmc@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-watchdog@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Frank Li <frank.li@nxp.com>,
        linux-mtd@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 02/19] dt-bindings: gpio: fsl-imx-gpio: Add
 gpio-ranges property
Message-ID: <20200825023226.GA3827096@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-2-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:35 +0200, Krzysztof Kozlowski wrote:
> The GPIO controller node can have gpio-ranges property.  This fixes
> dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000: 'gpio-ranges' does not match any of the regexes: 'pinctrl-[0-9]+'
>     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Remove maxItems
> ---
>  Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
