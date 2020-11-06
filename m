Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C692A9147
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Nov 2020 09:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKFI3T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Nov 2020 03:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFI3S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2020 03:29:18 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF7C0613CF
        for <linux-pwm@vger.kernel.org>; Fri,  6 Nov 2020 00:29:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c18so518396wme.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Nov 2020 00:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=g2qcQaIAtpx8WYLEFeGSc015ofGbPNizk4EfaCI93g8=;
        b=JHePWUTtIk/BBzMBNpFJt6i9cdIAiRXOtUJWJt6TUNj1SzEKexEbIp33Q+ivt/eWey
         ml8I8KTBCrUnjQ6yisEfV29lvAzwTbp1O4jwMAA+CJVe5Gt8KDlRBUywWtogAQ3Sc/9v
         7t6Bv8ouRhfe83w/jIHgKgUacSXFQZnGfgD1sxcfGg6EgijoHlLrSSa5B8ryGS2zvdbt
         R+LpThopz/E6oSHHhLA2a3tR/qx0aqqTZKBBkitu1MEa+2b2vwfgppjRdE+FdKIMDIwT
         6Jet9ZRrd/EgW6sPRn2GA+8uN3A/v3dx28uqvWivaajMxP6sJEN3r928ECOSGrmJbZ9k
         VVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g2qcQaIAtpx8WYLEFeGSc015ofGbPNizk4EfaCI93g8=;
        b=JpkoADRkGfO43DR7q91B/ySW0+7B/lV1WMFyiVA1uM/gG1Gd+DCvvihCyRtWRqYkHK
         IYsAfA04lZRL9EStFGBWOi0bQi5ql+2mhk9a1oGVQwUTe3UUTlTqrIgHnTjLuwJ/7GNc
         VTNv63YrSDQEULn79PIsxOfky+jmPwpj1+tgLiNjP/eXGmV1NrX/HjOI+KO2tktam3LH
         D8AYqpkBJFy8jRCK4N9bJsscAJs2mjlI+scmbe/3AXiNsbvDWxbXemSjaTufb1UQgcP2
         hJLgjBw15QsRfscl3JRHHPn3sB8+X0OATZogOhTUMHZU8y9kjOTWGmMezHLlWRwaEOv8
         E/mQ==
X-Gm-Message-State: AOAM533wavz4HLzUYnOpGQV0KgbEhHX3EuyW4ouv2Uv7+EIQ1soApeTV
        RukB1kut4Jmg08OWDlyRH/QW6g==
X-Google-Smtp-Source: ABdhPJztYYnhSN0ifh2Nm1qig5FKDSg5POm2uW8eOgqOcutf6f4pvcdvb3AgpkFK+c3D7q/SxfQkXw==
X-Received: by 2002:a1c:b746:: with SMTP id h67mr1113797wmf.43.1604651357227;
        Fri, 06 Nov 2020 00:29:17 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id u3sm939887wrq.19.2020.11.06.00.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 00:29:16 -0800 (PST)
Date:   Fri, 6 Nov 2020 08:29:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Ajit Pal Singh <ajitpal.singh@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sti: fix error handling
Message-ID: <20201106082914.GX4488@dell>
References: <20201013081531.661528-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201013081531.661528-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 13 Oct 2020, Uwe Kleine-König wrote:

> This commit fixes several faults:
> 
>  - Iff a clk was returned by of_clk_get_by_name() it must be dereferenced
>    by calling clk_put().
>  - A clk that was prepared must be unprepared.
>  - The .remove callback isn't supposed to call pwm_disable().
>  - The necessary resources needed by the PWM must not be freed before
>    pwmchip_remove() was called.
> 
> Fixes: 378fe115d19d ("pwm: sti: Add new driver for ST's PWM IP")
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  drivers/pwm/pwm-sti.c | 49 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 12 deletions(-)

Sorry for the delay, this ended up in spam.

> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index 1508616d794c..f89f8cbdfdfc 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -605,7 +605,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	ret = clk_prepare(pc->pwm_clk);
>  	if (ret) {
>  		dev_err(dev, "failed to prepare clock\n");
> -		return ret;
> +		goto err_pwm_clk_prepare;

I would prefer these to indicate the intention, rather than were they
were called from.  So err_put_cpt_clk for this one, etc.

>  	}
>  
>  skip_pwm:
> @@ -615,13 +615,14 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
>  	if (IS_ERR(pc->cpt_clk)) {
>  		dev_err(dev, "failed to get PWM capture clock\n");
> -		return PTR_ERR(pc->cpt_clk);
> +		ret = PTR_ERR(pc->cpt_clk);
> +		goto err_cpt_clk_get;

err_unprepare_pwm_clk, etc.

>  	}
>  
>  	ret = clk_prepare(pc->cpt_clk);
>  	if (ret) {
>  		dev_err(dev, "failed to prepare clock\n");
> -		return ret;
> +		goto err_cpt_clk_prepare;
>  	}
>  
>  skip_cpt:
> @@ -632,9 +633,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  
>  	ret = pwmchip_add(&pc->chip);
>  	if (ret < 0) {
> -		clk_unprepare(pc->pwm_clk);
> -		clk_unprepare(pc->cpt_clk);
> -		return ret;
> +		goto err_pwmchip_add;
>  	}
>  
>  	for (i = 0; i < cdata->cpt_num_devs; i++) {
> @@ -653,20 +652,46 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, pc);
>  
>  	return 0;
> +
> +err_pwmchip_add:
> +
> +	if (cdata->cpt_num_devs) {

No need for the evaluations, clk_*() calls are NULL safe.

> +		clk_unprepare(pc->cpt_clk);
> +err_cpt_clk_prepare:
> +
> +		clk_put(pc->cpt_clk);
> +	}
> +err_cpt_clk_get:
> +
> +	if (cdata->pwm_num_devs) {
> +		clk_unprepare(pc->pwm_clk);
> +err_pwm_clk_prepare:
> +
> +		clk_put(pc->pwm_clk);
> +	}
> +	return ret;
>  }
>  
>  static int sti_pwm_remove(struct platform_device *pdev)
>  {
>  	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
> -	unsigned int i;
> +	int ret;
> +
> +	ret = pwmchip_remove(&pc->chip);
> +	if (ret)
> +		return ret;
>  
> -	for (i = 0; i < pc->cdata->pwm_num_devs; i++)
> -		pwm_disable(&pc->chip.pwms[i]);
> +	if (pc->cdata->cpt_num_devs) {
> +		clk_unprepare(pc->cpt_clk);
> +		clk_put(pc->cpt_clk);
> +	}
>  
> -	clk_unprepare(pc->pwm_clk);
> -	clk_unprepare(pc->cpt_clk);
> +	if (pc->cdata->pwm_num_devs) {
> +		clk_unprepare(pc->pwm_clk);
> +		clk_put(pc->pwm_clk);
> +	}

Again, no need for the evaluations, just call clk_{unprepare,put}.

> -	return pwmchip_remove(&pc->chip);
> +	return 0;
>  }
>  
>  static const struct of_device_id sti_pwm_of_match[] = {

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
