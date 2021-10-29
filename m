Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA7B43FF56
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhJ2PXW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2PXV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 11:23:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB5C061570;
        Fri, 29 Oct 2021 08:20:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u21so21705566lff.8;
        Fri, 29 Oct 2021 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lKRvF3HEzsPjmvnhdSOneYxn8GKeq2VyROYToBcwKqg=;
        b=NOKTBqx0zL9etgzmHgf1oJxxEva2iGeeOh+4E1i+Uoun1qXSNBFS1lNQC88fmc/XOx
         EyAsxSZly1bRq3TmlsSW08aYbK/JB9WKiZjvvAc6IRSVBHFLgaxq5WghrNgqH9N06Cgk
         rVszgStQ8TpOhlNS+BEfMv2qPVDnZzTEXL2vamo6PvIjGTbjHy4zAlniV7LCLM4z8qJ+
         3d31fE3KYfU1VMXEHzZS2oldd3BUoObYtPfHaEBGLFbTrlAVq3+HlsjsOz7ean0hjU7/
         HGTTI/1EcTjErLyfGPhmM82MicBuWD5C+m3+1geOb7uZN0RBh1lgz8H3yqSys+vx0w95
         nBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lKRvF3HEzsPjmvnhdSOneYxn8GKeq2VyROYToBcwKqg=;
        b=DtdCc8nFBVBNiUzyMANr4WhkoHsA549H+sXv4E78URiSo9+piTHhCpOs4U8gLv4p/i
         IsksW/OilRaTZ+OVp8m7KKYl9gCZcLIxA1YHB329FG0d/pxbZTsfoytifwIMxcbZ3PRE
         2Codu3bszwTdRSgRfioJP7cQ73Sl8QnBAPG43LyFWOmBssuHpQkt+68NZ+EEcuoL5CdB
         lkjWELY7QFFZldNmw0IrU2ef6ywLB5QqCcI4Fonuk3x17IhZlm+xZIPfe/j831fhFj95
         077famsxRelAgxV3i0aDrvocO6PU+J3UTYAkEzw6Ho0XH3AGdfLnBbkmRX5ZNL1gGOA+
         nSlw==
X-Gm-Message-State: AOAM533X/Xq8BpZVs0UYcZiR9hZ1vjHASl/o1CsxO21S/c3AD+qmie/Q
        6K8r8QplBSOtBS0JGBHstzg=
X-Google-Smtp-Source: ABdhPJxvYqPO801LDBYB4F60HZArGOgVHSUSi60pYfKAJNyhUGpwrMQ1Y80dwIJ4c7MkaVL/b474ZQ==
X-Received: by 2002:a05:6512:228d:: with SMTP id f13mr3384237lfu.491.1635520850816;
        Fri, 29 Oct 2021 08:20:50 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id e5sm28298lfs.52.2021.10.29.08.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 08:20:50 -0700 (PDT)
Subject: Re: [PATCH v14 20/39] pwm: tegra: Add runtime PM and OPP support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20211025224032.21012-1-digetx@gmail.com>
 <20211025224032.21012-21-digetx@gmail.com>
Message-ID: <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
Date:   Fri, 29 Oct 2021 18:20:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211025224032.21012-21-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

26.10.2021 01:40, Dmitry Osipenko пишет:
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
>  	/* Set maximum frequency of the IP */
> -	ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
> +	ret = dev_pm_opp_set_rate(pwm->dev, pwm->soc->max_frequency);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
> -		return ret;
> +		goto put_pm;
>  	}
>  
>  	/*
> @@ -278,7 +294,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->rst)) {
>  		ret = PTR_ERR(pwm->rst);
>  		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
> -		return ret;
> +		goto put_pm;
>  	}
>  
>  	reset_control_deassert(pwm->rst);
> @@ -291,10 +307,15 @@ static int tegra_pwm_probe(struct platform_device *pdev)
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>  		reset_control_assert(pwm->rst);
> -		return ret;
> +		goto put_pm;
>  	}
>  
> +	pm_runtime_put(&pdev->dev);
> +
>  	return 0;
> +put_pm:
> +	pm_runtime_put_sync_suspend(&pdev->dev);
> +	return ret;
>  }
>  
>  static int tegra_pwm_remove(struct platform_device *pdev)
> @@ -305,20 +326,44 @@ static int tegra_pwm_remove(struct platform_device *pdev)
>  
>  	reset_control_assert(pc->rst);
>  
> +	pm_runtime_force_suspend(&pdev->dev);

I just noticed that RPM core doesn't reset RPM-enable count of a device
on driver's unbind (pm_runtime_reinit). It was a bad idea to use
devm_pm_runtime_enable() + pm_runtime_force_suspend() here, since RPM is
disabled twice on driver's removal, and thus, RPM will never be enabled
again.

I'll fix it for PWM and other drivers in this series, in v15.
