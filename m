Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DCB37B338
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 02:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhELA4f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 May 2021 20:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELA4f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 May 2021 20:56:35 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD6DC061574
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 17:55:27 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id k25so20810839oic.4
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0clVA/4AvA12vh6Bnff7EbANw7ZHgJqIExaXQguPVDo=;
        b=ZJhSTe+GIfRgApt3Vq+6aGs73sEndEqOzEturMLi+z18gLYPtQlMG5TPf3GVMeDWOw
         A1kAimb4QFMSUxIVCYFqxvHyoDBWXvqIqOgC0mtP6tjDsnNlfKTwGqVOCEtDOZnc6cCN
         kVSQpCjfjNL/N5w5qpw2b/HOQE6Yyyv+AGM48a417SJ+mGM6SU1G+mliABqGK5z35pgE
         67BKf1C9pkHnjhsUX1D82msoFD2IxliIo9p3L9dU3xxF0TGmaJLIp3bKmdLyo9I0C72Q
         GuH3WfPqYVl5ffEDzk4DgpHO41Sxf1dc0PsOBv4ttqvjf4af1eMxqhM42PYRHvWlclpf
         LKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0clVA/4AvA12vh6Bnff7EbANw7ZHgJqIExaXQguPVDo=;
        b=uLMV7XXbGjVYvfyX/58aysiRB8uk0pjE0qCHvfkFjGp0p5qns1/fJ6UW3GLaItrFnh
         OCUzLunwu325iY7R1VzV76ETD8FaKIruG6aTJPwvf34w9328PkfardEIiutTUgkJa49S
         yRg1FfcQoiZzO9RSGZ6fOBuwgjzSI+3V3ZN1tMox5OzqWiOgilK4z3gX3+3YI2gd8XV2
         SI60rlVBnnFehepngmIkWl7wQyIGLArIAzKlEIJrFQc5tt72A1Pfsv9sGst4QClZ/rOF
         R8s2q477AL5702Gwj5JVRDj4gcuBGPo4tNcXnPEEwhWGmM0n/bxQ93dLp1Ya6JNRxPyT
         yVBw==
X-Gm-Message-State: AOAM531Eq/mp29MFZwKvU/6BbfuVR8hImGvzuU8FO55HXTdgcesq1BEJ
        qLpxw1tLtdFgJuNNd8pkjvuci/rQprfWyhUDsL8=
X-Google-Smtp-Source: ABdhPJzgsfyP2icvTThoC5+Fi1HdXU55ezSLtsETpSbLXctHkc/g8MtD3ZBunmXqNgKSGX9I/oq1MeAyoRfWXpKTCkY=
X-Received: by 2002:aca:53d8:: with SMTP id h207mr5806180oib.177.1620780926691;
 Tue, 11 May 2021 17:55:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7084:0:0:0:0:0 with HTTP; Tue, 11 May 2021 17:55:26
 -0700 (PDT)
In-Reply-To: <20210511220014.1945519-1-roman.beranek@prusa3d.com>
References: <20210511220014.1945519-1-roman.beranek@prusa3d.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Wed, 12 May 2021 02:55:26 +0200
Message-ID: <CAO1O6seU7t==O=yCVBQK0iAkeEyO3dbRQ71obJh3Jm26xxWobw@mail.gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Avoid waiting until the next period
To:     Roman Beranek <roman.beranek@prusa3d.cz>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Well that's one way of "solving it" ;)

But on what hardware do you really need to wait until one full pulse
cycle ends, before a disable command takes effect?

On the hardware I've tested on (GR8 and V3s), it's enough to wait at
most two clock cycles in order for it to take effect before we can
close the gate. And with clock cycle I mean 24 MHz divided by the
prescaler. With prescaler 1, that's 84 nanoseconds. By closing the
gate when the pwm should be disabled, I guess we could save some
nanoampere or microampere (is this important?)

/Emil

