Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FFC16F3FE
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 00:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBYXzY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Feb 2020 18:55:24 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:56316 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBYXzY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 18:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582674921; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q4khEgr11bSaZz/W5RhgH6UXM1xe3uRUoWDhehDIYyM=;
        b=VrekEnVtqSgBb+yUhjfM50aXuFca92ZdampoX7gL+eMBTsj81Y5CbHc7ncqMFWzKU616AA
        G2Hlm2Q5IlaOldAI+xItsollfnIjQ3krJ/WNst4V3G9ONKVIioC5vMzjBh4tf3VorPGK60
        iULGFZ9OvN08w1lf8ZP7ArxwdioG1/A=
Date:   Tue, 25 Feb 2020 20:55:07 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 1/3] pwm: jz4740: Use clocks from TCU driver
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1582674907.3.1@crapouillou.net>
In-Reply-To: <1581440859.3.2@crapouillou.net>
References: <20191210152734.39588-1-paul@crapouillou.net>
        <20200211164625.2z4i5w6gp23eiszx@pengutronix.de>
        <1581440859.3.2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Le mar., f=E9vr. 11, 2020 at 14:07, Paul Cercueil <paul@crapouillou.net>=20
a =E9crit :
> Hi Uwe,
>=20
>=20
> Le mar., f=E9vr. 11, 2020 at 17:46, Uwe Kleine-K=F6nig=20
> <u.kleine-koenig@pengutronix.de> a =E9crit :
>> hello Paul,
>>=20
>> thanks for the ping, I lost your series from my radar.
>>=20
>> On Tue, Dec 10, 2019 at 04:27:32PM +0100, Paul Cercueil wrote:
>>>  The ingenic-timer "TCU" driver provides us with clocks, that can be
>>>  (un)gated, reparented or reclocked from devicetree, instead of=20
>>> =7F=7Fhaving
>>>  these settings hardcoded in this driver.
>>>=20
>>>  Each PWM channel's clk pointer is stored in PWM chip data to keep
>>>  the code simple. The calls to arch-specific timer code is replaced=20
>>> =7F=7Fwith
>>>  standard clock API calls to start and stop each channel's clock.
>>>=20
>>>  While this driver is devicetree-compatible, it is never (as of now)
>>>  probed from devicetree, so this change does not introduce a ABI=20
>>> =7F=7Fproblem
>>>  with current devicetree files.
>>>=20
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  Tested-by: Mathieu Malaterre <malat@debian.org>
>>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>>  ---
>>>=20
>>>  Notes:
>>>      v2: This patch is now before the patch introducing regmap, so=20
>>> =7F=7Fthe code
>>>      	has changed a bit.
>>>      v3: - Use %pe printf specifier to print error
>>>      	- Update commit message
>>>      	- Removed call to jz4740_timer_set_ctrl() in=20
>>> jz4740_pwm_free() =7F=7Fwhich
>>>      	  was reseting the clock's parent.
>>>=20
>>>   drivers/pwm/Kconfig      |  1 +
>>>   drivers/pwm/pwm-jz4740.c | 53=20
>>> =7F=7F+++++++++++++++++++++++++++++-----------
>>>   2 files changed, 40 insertions(+), 14 deletions(-)
>>>=20
>>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>>  index bd21655c37a6..15d3816341f3 100644
>>>  --- a/drivers/pwm/Kconfig
>>>  +++ b/drivers/pwm/Kconfig
>>>  @@ -225,6 +225,7 @@ config PWM_IMX_TPM
>>>   config PWM_JZ4740
>>>   	tristate "Ingenic JZ47xx PWM support"
>>>   	depends on MACH_INGENIC
>>>  +	depends on COMMON_CLK
>>>   	help
>>>   	  Generic PWM framework driver for Ingenic JZ47xx based
>>>   	  machines.
>>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>>  index 9d78cc21cb12..ee50ac5fabb6 100644
>>>  --- a/drivers/pwm/pwm-jz4740.c
>>>  +++ b/drivers/pwm/pwm-jz4740.c
>>>  @@ -24,7 +24,6 @@
>>>=20
>>>   struct jz4740_pwm_chip {
>>>   	struct pwm_chip chip;
>>>  -	struct clk *clk;
>>>   };
>>>=20
>>>   static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip=20
>>> =7F=7F*chip)
>>>  @@ -34,6 +33,11 @@ static inline struct jz4740_pwm_chip=20
>>> =7F=7F*to_jz4740(struct pwm_chip *chip)
>>>=20
>>>   static int jz4740_pwm_request(struct pwm_chip *chip, struct=20
>>> =7F=7Fpwm_device *pwm)
>>>   {
>>>  +	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
>>>  +	struct clk *clk;
>>>  +	char clk_name[16];
>>>  +	int ret;
>>>  +
>>>   	/*
>>>   	 * Timers 0 and 1 are used for system tasks, so they are=20
>>> =7F=7Funavailable
>>>   	 * for use as PWMs.
>>>  @@ -41,16 +45,32 @@ static int jz4740_pwm_request(struct pwm_chip=20
>>> =7F=7F*chip, struct pwm_device *pwm)
>>>   	if (pwm->hwpwm < 2)
>>>   		return -EBUSY;
>>>=20
>>>  -	jz4740_timer_start(pwm->hwpwm);
>>>  +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
>>>  +
>>>  +	clk =3D clk_get(chip->dev, clk_name);
>>>  +	if (IS_ERR(clk)) {
>>>  +		if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
>>>  +			dev_err(chip->dev, "Failed to get clock: %pe", clk);
>>>  +		return PTR_ERR(clk);
>>>  +	}
>>>  +
>>>  +	ret =3D clk_prepare_enable(clk);
>>>  +	if (ret) {
>>>  +		clk_put(clk);
>>>  +		return ret;
>>>  +	}
>>>  +
>>>  +	pwm_set_chip_data(pwm, clk);
>>>=20
>>>   	return 0;
>>>   }
>>>=20
>>>   static void jz4740_pwm_free(struct pwm_chip *chip, struct=20
>>> =7F=7Fpwm_device *pwm)
>>>   {
>>>  -	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
>>>  +	struct clk *clk =3D pwm_get_chip_data(pwm);
>>>=20
>>>  -	jz4740_timer_stop(pwm->hwpwm);
>>>  +	clk_disable_unprepare(clk);
>>>  +	clk_put(clk);
>>>   }
>>>=20
>>>   static int jz4740_pwm_enable(struct pwm_chip *chip, struct=20
>>> =7F=7Fpwm_device *pwm)
>>>  @@ -91,17 +111,22 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>>> =7F=7F*chip, struct pwm_device *pwm,
>>>   			    const struct pwm_state *state)
>>>   {
>>>   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>>  +	struct clk *clk =3D pwm_get_chip_data(pwm),
>>>  +		   *parent_clk =3D clk_get_parent(clk);
>>>  +	unsigned long rate, period, duty;
>>>   	unsigned long long tmp;
>>>  -	unsigned long period, duty;
>>>   	unsigned int prescaler =3D 0;
>>>   	uint16_t ctrl;
>>>  +	int err;
>>>=20
>>>  -	tmp =3D (unsigned long long)clk_get_rate(jz4740->clk) *=20
>>> =7F=7Fstate->period;
>>>  +	rate =3D clk_get_rate(parent_clk);
>>>  +	tmp =3D (unsigned long long)rate * state->period;
>>>   	do_div(tmp, 1000000000);
>>>   	period =3D tmp;
>>>=20
>>>   	while (period > 0xffff && prescaler < 6) {
>>>   		period >>=3D 2;
>>>  +		rate >>=3D 2;
>>>   		++prescaler;
>>>   	}
>>>=20
>>>  @@ -117,14 +142,18 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>>> =7F=7F*chip, struct pwm_device *pwm,
>>>=20
>>>   	jz4740_pwm_disable(chip, pwm);
>>>=20
>>>  +	err =3D clk_set_rate(clk, rate);
>>>  +	if (err) {
>>>  +		dev_err(chip->dev, "Unable to set rate: %d", err);
>>>  +		return err;
>>>  +	}
>>=20
>> What I don't like here is that you use internal knowledge about the
>> clock to set a specific rate. Given this is a 1:1 conversion to hide=20
>> =7Fthe
>> previously contained register accesses behind the clk API (which is a
>> fine move) this is ok. But IMHO this should be cleaned up to rely on=20
>> =7Fthe
>> clk code. The more natural thing to do here would be to calculate the
>> rate you can work with and request that. Maybe add a todo-comment to
>> clean this up?
>=20
> Yes, I am very aware of that - I had a patch to clean it up but we=20
> disagreed on the algorithm, so I left it for later, since these three=20
> patches are much more important for now. Not sure it needs a TODO, I=20
> plan to submit the cleanup patch once these are merged, but I can=20
> send a v4 if you prefer.

Should I respin this?

Cheers,
-Paul


>>>  +
>>>   	jz4740_timer_set_count(pwm->hwpwm, 0);
>>>   	jz4740_timer_set_duty(pwm->hwpwm, duty);
>>>   	jz4740_timer_set_period(pwm->hwpwm, period);
>>>=20
>>>  -	ctrl =3D JZ_TIMER_CTRL_PRESCALER(prescaler) |=20
>>> JZ_TIMER_CTRL_SRC_EXT =7F=7F|
>>>  -		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
>>>  -
>>>  -	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
>>>  +	ctrl =3D jz4740_timer_get_ctrl(pwm->hwpwm);
>>>  +	ctrl |=3D JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
>>>=20
>>>   	switch (state->polarity) {
>>>   	case PWM_POLARITY_NORMAL:
>>>  @@ -158,10 +187,6 @@ static int jz4740_pwm_probe(struct=20
>>> =7F=7Fplatform_device *pdev)
>>>   	if (!jz4740)
>>>   		return -ENOMEM;
>>>=20
>>>  -	jz4740->clk =3D devm_clk_get(&pdev->dev, "ext");
>>>  -	if (IS_ERR(jz4740->clk))
>>>  -		return PTR_ERR(jz4740->clk);
>>=20
>> Huh, jz4740->clk was never enabled?
>=20
> Correct. The "ext" clock is an external oscillator that is always=20
> enabled, so the code just didn't bother calling clk_enable (but it's=20
> a bug of course).
>=20
> Cheers,
> -Paul
>=20

=

