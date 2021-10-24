Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16C43873E
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Oct 2021 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhJXH1s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Oct 2021 03:27:48 -0400
Received: from gofer.mess.org ([88.97.38.141]:39213 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhJXH1r (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 24 Oct 2021 03:27:47 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 89854C6406; Sun, 24 Oct 2021 08:25:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635060325; bh=aCiaIAzKkAknGp/LcZY2uFjJlXi0blWnmxqTQMNaa1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAWar1oWXGBgplgHej85nqzF+Sd3MijcZQQPDyOoOPn8zFKb6tZNTs+JysK2VZOH1
         w58kvvqB+7U0juDXGsnjqjJESa7OrYZQTCO9qHTPCOXrsveofjq8bAUEFvNxwje9+W
         +8OwNoZvX1FDQt7A+2B6GPZa8Lp/1w9prEdRq4qWmR3TNuxi1Pk3VcAD6hBtacw3KL
         exfOQCoLVEgIx46jP6hgZX+Qrcb8PTpctIFkn98/nT0c26yiirUwB/HyiJ1NbtabBE
         6qO8TLzvRW/r3EitOp2or1VSABJ4Vn9jzCIvlt1TX0yGZj6klYgCBVZR+9gTDWKIky
         lzfzucmz6Mihw==
Date:   Sun, 24 Oct 2021 08:25:25 +0100
From:   Sean Young <sean@mess.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211024072525.GA31903@gofer.mess.org>
References: <YXRSaMb2FV78+1tc@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXRSaMb2FV78+1tc@fedora>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Oct 23, 2021 at 03:20:42PM -0300, Maíra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
> V1 -> V2: Assign variables directly and simplify conditional statement
> ---
>  drivers/media/rc/pwm-ir-tx.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index 4bc28d2c9cc9..ca943f168855 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -53,22 +53,21 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>  {
>  	struct pwm_ir *pwm_ir = dev->priv;
>  	struct pwm_device *pwm = pwm_ir->pwm;
> -	int i, duty, period;
> +	struct pwm_state state;
> +	int i;
>  	ktime_t edge;
>  	long delta;
>  
> -	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> -	duty = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
> +	pwm_init_state(pwm, &state);
>  
> -	pwm_config(pwm, duty, period);
> +	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> +	state.duty_cycle = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);

That doesn't compile.


Sean

>  
>  	edge = ktime_get();
>  
>  	for (i = 0; i < count; i++) {
> -		if (i % 2) // space
> -			pwm_disable(pwm);
> -		else
> -			pwm_enable(pwm);
> +		state.enabled = !(i % 2);
> +		pwm_apply_state(pwm, &state);
>  
>  		edge = ktime_add_us(edge, txbuf[i]);
>  		delta = ktime_us_delta(edge, ktime_get());
> @@ -76,7 +75,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
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
