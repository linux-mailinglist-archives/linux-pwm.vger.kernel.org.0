Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A982A1482
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Oct 2020 10:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgJaJJ6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 31 Oct 2020 05:09:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56670 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJJ5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 31 Oct 2020 05:09:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09V99pVb081480;
        Sat, 31 Oct 2020 04:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604135391;
        bh=WbGNAAaucwcB4k4vsrUnfDjrcr6a/clWL9fmlz8yp8o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xRbhbGb/sm98PE2G6aYqqKj0+W7xEhnu/N/s9ZrpXhwYAr6kTduw/BC6FYhAfQAn8
         LcKIPq3qdZvP489XWTmSD5K2h2h7fQw0LSkU/kUFShvCm+kpiwusbvvCtqTKyvsC4v
         OdBvsj5jeHm1RAWCkHH1YUD+Xz1Fy+GzXwEtaRT8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09V99paq022157
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 31 Oct 2020 04:09:51 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 31
 Oct 2020 04:09:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 31 Oct 2020 04:09:22 -0500
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09V99JV3016108;
        Sat, 31 Oct 2020 04:09:20 -0500
Subject: Re: [PATCH] pwm: tiehrpwm: handle deferred probe with dev_err_probe()
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, <linux-pwm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20201030201254.24557-1-grygorii.strashko@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <16e36940-1cae-a7f3-a024-7a772d0ad5f5@ti.com>
Date:   Sat, 31 Oct 2020 14:39:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030201254.24557-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10/31/20 1:42 AM, Grygorii Strashko wrote:
> The devm_clk_get() may return -EPROBE_DEFER which is not handled properly
> by TI EHRPWM driver and causes unnecessary boot log messages.
> 
> Hence, add proper deferred probe handling with new dev_err_probe() API.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  drivers/pwm/pwm-tiehrpwm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 0846917ff2d2..14c8fdcfd607 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -437,10 +437,8 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "failed to get clock\n");
> -		return PTR_ERR(clk);
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "Failed to get fck\n");
>  
>  	pc->clk_rate = clk_get_rate(clk);
>  	if (!pc->clk_rate) {
> @@ -462,10 +460,8 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
>  
>  	/* Acquire tbclk for Time Base EHRPWM submodule */
>  	pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
> -	if (IS_ERR(pc->tbclk)) {
> -		dev_err(&pdev->dev, "Failed to get tbclk\n");
> -		return PTR_ERR(pc->tbclk);
> -	}
> +	if (IS_ERR(pc->tbclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pc->tbclk), "Failed to get tbclk\n");
>  
>  	ret = clk_prepare(pc->tbclk);
>  	if (ret < 0) {
> 
