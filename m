Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9424250F23
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgHYCdM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:33:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35640 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgHYCdL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:33:11 -0400
Received: by mail-io1-f66.google.com with SMTP id s2so10967190ioo.2;
        Mon, 24 Aug 2020 19:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H43msI5JRj2LcMenKGEQmRG6E4wQR/7Y4OelHrbihrY=;
        b=GeWUj/loMbz1atv4PnSB6PKW7UDQ6IOXMuz8KKP4R1gDzxFq3i1FGpqtYhxjEx+d9W
         0PI1lPxkVi17oyDckgciC9En0hQA5BtyHMhZaw6A+PUoc72B/rK+VV3qbpqv9HB8hHzB
         AoqYETHcEOiObbL83Bn0c+vNqZu7ofknblTHM8rI6j43HeZ65A4L0zo1Kv4Yat8c9nW0
         nTmBVBEiXPisjhTtJq+0Pdcyj9M77LAZe3rtPToebyBd/tR4bxELzyxHHEWDhDaGE+rC
         djss+5oqNy9h33OU+zN+2hptDMzn52IKtwhPBbPGXxaTCUBci76sB76X4S6aoko9Oi3H
         cniw==
X-Gm-Message-State: AOAM533Ni03F/qeWRBumtUs26ylitWO5NbviMz2GVVKygPK9vzqJylzg
        SQ+4jBb2w7g9YCsvdhFHkQ==
X-Google-Smtp-Source: ABdhPJwjKm9OGBSvE9aaROVwZBpZ1qegEuRkx0HYDWuDxHGrCBG6Ojcc63Xg2qHI6mLFPrK8gEU30w==
X-Received: by 2002:a5d:9344:: with SMTP id i4mr7316042ioo.106.1598322789714;
        Mon, 24 Aug 2020 19:33:09 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id z9sm8181875ilm.78.2020.08.24.19.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:33:09 -0700 (PDT)
Received: (nullmailer pid 3828275 invoked by uid 1000);
        Tue, 25 Aug 2020 02:33:06 -0000
Date:   Mon, 24 Aug 2020 20:33:06 -0600
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
Subject: Re: [PATCH v2 03/19] dt-bindings: gpio: fsl-imx-gpio: Add parsing of
 hogs
Message-ID: <20200825023306.GA3827348@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-3-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 06:26:36PM +0200, Krzysztof Kozlowski wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs to fix
> warning:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: gpio@30240000: 'wl-reg-on' does not match any of the regexes: 'pinctrl-[0-9]+'
>     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml

The below change isn't going to fix 'wl-reg-on'?

> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/gpio/fsl-imx-gpio.yaml  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> index dffd9171ea66..620a52f944e8 100644
> --- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> @@ -53,6 +53,23 @@ properties:
>  
>    gpio-ranges: true
>  
> +patternProperties:
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> +    type: object
> +    properties:
> +      gpio-hog: true
> +      gpios: true
> +      input: true
> +      output-high: true
> +      output-low: true
> +      line-name: true
> +
> +    required:
> +      - gpio-hog
> +      - gpios
> +
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.17.1
> 
