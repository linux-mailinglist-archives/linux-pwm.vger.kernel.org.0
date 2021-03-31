Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D5350875
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Mar 2021 22:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhCaUoh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 Mar 2021 16:44:37 -0400
Received: from mleia.com ([178.79.152.223]:58498 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236665AbhCaUoK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 31 Mar 2021 16:44:10 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id A350B44DDA0;
        Wed, 31 Mar 2021 20:37:38 +0000 (UTC)
Subject: Re: [PATCH] pwm: lpc18xx-sct: Free resources only after
 pwmchip_remove()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20210327212428.136684-1-u.kleine-koenig@pengutronix.de>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <3797dc74-5f61-826f-307d-221a39f563af@mleia.com>
Date:   Wed, 31 Mar 2021 23:37:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210327212428.136684-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20210331_203738_688319_D7512929 
X-CRM114-Status: GOOD (  14.85  )
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 3/27/21 11:24 PM, Uwe Kleine-König wrote:
> Before pwmchip_remove() returns the PWM is expected to be functional. So
> remove the pwmchip before disabling the clock.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/pwm/pwm-lpc18xx-sct.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> index 3f8e54ec28c6..b643ac61a2e7 100644
> --- a/drivers/pwm/pwm-lpc18xx-sct.c
> +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> @@ -441,13 +441,15 @@ static int lpc18xx_pwm_remove(struct platform_device *pdev)
>   	struct lpc18xx_pwm_chip *lpc18xx_pwm = platform_get_drvdata(pdev);
>   	u32 val;
>   
> +	pwmchip_remove(&lpc18xx_pwm->chip);
> +
>   	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
>   	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL,
>   			   val | LPC18XX_PWM_CTRL_HALT);
>   
>   	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
>   
> -	return pwmchip_remove(&lpc18xx_pwm->chip);
> +	return 0;
>   }
>   
>   static struct platform_driver lpc18xx_pwm_driver = {
> 

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

A horde of PWM drivers does not satisfy the condition, please check
at least quite popular pwm-rockchip.c, pwm-sti.c, pwm-vt8500.c,
pwm-bcm2835.c etc., again, it would be preferable to see all the
drivers fixed in a single series, thank you.

--
Best wishes,
Vladimir
