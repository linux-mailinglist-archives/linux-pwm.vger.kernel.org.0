Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F488FFC19
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Nov 2019 23:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfKQW6y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Nov 2019 17:58:54 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53478 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfKQW6y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 Nov 2019 17:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574031530; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rehDJHT5XgqrmrR5yw6KriOCF7C12z5xBt80ruxYe4w=;
        b=qnCxcxZ767OA9B9hbb4y8OOzz0LE/OBCZqaCT5zngqzggHNrM4/DEzUoESLfcPC0ZDXWPv
        4vyhLQh+WFOgCyfu03wNvKy17g+Dxo5fnf7WZfYMU48FC1I8QvzUctHkEEGqQIAHRgBz+W
        xj26vxDe4ziGzaW7t7yw15WtXhSROKA=
Date:   Sun, 17 Nov 2019 23:58:43 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] pwm: jz4740: Use clocks from TCU driver
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1574031523.3.0@crapouillou.net>
In-Reply-To: <20191117202028.4chgjv2kulyyq2eu@pengutronix.de>
References: <20191116173613.72647-1-paul@crapouillou.net>
        <20191116173613.72647-2-paul@crapouillou.net>
        <20191117202028.4chgjv2kulyyq2eu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,


Le dim., nov. 17, 2019 at 21:20, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Sat, Nov 16, 2019 at 06:36:11PM +0100, Paul Cercueil wrote:
>>  The ingenic-timer "TCU" driver provides us with clocks, that can be
>>  (un)gated, reparented or reclocked from devicetree, instead of=20
>> having
>>  these settings hardcoded in this driver.
>>=20
>>  While this driver is devicetree-compatible, it is never (as of now)
>>  probed from devicetree, so this change does not introduce a ABI=20
>> problem
>>  with current devicetree files.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Mathieu Malaterre <malat@debian.org>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>=20
>>  Notes:
>>      v2: This patch is now before the patch introducing regmap, so=20
>> the code
>>          has changed a bit.
>>=20
>>   drivers/pwm/Kconfig      |  1 +
>>   drivers/pwm/pwm-jz4740.c | 45=20
>> ++++++++++++++++++++++++++++------------
>>   2 files changed, 33 insertions(+), 13 deletions(-)
>>=20
>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  index e3a2518503ed..e998e5cb01b0 100644
>>  --- a/drivers/pwm/Kconfig
>>  +++ b/drivers/pwm/Kconfig
>>  @@ -225,6 +225,7 @@ config PWM_IMX_TPM
>>   config PWM_JZ4740
>>   	tristate "Ingenic JZ47xx PWM support"
>>   	depends on MACH_INGENIC
>>  +	depends on COMMON_CLK
>>   	help
>>   	  Generic PWM framework driver for Ingenic JZ47xx based
>>   	  machines.
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index 9d78cc21cb12..fd83644f9323 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -24,7 +24,6 @@
>>=20
>>   struct jz4740_pwm_chip {
>>   	struct pwm_chip chip;
>>  -	struct clk *clk;
>=20
> What is the motivation to go away from this approach to store the=20
> clock?

It's actually not the same clock. Instead of obtaining "ext" clock from=20
the probe, we obtain "timerX" clocks (X being the PWM channel) from the=20
request callback.


>>   };
>>=20
>>   static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip=20
>> *chip)
>>  @@ -34,6 +33,11 @@ static inline struct jz4740_pwm_chip=20
>> *to_jz4740(struct pwm_chip *chip)
>>=20
>>   static int jz4740_pwm_request(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>   {
>>  +	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
>>  +	struct clk *clk;
>>  +	char clk_name[16];
>>  +	int ret;
>>  +
>>   	/*
>>   	 * Timers 0 and 1 are used for system tasks, so they are=20
>> unavailable
>>   	 * for use as PWMs.
>>  @@ -41,16 +45,31 @@ static int jz4740_pwm_request(struct pwm_chip=20
>> *chip, struct pwm_device *pwm)
>>   	if (pwm->hwpwm < 2)
>>   		return -EBUSY;
>>=20
>>  -	jz4740_timer_start(pwm->hwpwm);
>>  +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
>>  +
>>  +	clk =3D clk_get(chip->dev, clk_name);
>>  +	if (IS_ERR(clk))
>=20
> 		if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
> 			dev_err(chip->dev, "Failed to get clock: %pe\n", clk);

Never heard about that %pe. Will do that.


>=20
>>  +		return PTR_ERR(clk);
>>  +
>>  +	ret =3D clk_prepare_enable(clk);
>>  +	if (ret) {
>>  +		clk_put(clk);
>>  +		return ret;
>>  +	}
>>  +
>>  +	pwm_set_chip_data(pwm, clk);
>>=20
>>   	return 0;
>>   }
>>=20
>>   static void jz4740_pwm_free(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>   {
>>  +	struct clk *clk =3D pwm_get_chip_data(pwm);
>>  +
>>   	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
>=20
> What is the purpose of this call? I would have expected that all these
> would go away when converting to the clk stuff?!

Some go away in patch [1/3] as they are clock-related, this one will go=20
away in patch [2/3] when the driver is converted to use regmap.

>=20
>>  -	jz4740_timer_stop(pwm->hwpwm);
>>  +	clk_disable_unprepare(clk);
>>  +	clk_put(clk);
>>   }
>>=20
>>   static int jz4740_pwm_enable(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>  @@ -91,17 +110,21 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   			    const struct pwm_state *state)
>>   {
>>   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>  +	struct clk *clk =3D pwm_get_chip_data(pwm),
>>  +		   *parent_clk =3D clk_get_parent(clk);
>>  +	unsigned long rate, period, duty;
>>   	unsigned long long tmp;
>>  -	unsigned long period, duty;
>>   	unsigned int prescaler =3D 0;
>>   	uint16_t ctrl;
>>=20
>>  -	tmp =3D (unsigned long long)clk_get_rate(jz4740->clk) *=20
>> state->period;
>>  +	rate =3D clk_get_rate(parent_clk);
>=20
> Why is it the parent's rate that is relevant here?

We calculate the divider to be used for the "timerX" clock, so we need=20
to know the parent clock.


>>  +	tmp =3D (unsigned long long)rate * state->period;
>>   	do_div(tmp, 1000000000);
>>   	period =3D tmp;
>>=20
>>   	while (period > 0xffff && prescaler < 6) {
>>   		period >>=3D 2;
>>  +		rate >>=3D 2;
>>   		++prescaler;
>>   	}
>>=20
>>  @@ -117,14 +140,14 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>=20
>>   	jz4740_pwm_disable(chip, pwm);
>>=20
>>  +	clk_set_rate(clk, rate);
>=20
> This function's return code must be checked.

In practice this will never fail, but OK, will do.

Cheers,
-Paul

>=20
>>   	jz4740_timer_set_count(pwm->hwpwm, 0);
>>   	jz4740_timer_set_duty(pwm->hwpwm, duty);
>>   	jz4740_timer_set_period(pwm->hwpwm, period);
>>=20
>>  -	ctrl =3D JZ_TIMER_CTRL_PRESCALER(prescaler) | JZ_TIMER_CTRL_SRC_EXT=20
>> |
>>  -		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
>>  -
>>  -	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
>>  +	ctrl =3D jz4740_timer_get_ctrl(pwm->hwpwm);
>>  +	ctrl |=3D JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
>>=20
>>   	switch (state->polarity) {
>>   	case PWM_POLARITY_NORMAL:
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> https://www.pengutronix.de/ |

=

