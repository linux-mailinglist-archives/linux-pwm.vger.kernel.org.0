Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DDE250F2D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHYCdh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:33:37 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38958 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgHYCdg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:33:36 -0400
Received: by mail-il1-f194.google.com with SMTP id f12so9143166ils.6;
        Mon, 24 Aug 2020 19:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6zcl9nCoEQ0u0eLSFawMmRGQMStZIBzVgwtuG2w1Uk=;
        b=hzdObGrohZ+858UyIlkLLys2qRlSYcqSdT+rgHR04cqqlj7Qm8Yd1X1zY+I310pNGR
         /wzzEof93QHr7zxMhJihopLogFbV/eXJfJy/o5DWeL2LUi+05pKnhdzQzBWOxrkiPWyS
         W/tQ6zCsU5CHwuos/uNN0NSW/e0xDMWi3FuATNi/b5jAKUnuhgMlS+6O7KoUlY6H7IvY
         EF91vu9PfqMDV7oS2tL09AwlLBk24+m94OKAEN54q8uEUHnOA/qYP9AYBrGqqUdkCNCX
         /aLOTDAopKdPHxgsTfdp1QSRXLlE/6TRKcsBR26+0NMmrgcJZLRPdDDNEHiG516stVwM
         fAUg==
X-Gm-Message-State: AOAM530em7kaqzYY/o826+Un/hl4kxNRHxsyHJ4PKp/N7qTP4HLnlr1o
        AvI8dFEmZ8GLH8Qdy4+7hA==
X-Google-Smtp-Source: ABdhPJxzDQD6UJS360OlRuKUPGDi0iweRSbnDXeLDCx5d6itJYQulbCHh6htCI6mNplUOHjpRzWzMA==
X-Received: by 2002:a92:c502:: with SMTP id r2mr7831142ilg.223.1598322815457;
        Mon, 24 Aug 2020 19:33:35 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c90sm8514073ilf.30.2020.08.24.19.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:33:34 -0700 (PDT)
Received: (nullmailer pid 3829020 invoked by uid 1000);
        Tue, 25 Aug 2020 02:33:30 -0000
Date:   Mon, 24 Aug 2020 20:33:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Frank Li <frank.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Han Xu <han.xu@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-watchdog@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 04/19] dt-bindings: gpio: fsl-imx-gpio: Add
 power-domains
Message-ID: <20200825023330.GA3828938@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-4-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:37 +0200, Krzysztof Kozlowski wrote:
> Parse also optional power-domains property to fix dtbs_check warnings
> like:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: gpio@5d080000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
>     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
