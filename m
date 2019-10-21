Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC62DEE3D
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfJUNqd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 09:46:33 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:51622 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbfJUNqc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 21 Oct 2019 09:46:32 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 5AD3BA28A1;
        Mon, 21 Oct 2019 15:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571665591;
        bh=DWrDkh3CC34kwPGwrJHYOHLVPB7shUeBd0rvDQaRTy4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=prQYh4onzGkokDSrDvv+ZirCn3Db5wbmxMAFYKfl3hi3u4k+Ue2VTdpIT+MZvxV4Q
         dYul8dlE8iAX+EyY/bcJIUzF27PZUgozS++s0bB8kfP6/vD0NBqTJiH+6CId/5IR61
         EJ3UO1Ho22rtkezHsxrG6+M0tWjNRvga05OM/KAk=
Subject: Re: [PATCH 3/4] pwm: imx27: Cache duty cycle register value
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org, Adam Ford <aford173@gmail.com>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021105739.1357629-3-thierry.reding@gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <5e6c86a1-932c-77ce-3501-f03d03e4c963@ysoft.com>
Date:   Mon, 21 Oct 2019 15:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021105739.1357629-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

+Adam

On 21. 10. 19 12:57, Thierry Reding wrote:
> The hardware register containing the duty cycle value cannot be accessed
> when the PWM is disabled. This causes the ->get_state() callback to read
> back a duty cycle value of 0, which can confuse consumer drivers.

Me and Adam Ford already tested the patches [3/4] and [4/4] and gave ours
Tested-by tags in the previous thread but do not see those here.
I re-tested these again and have no issues.

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

Thank you Thierry,
Michal


> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>   drivers/pwm/pwm-imx27.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index ae11d8577f18..4113d5cd4c62 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -85,6 +85,13 @@ struct pwm_imx27_chip {
>   	struct clk	*clk_per;
>   	void __iomem	*mmio_base;
>   	struct pwm_chip	chip;
> +
> +	/*
> +	 * The driver cannot read the current duty cycle from the hardware if
> +	 * the hardware is disabled. Cache the last programmed duty cycle
> +	 * value to return in that case.
> +	 */
> +	unsigned int duty_cycle;
>   };
>   
>   #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
> @@ -155,14 +162,17 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
>   	tmp = NSEC_PER_SEC * (u64)(period + 2);
>   	state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>   
> -	/* PWMSAR can be read only if PWM is enabled */
> -	if (state->enabled) {
> +	/*
> +	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
> +	 * use the cached value.
> +	 */
> +	if (state->enabled)
>   		val = readl(imx->mmio_base + MX3_PWMSAR);
> -		tmp = NSEC_PER_SEC * (u64)(val);
> -		state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> -	} else {
> -		state->duty_cycle = 0;
> -	}
> +	else
> +		val = imx->duty_cycle;
> +
> +	tmp = NSEC_PER_SEC * (u64)(val);
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>   
>   	if (!state->enabled)
>   		pwm_imx27_clk_disable_unprepare(chip);
> @@ -261,6 +271,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>   		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>   
> +		/*
> +		 * Store the duty cycle for future reference in cases where
> +		 * the MX3_PWMSAR register can't be read (i.e. when the PWM
> +		 * is disabled).
> +		 */
> +		imx->duty_cycle = duty_cycles;
> +
>   		cr = MX3_PWMCR_PRESCALER_SET(prescale) |
>   		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
>   		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> 

