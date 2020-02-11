Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3209915954E
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2020 17:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgBKQq3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Feb 2020 11:46:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55857 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgBKQq3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Feb 2020 11:46:29 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1Yg6-0000K1-Ao; Tue, 11 Feb 2020 17:46:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1Yg5-0003S6-KS; Tue, 11 Feb 2020 17:46:25 +0100
Date:   Tue, 11 Feb 2020 17:46:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v3 1/3] pwm: jz4740: Use clocks from TCU driver
Message-ID: <20200211164625.2z4i5w6gp23eiszx@pengutronix.de>
References: <20191210152734.39588-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210152734.39588-1-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

hello Paul,

thanks for the ping, I lost your series from my radar.

On Tue, Dec 10, 2019 at 04:27:32PM +0100, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with clocks, that can be
> (un)gated, reparented or reclocked from devicetree, instead of having
> these settings hardcoded in this driver.
> 
> Each PWM channel's clk pointer is stored in PWM chip data to keep
> the code simple. The calls to arch-specific timer code is replaced with
> standard clock API calls to start and stop each channel's clock.
> 
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Notes:
>     v2: This patch is now before the patch introducing regmap, so the code
>     	has changed a bit.
>     v3: - Use %pe printf specifier to print error
>     	- Update commit message
>     	- Removed call to jz4740_timer_set_ctrl() in jz4740_pwm_free() which
>     	  was reseting the clock's parent.
> 
>  drivers/pwm/Kconfig      |  1 +
>  drivers/pwm/pwm-jz4740.c | 53 +++++++++++++++++++++++++++++-----------
>  2 files changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index bd21655c37a6..15d3816341f3 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -225,6 +225,7 @@ config PWM_IMX_TPM
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> +	depends on COMMON_CLK
>  	help
>  	  Generic PWM framework driver for Ingenic JZ47xx based
>  	  machines.
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 9d78cc21cb12..ee50ac5fabb6 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -24,7 +24,6 @@
>  
>  struct jz4740_pwm_chip {
>  	struct pwm_chip chip;
> -	struct clk *clk;
>  };
>  
>  static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
> @@ -34,6 +33,11 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
>  
>  static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> +	struct jz4740_pwm_chip *jz = to_jz4740(chip);
> +	struct clk *clk;
> +	char clk_name[16];
> +	int ret;
> +
>  	/*
>  	 * Timers 0 and 1 are used for system tasks, so they are unavailable
>  	 * for use as PWMs.
> @@ -41,16 +45,32 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  	if (pwm->hwpwm < 2)
>  		return -EBUSY;
>  
> -	jz4740_timer_start(pwm->hwpwm);
> +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
> +
> +	clk = clk_get(chip->dev, clk_name);
> +	if (IS_ERR(clk)) {
> +		if (PTR_ERR(clk) != -EPROBE_DEFER)
> +			dev_err(chip->dev, "Failed to get clock: %pe", clk);
> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		clk_put(clk);
> +		return ret;
> +	}
> +
> +	pwm_set_chip_data(pwm, clk);
>  
>  	return 0;
>  }
>  
>  static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> -	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
> +	struct clk *clk = pwm_get_chip_data(pwm);
>  
> -	jz4740_timer_stop(pwm->hwpwm);
> +	clk_disable_unprepare(clk);
> +	clk_put(clk);
>  }
>  
>  static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -91,17 +111,22 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			    const struct pwm_state *state)
>  {
>  	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
> +	struct clk *clk = pwm_get_chip_data(pwm),
> +		   *parent_clk = clk_get_parent(clk);
> +	unsigned long rate, period, duty;
>  	unsigned long long tmp;
> -	unsigned long period, duty;
>  	unsigned int prescaler = 0;
>  	uint16_t ctrl;
> +	int err;
>  
> -	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
> +	rate = clk_get_rate(parent_clk);
> +	tmp = (unsigned long long)rate * state->period;
>  	do_div(tmp, 1000000000);
>  	period = tmp;
>  
>  	while (period > 0xffff && prescaler < 6) {
>  		period >>= 2;
> +		rate >>= 2;
>  		++prescaler;
>  	}
>  
> @@ -117,14 +142,18 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	jz4740_pwm_disable(chip, pwm);
>  
> +	err = clk_set_rate(clk, rate);
> +	if (err) {
> +		dev_err(chip->dev, "Unable to set rate: %d", err);
> +		return err;
> +	}

What I don't like here is that you use internal knowledge about the
clock to set a specific rate. Given this is a 1:1 conversion to hide the
previously contained register accesses behind the clk API (which is a
fine move) this is ok. But IMHO this should be cleaned up to rely on the
clk code. The more natural thing to do here would be to calculate the
rate you can work with and request that. Maybe add a todo-comment to
clean this up?

> +
>  	jz4740_timer_set_count(pwm->hwpwm, 0);
>  	jz4740_timer_set_duty(pwm->hwpwm, duty);
>  	jz4740_timer_set_period(pwm->hwpwm, period);
>  
> -	ctrl = JZ_TIMER_CTRL_PRESCALER(prescaler) | JZ_TIMER_CTRL_SRC_EXT |
> -		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
> -
> -	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
> +	ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
> +	ctrl |= JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
>  
>  	switch (state->polarity) {
>  	case PWM_POLARITY_NORMAL:
> @@ -158,10 +187,6 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
>  	if (!jz4740)
>  		return -ENOMEM;
>  
> -	jz4740->clk = devm_clk_get(&pdev->dev, "ext");
> -	if (IS_ERR(jz4740->clk))
> -		return PTR_ERR(jz4740->clk);

Huh, jz4740->clk was never enabled?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
