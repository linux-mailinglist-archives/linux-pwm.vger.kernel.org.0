Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8012426A1
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgHLIUH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgHLIUH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 04:20:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE291C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 01:20:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so1195439wro.2
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7NOBbVOn6QKABbkrgd79luIka+/z3L9K2Ln2ElACoKM=;
        b=MK2ILWj8NQRHSpjBw+5xrIcK/NBHwuQD4saXOX3vHHN4vncq8RbtT4NAu8ERYhF57/
         jnHgKw6ECpQKsD7BltJkvnJA6lmOePxFHoH/giTZRgB9NxvsTzIsEjXTNF8SiEDC7Krr
         n8EKm5iH7e/oS5TlN0UmyPSqUsNFj6UXmZEir3OO47n6ngkcF/KKDJP3626e5i6ulC6K
         cpqZTkOQ1BzghEdQ3WhBSKLvUyv8BdHhIaNwNLxELbWc7Rq5Z9miA2xpGcmbSyDS6B7w
         yOU9sOJyionWxialYwWUj+zJq8LyEcdSlNxsM3yH6hZerhopXcVeRKvf8VU00J3tRxMV
         yEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7NOBbVOn6QKABbkrgd79luIka+/z3L9K2Ln2ElACoKM=;
        b=Dgjm4hNcOeE2ZegTVl1lmu/lOJaBnw5bSidIkx0hw43djV0FzkYyusQhH/IUyJoz8M
         JQrGNEdpVnm9A++ltHCTJHTuUBu5IVV3LdU6kyie1UN8vMTm3+HjyiZE/NoSAHPQkxJX
         aA9FU5SuxGN0ZHa1U3jElG/AEwKkFP2JBBzXTheGgW2zl6jnYe5QaffohSclfrJNVQCx
         lr5U/7W9CZG/l4eNpbkce0Y2h+jMKHwL57CkBpfvvR7KCgZgVenj1zXdL9QHp4k/e98e
         LCjjinFsRzAgCkO+EM5uB8t7tTrx+PnrWHTKCGVUYy1hw0oDdZWPSf553HBG5/MlsGmZ
         NSqA==
X-Gm-Message-State: AOAM533Beleial0rD3x2yugeME27h7COFi1PZ3TV3ouHSIHVDRoybq2E
        wFunuSXtky8iRS+2czSFHGK7Jg==
X-Google-Smtp-Source: ABdhPJzzg7Q9zdZ1KxmAsx9rEwFfwkQ4TwIkJwncWvsQ1+E6KGBJ2oS/4AJK/42tuiv5uE0rZDYH+g==
X-Received: by 2002:adf:9ec5:: with SMTP id b5mr30840912wrf.190.1597220405051;
        Wed, 12 Aug 2020 01:20:05 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id z15sm2889279wrn.89.2020.08.12.01.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:20:04 -0700 (PDT)
Date:   Wed, 12 Aug 2020 09:20:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: atmel: Make use of dev_err_probe()
Message-ID: <20200812082002.GD4354@dell>
References: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 12 Aug 2020, Uwe Kleine-König wrote:

> Add an error message for failure points that currently lack a message
> and convert dev_err to dev_err_probe() which does the right thing for
> -EPROBE_DEFER. Also slightly simplify the error handling.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-atmel.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 6161e7e3e9ac..aa0b36695dc7 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -415,17 +415,18 @@ static int atmel_pwm_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	atmel_pwm->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(atmel_pwm->base))
> -		return PTR_ERR(atmel_pwm->base);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->base),
> +				     "Failed to remap register space\n");

This is a regression.

devm_ioremap_resource() already emits and error message for !-ENOMEM.

-ENOMEM cases should fail silently.

>  	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(atmel_pwm->clk))
> -		return PTR_ERR(atmel_pwm->clk);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
> +				     "Failed to get clock\n");

Isn't dev_err_probe() only useful for drivers handling -EPROBE_DEFER?

>  	ret = clk_prepare(atmel_pwm->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to prepare PWM clock\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to prepare PWM clock\n");

As above.

>  	atmel_pwm->chip.dev = &pdev->dev;
>  	atmel_pwm->chip.ops = &atmel_pwm_ops;
> @@ -436,17 +437,14 @@ static int atmel_pwm_probe(struct platform_device *pdev)
>  
>  	ret = pwmchip_add(&atmel_pwm->chip);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
> -		goto unprepare_clk;
> +		clk_unprepare(atmel_pwm->clk);
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to add PWM chip\n");
>  	}
>  
>  	platform_set_drvdata(pdev, atmel_pwm);
>  
> -	return ret;
> -
> -unprepare_clk:
> -	clk_unprepare(atmel_pwm->clk);
> -	return ret;
> +	return 0;
>  }
>  
>  static int atmel_pwm_remove(struct platform_device *pdev)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
