Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB74250F85
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgHYCjw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:39:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32782 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCjv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:39:51 -0400
Received: by mail-io1-f65.google.com with SMTP id g14so10963661iom.0;
        Mon, 24 Aug 2020 19:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kXuWnJNB67f0o67uiEbC7HbpqwuSzXePhD/ymnLVPqY=;
        b=LRl4EsFAEWOj8AcqVSLifohus55UzS6TmHw0PJX5tVh9UPBlV+jO5zckwN1JyBuDYm
         9mZ6Y5t+8tFmv9annQSID0Koly9smy/avTK8qkX3VyURkj4k4Wbu/h92HRp0nO4CTdnZ
         WVw2JtPT2Lpke/1cYF1NHLzrAWqSW7mGVPLZsFMqY8BEfjFm37nF/hYwkEKY2enTnF0c
         c4zFoT481WB10WmwAQqkD6zq8Z/J8SkV/C0ASCPOz7ItU7Qn0zDqrZoBzELYW/Qd5ogE
         qxyZgAxf7f6eRA8Fv3mDBmQjXRntV11+KdjTl2VYkPiYa8hkg0ItU8ZClSHcC8hI+FqE
         wC3g==
X-Gm-Message-State: AOAM530tqzFvmluc/U+oQsnef1g8geuKGEOvG+FNADI2tXj2rzOQaBFD
        /+M1E/jAGL/U6I8JNlVy1g==
X-Google-Smtp-Source: ABdhPJxunBFaPfYMd0plcVp+IODN52lxJO2aO8iTYtSEHhuOcGJcr0KWWpF0lNocgFZ9g/NcpWXOog==
X-Received: by 2002:a5d:9e59:: with SMTP id i25mr6647752ioi.99.1598323190334;
        Mon, 24 Aug 2020 19:39:50 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q17sm8274459ilt.10.2020.08.24.19.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:39:49 -0700 (PDT)
Received: (nullmailer pid 3839847 invoked by uid 1000);
        Tue, 25 Aug 2020 02:39:46 -0000
Date:   Mon, 24 Aug 2020 20:39:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Han Xu <han.xu@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>, linux-pm@vger.kernel.org,
        Frank Li <frank.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 14/19] dt-bindings: arm: fsl: Fix Toradex Colibri i.MX
 8 binding
Message-ID: <20200825023946.GA3839685@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-14-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-14-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:47 +0200, Krzysztof Kozlowski wrote:
> The Toradex Colibri i.MX 8 Evaluation board has two Toradex compatibles
> so it needs separate entry.  This fixes dtbs_check warning:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dt.yaml: /:
>     compatible: ['toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x', 'fsl,imx8qxp'] is not valid under any of the given schemas (Possible causes of the failure):
>     arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dt.yaml: /: compatible: ['toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x', 'fsl,imx8qxp'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
