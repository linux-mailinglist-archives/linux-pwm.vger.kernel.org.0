Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42D82B016C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 09:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKLI7Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 03:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKLI7P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 03:59:15 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07AC0613D1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 00:59:13 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c16so4733732wmd.2
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 00:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DoKPA3DjQ4Sg3wbXE9CwZA8PqbIPJSfKBlSjeNrNQvk=;
        b=G/Vm1ECOIq544UQ5EnVk+7RioeC9M2F0lNRgTy2+1F5KonXnM1lspD4fmLEzfECRGD
         21Ts0c6MRQdbRVrC+AYaU+Nhn1nNt2zU3FM+lCJ1ezS2BS/2NZ1HsT66Im88TSMoVzZc
         mrxG9OmNMXq8/ih9Ua2ob7iIaL2LaG1FOc8rp+Os5Vy2npT/smanJAJsRGStuP2tCrkf
         GcmP+P2oywLR7m/tslFcAPbOQPBW/k6rvbPLLytPl0Kav+gDnFAhS/IqBiLozZ5BSXL/
         OLhrC8u+fnqE4wnSMf8PAWT1XWxIMm5J09Phw8Uw//AQFmnOcFPzgSPQ7aOQIDdKeAR1
         ILcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DoKPA3DjQ4Sg3wbXE9CwZA8PqbIPJSfKBlSjeNrNQvk=;
        b=QTaLtGN6cfQyApO1n/VBdOcrD6FAWwTEIHGYbQM28Mav2/wLVhuIVLjWqixvaoxO+L
         s+HoiFkAJmrSznz4IXSY+ixPoGbJ2X3v2Tu+j8Dos88lEVA9MEO+GO2//+S5zmV9vcCx
         qUityuTFLMq2fsN3Ijz+IycZ3MkrmYeKLAByIEY7BOcAtihqROL3pm8YYcrkEqY6bmvr
         2D/UicCZ5ZOXQkpURqkzMqY/VrnQbyqpdh4e5GHIKa4DAcPJVDVRxH5sIKBrHQeqRfOK
         dO0NvulVo5d2+fxWXAGIWC4aXtUB2HcYVOik7W6QcpRr2xcOvv8gGlkryutD3bZiy+ao
         Ipxg==
X-Gm-Message-State: AOAM532xLoXfbHZYD/GkncikWt464dpXk0D0c6DaCneIBQZSq7iEdJrJ
        t4/xfmWjN8c7vWj8bovjc7wqhA==
X-Google-Smtp-Source: ABdhPJz5+FjYyEmeU9+evjTf4zY4ieO9Y8uNvX2OQB4qwfwi1RMDQ+Odh4haTAiNwlD6WXENPiJNfg==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr8277925wmj.187.1605171552533;
        Thu, 12 Nov 2020 00:59:12 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id j127sm6175229wma.31.2020.11.12.00.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 00:59:11 -0800 (PST)
Date:   Thu, 12 Nov 2020 08:59:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: sti: Avoid conditional gotos
Message-ID: <20201112085910.GT2063125@dell>
References: <20201111191449.409402-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111191449.409402-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 11 Nov 2020, Thierry Reding wrote:

> Using gotos for conditional code complicates this code significantly.
> Convert the code to simple conditional blocks to increase readability.
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-sti.c | 53 ++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index a1392255955f..c6c82724d327 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -590,48 +590,43 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (!cdata->pwm_num_devs)
> -		goto skip_pwm;
> -
> -	pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
> -	if (IS_ERR(pc->pwm_clk)) {
> -		dev_err(dev, "failed to get PWM clock\n");
> -		return PTR_ERR(pc->pwm_clk);
> -	}
> +	if (cdata->pwm_num_devs) {
> +		pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
> +		if (IS_ERR(pc->pwm_clk)) {
> +			dev_err(dev, "failed to get PWM clock\n");
> +			return PTR_ERR(pc->pwm_clk);
> +		}
>  
> -	ret = clk_prepare(pc->pwm_clk);
> -	if (ret) {
> -		dev_err(dev, "failed to prepare clock\n");
> -		goto put_pwm_clk;
> +		ret = clk_prepare(pc->pwm_clk);
> +		if (ret) {
> +			dev_err(dev, "failed to prepare clock\n");
> +			goto put_pwm_clk;
> +		}
>  	}
>  
> -skip_pwm:
> -	if (!cdata->cpt_num_devs)
> -		goto skip_cpt;
> -
> -	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
> -	if (IS_ERR(pc->cpt_clk)) {
> -		dev_err(dev, "failed to get PWM capture clock\n");
> -		ret = PTR_ERR(pc->cpt_clk);
> -		goto unprepare_pwm_clk;
> -	}
> +	if (cdata->cpt_num_devs) {
> +		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
> +		if (IS_ERR(pc->cpt_clk)) {
> +			dev_err(dev, "failed to get PWM capture clock\n");
> +			ret = PTR_ERR(pc->cpt_clk);
> +			goto unprepare_pwm_clk;
> +		}
>  
> -	ret = clk_prepare(pc->cpt_clk);
> -	if (ret) {
> -		dev_err(dev, "failed to prepare clock\n");
> -		goto put_cpt_clk;
> +		ret = clk_prepare(pc->cpt_clk);
> +		if (ret) {
> +			dev_err(dev, "failed to prepare clock\n");
> +			goto put_cpt_clk;
> +		}
>  	}
>  
> -skip_cpt:
>  	pc->chip.dev = dev;
>  	pc->chip.ops = &sti_pwm_ops;
>  	pc->chip.base = -1;
>  	pc->chip.npwm = pc->cdata->pwm_num_devs;
>  
>  	ret = pwmchip_add(&pc->chip);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		goto unprepare_cpt_clk;
> -	}

Sneaky!

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
