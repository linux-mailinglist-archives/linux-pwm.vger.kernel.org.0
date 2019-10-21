Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F4BDEE54
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfJUNti (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 09:49:38 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:51996 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfJUNti (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 21 Oct 2019 09:49:38 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id A3A1CA28BA;
        Mon, 21 Oct 2019 15:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571665776;
        bh=8w3DkTso2wMiC0FF5ZMH5BUlTSmHT1UzRk9c+xW3VSo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KvCa5x0i6vuIMU0TZqbUklVW2b1YW0e8Ij9D29ALcnkpDGc/vXkFEydwFyZAX6pZC
         eOVcz5bx5+OnrWygXZOFOZEv6RVltEX/oRto27+TAGNicUzyfUgA9nw7rZaZP0uPp4
         g00dDYNKBASY/kjwK1TfC2LtQ15R/WqLT0nhV8m8=
Subject: Re: [PATCH 4/4] pwm: imx27: Unconditionally write state to hardware
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org, Adam Ford <aford173@gmail.com>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021105739.1357629-4-thierry.reding@gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <5e129df5-1110-29ea-35ce-4c2274b135fe@ysoft.com>
Date:   Mon, 21 Oct 2019 15:49:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021105739.1357629-4-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

+Adam

On 21. 10. 19 12:57, Thierry Reding wrote:
> The i.MX driver currently uses a shortcut and doesn't write all of the
> state through to the hardware when the PWM is disabled. This causes an
> inconsistent state to be read back by consumers with the result of them
> malfunctioning.
> 
> Fix this by always writing the full state through to the hardware
> registers so that the correct state can always be read back.

Gave it another shot and got expected results.

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>   drivers/pwm/pwm-imx27.c | 120 ++++++++++++++++++++--------------------
>   1 file changed, 59 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 4113d5cd4c62..59d8b1289808 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -230,70 +230,68 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   
>   	pwm_get_state(pwm, &cstate);
>   
> -	if (state->enabled) {
> -		c = clk_get_rate(imx->clk_per);
> -		c *= state->period;
> -
> -		do_div(c, 1000000000);
> -		period_cycles = c;
> -
> -		prescale = period_cycles / 0x10000 + 1;
> -
> -		period_cycles /= prescale;
> -		c = (unsigned long long)period_cycles * state->duty_cycle;
> -		do_div(c, state->period);
> -		duty_cycles = c;
> -
> -		/*
> -		 * according to imx pwm RM, the real period value should be
> -		 * PERIOD value in PWMPR plus 2.
> -		 */
> -		if (period_cycles > 2)
> -			period_cycles -= 2;
> -		else
> -			period_cycles = 0;
> -
> -		/*
> -		 * Wait for a free FIFO slot if the PWM is already enabled, and
> -		 * flush the FIFO if the PWM was disabled and is about to be
> -		 * enabled.
> -		 */
> -		if (cstate.enabled) {
> -			pwm_imx27_wait_fifo_slot(chip, pwm);
> -		} else {
> -			ret = pwm_imx27_clk_prepare_enable(chip);
> -			if (ret)
> -				return ret;
> -
> -			pwm_imx27_sw_reset(chip);
> -		}
> -
> -		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> -		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> -
> -		/*
> -		 * Store the duty cycle for future reference in cases where
> -		 * the MX3_PWMSAR register can't be read (i.e. when the PWM
> -		 * is disabled).
> -		 */
> -		imx->duty_cycle = duty_cycles;
> -
> -		cr = MX3_PWMCR_PRESCALER_SET(prescale) |
> -		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> -		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> -		     MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
> -
> -		if (state->polarity == PWM_POLARITY_INVERSED)
> -			cr |= FIELD_PREP(MX3_PWMCR_POUTC,
> -					MX3_PWMCR_POUTC_INVERTED);
> -
> -		writel(cr, imx->mmio_base + MX3_PWMCR);
> -	} else if (cstate.enabled) {
> -		writel(0, imx->mmio_base + MX3_PWMCR);
> +	c = clk_get_rate(imx->clk_per);
> +	c *= state->period;
>   
> -		pwm_imx27_clk_disable_unprepare(chip);
> +	do_div(c, 1000000000);
> +	period_cycles = c;
> +
> +	prescale = period_cycles / 0x10000 + 1;
> +
> +	period_cycles /= prescale;
> +	c = (unsigned long long)period_cycles * state->duty_cycle;
> +	do_div(c, state->period);
> +	duty_cycles = c;
> +
> +	/*
> +	 * according to imx pwm RM, the real period value should be PERIOD
> +	 * value in PWMPR plus 2.
> +	 */
> +	if (period_cycles > 2)
> +		period_cycles -= 2;
> +	else
> +		period_cycles = 0;
> +
> +	/*
> +	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
> +	 * the FIFO if the PWM was disabled and is about to be enabled.
> +	 */
> +	if (cstate.enabled) {
> +		pwm_imx27_wait_fifo_slot(chip, pwm);
> +	} else {
> +		ret = pwm_imx27_clk_prepare_enable(chip);
> +		if (ret)
> +			return ret;
> +
> +		pwm_imx27_sw_reset(chip);
>   	}
>   
> +	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> +
> +	/*
> +	 * Store the duty cycle for future reference in cases where the
> +	 * MX3_PWMSAR register can't be read (i.e. when the PWM is disabled).
> +	 */
> +	imx->duty_cycle = duty_cycles;
> +
> +	cr = MX3_PWMCR_PRESCALER_SET(prescale) |
> +	     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +	     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> +	     MX3_PWMCR_DBGEN;
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED)
> +		cr |= FIELD_PREP(MX3_PWMCR_POUTC,
> +				MX3_PWMCR_POUTC_INVERTED);
> +
> +	if (state->enabled)
> +		cr |= MX3_PWMCR_EN;
> +
> +	writel(cr, imx->mmio_base + MX3_PWMCR);
> +
> +	if (!state->enabled && cstate.enabled)
> +		pwm_imx27_clk_disable_unprepare(chip);
> +
>   	return 0;
>   }
>   
> 