2021-05-12 0:00 GMT+02:00, Roman Beranek <roman.beranek@prusa3d.cz>:
> As disabling PWM by clearing the PWM_EN bit doesn't take an effect until
> the last pulse cycle ends, gating the clock too soon may result in the
> output signal getting stuck in an active state. Although the code gives
> an appearance that it takes care of this particular problem by waiting
> for the next period before finally clearing the CLK_GATING and EN bits,
> unless the EN bit has already been cleared by the time the delay begins,
> this measure doesn't achieve anything.
>
> However, even if this detail were to be fixed, there would still remain
> another issue to deal with: if the PWM were to be disabled shortly after
> having its period shortened, the length of the delay might turn out
> insufficient. So instead of waiting for the moment when it becomes safe
> to gate the clock, let's not bother gating it in the first place.
>
> Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-sun4i.c | 52 +++++++++++------------------------------
>  1 file changed, 13 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index e01becd10..809163186 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -89,7 +89,6 @@ struct sun4i_pwm_chip {
>  	void __iomem *base;
>  	spinlock_t ctrl_lock;
>  	const struct sun4i_pwm_data *data;
> -	unsigned long next_period[2];
>  };
>
>  static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip
> *chip)
> @@ -235,26 +234,15 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> struct pwm_device *pwm,
>  	struct pwm_state cstate;
>  	u32 ctrl, duty =3D 0, period =3D 0, val;
>  	int ret;
> -	unsigned int delay_us, prescaler =3D 0;
> -	unsigned long now;
> +	unsigned int prescaler =3D 0;
>  	bool bypass;
>
>  	pwm_get_state(pwm, &cstate);
>
> -	if (!cstate.enabled) {
> -		ret =3D clk_prepare_enable(sun4i_pwm->clk);
> -		if (ret) {
> -			dev_err(chip->dev, "failed to enable PWM clock\n");
> -			return ret;
> -		}
> -	}
> -
>  	ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescale=
r,
>  				  &bypass);
>  	if (ret) {
>  		dev_err(chip->dev, "period exceeds the maximum value\n");
> -		if (!cstate.enabled)
> -			clk_disable_unprepare(sun4i_pwm->clk);
>  		return ret;
>  	}
>
> @@ -284,8 +272,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct
> pwm_device *pwm,
>
>  	val =3D (duty & PWM_DTY_MASK) | PWM_PRD(period);
>  	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
> -	sun4i_pwm->next_period[pwm->hwpwm] =3D jiffies +
> -		nsecs_to_jiffies(cstate.period + 1000);
>
>  	if (state->polarity !=3D PWM_POLARITY_NORMAL)
>  		ctrl &=3D ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
> @@ -296,34 +282,12 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> struct pwm_device *pwm,
>
>  	if (state->enabled)
>  		ctrl |=3D BIT_CH(PWM_EN, pwm->hwpwm);
> +	else
> +		ctrl &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
>
>  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> -
> -	spin_unlock(&sun4i_pwm->ctrl_lock);
> -
> -	if (state->enabled)
> -		return 0;
> -
> -	/* We need a full period to elapse before disabling the channel. */
> -	now =3D jiffies;
> -	if (time_before(now, sun4i_pwm->next_period[pwm->hwpwm])) {
> -		delay_us =3D jiffies_to_usecs(sun4i_pwm->next_period[pwm->hwpwm] -
> -					   now);
> -		if ((delay_us / 500) > MAX_UDELAY_MS)
> -			msleep(delay_us / 1000 + 1);
> -		else
> -			usleep_range(delay_us, delay_us * 2);
> -	}
> -
> -	spin_lock(&sun4i_pwm->ctrl_lock);
> -	ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> -	ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> -	ctrl &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> -	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>  	spin_unlock(&sun4i_pwm->ctrl_lock);
>
> -	clk_disable_unprepare(sun4i_pwm->clk);
> -
>  	return 0;
>  }
>
> @@ -457,6 +421,13 @@ static int sun4i_pwm_probe(struct platform_device
> *pdev)
>  		goto err_bus;
>  	}
>
> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to prepare and enable PWM clock %pe\n",
> +			ERR_PTR(ret));
> +		goto err_clk;
> +	}
> +
>  	pwm->chip.dev =3D &pdev->dev;
>  	pwm->chip.ops =3D &sun4i_pwm_ops;
>  	pwm->chip.npwm =3D pwm->data->npwm;
> @@ -476,6 +447,8 @@ static int sun4i_pwm_probe(struct platform_device
> *pdev)
>  	return 0;
>
>  err_pwm_add:
> +	clk_disable_unprepare(pwm->clk);
> +err_clk:
>  	clk_disable_unprepare(pwm->bus_clk);
>  err_bus:
>  	reset_control_assert(pwm->rst);
> @@ -492,6 +465,7 @@ static int sun4i_pwm_remove(struct platform_device
> *pdev)
>  	if (ret)
>  		return ret;
>
> +	clk_disable_unprepare(pwm->clk);
>  	clk_disable_unprepare(pwm->bus_clk);
>  	reset_control_assert(pwm->rst);
>
> --
> 2.31.1
>
>
