Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED410438495
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Oct 2021 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhJWRxS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 Oct 2021 13:53:18 -0400
Received: from gofer.mess.org ([88.97.38.141]:60225 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhJWRxS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 23 Oct 2021 13:53:18 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id DA821C6373; Sat, 23 Oct 2021 18:50:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635011456; bh=w6/Vb/dHuIEUjgvrPKQDTkK8M/HPQZ80twouA58ZL/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tvoCaA/EMin/2BfycXtwi2CZ/NnpHe0r1nWfxH8pyu1Pqk9uCIUGcLL8t5pOXcsu5
         E5OuQ2ToeTdY7zjJhOJ+5PVvn2dzmX0ZUpS1ws2ZstqMEpb/IMPlbuL/LZAVP1VphX
         kqznslSMPQUEX8VGJcUtCPJRvJaj8Sj5M1mZNgduuQDUsiLeJvxDc6lxmt0Cqkt25E
         thUGdMd25aubi1qd6TRpfK0NIAd0ervR0ZP1GKwFooEHIzRETIUCeqiIVY05tfQt8O
         kMV9YlDNmSimM3yhcdOU7kuu72xujeU8QIYkCXjzHo99F+9gB7Q+80VJwt75uRK1T7
         EVyexuRc3PXAw==
Date:   Sat, 23 Oct 2021 18:50:56 +0100
From:   Sean Young <sean@mess.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211023175056.GA26584@gofer.mess.org>
References: <YXRE5i9xXpwSjicO@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXRE5i9xXpwSjicO@fedora>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Maíra,

Your patch looks good, just some very minor nits.

On Sat, Oct 23, 2021 at 02:22:46PM -0300, Maíra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
>  drivers/media/rc/pwm-ir-tx.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index 4bc28d2c9cc9..dfaa6125991e 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -53,6 +53,7 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>  {
>  	struct pwm_ir *pwm_ir = dev->priv;
>  	struct pwm_device *pwm = pwm_ir->pwm;
> +	struct pwm_state state;
>  	int i, duty, period;
>  	ktime_t edge;
>  	long delta;
> @@ -60,15 +61,19 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>  	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
>  	duty = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
>  
> -	pwm_config(pwm, duty, period);
> +	pwm_init_state(pwm, &state);
> +
> +	state.duty_cycle = duty;
> +	state.period = period;

There is no reason to have the period and duty local variables any more;
the result of DIV_ROUND_CLOSEST(..) can be assigned directly.

>  	edge = ktime_get();
>  
>  	for (i = 0; i < count; i++) {
>  		if (i % 2) // space
> -			pwm_disable(pwm);
> +			state.enabled = false;
>  		else
> -			pwm_enable(pwm);
> +			state.enabled = true;

This could be simply:
		state.enabled = (i % 2) == 0;

> +		pwm_apply_state(pwm, &state);
>  
>  		edge = ktime_add_us(edge, txbuf[i]);
>  		delta = ktime_us_delta(edge, ktime_get());
> @@ -76,7 +81,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>  			usleep_range(delta, delta + 10);
>  	}
>  
> -	pwm_disable(pwm);
> +	state.enabled = false;
> +	pwm_apply_state(pwm, &state);
>  
>  	return count;
>  }
> -- 
> 2.31.1

Thanks
Sean
