Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1792A100305
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfKRK4G (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 05:56:06 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47798 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfKRK4G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 05:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574074563; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gfve7SAcLidhKSuYXJOpLAeIxapBfNaOT67zDK+yvxM=;
        b=wubPVVD8T5VKF45PJu1D9JRsSf7XMzvpcQseeqDMUDJNz32gmvEHbtClLoEjmRmnjL2fMt
        dN3GRF9+cUwFbU5UDvoaf3rGIrfVHP8WJW/gQHVuWEAa8qggfkUbI1lZOegcM4KqzhSAOM
        Fe+oe0fHWcyYtW1rmDc/Gx7G2w/yUAY=
Date:   Mon, 18 Nov 2019 11:55:56 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] pwm: jz4740: Use clocks from TCU driver
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>, kernel@pengutronix.de
Message-Id: <1574074556.3.0@crapouillou.net>
In-Reply-To: <20191118071538.46egokrswvjxdvfp@pengutronix.de>
References: <20191116173613.72647-1-paul@crapouillou.net>
        <20191116173613.72647-2-paul@crapouillou.net>
        <20191117202028.4chgjv2kulyyq2eu@pengutronix.de>
        <1574031523.3.0@crapouillou.net>
        <20191118071538.46egokrswvjxdvfp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,


Le lun., nov. 18, 2019 at 08:15, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Sun, Nov 17, 2019 at 11:58:43PM +0100, Paul Cercueil wrote:
>>  Le dim., nov. 17, 2019 at 21:20, Uwe Kleine-K=F6nig
>>  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > On Sat, Nov 16, 2019 at 06:36:11PM +0100, Paul Cercueil wrote:
>>  > >  The ingenic-timer "TCU" driver provides us with clocks, that=20
>> can be
>>  > >  (un)gated, reparented or reclocked from devicetree, instead of=20
>> having
>>  > >  these settings hardcoded in this driver.
>>  > >
>>  > >  While this driver is devicetree-compatible, it is never (as of=20
>> now)
>>  > >  probed from devicetree, so this change does not introduce a=20
>> ABI problem
>>  > >  with current devicetree files.
>>  > >
>>  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >  Tested-by: Mathieu Malaterre <malat@debian.org>
>>  > >  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  > >  ---
>>  > >
>>  > >  Notes:
>>  > >      v2: This patch is now before the patch introducing regmap,=20
>> so
>>  > > the code
>>  > >          has changed a bit.
>>  > >
>>  > >   drivers/pwm/Kconfig      |  1 +
>>  > >   drivers/pwm/pwm-jz4740.c | 45=20
>> ++++++++++++++++++++++++++++------------
>>  > >   2 files changed, 33 insertions(+), 13 deletions(-)
>>  > >
>>  > >  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  > >  index e3a2518503ed..e998e5cb01b0 100644
>>  > >  --- a/drivers/pwm/Kconfig
>>  > >  +++ b/drivers/pwm/Kconfig
>>  > >  @@ -225,6 +225,7 @@ config PWM_IMX_TPM
>>  > >   config PWM_JZ4740
>>  > >   	tristate "Ingenic JZ47xx PWM support"
>>  > >   	depends on MACH_INGENIC
>>  > >  +	depends on COMMON_CLK
>>  > >   	help
>>  > >   	  Generic PWM framework driver for Ingenic JZ47xx based
>>  > >   	  machines.
>>  > >  diff --git a/drivers/pwm/pwm-jz4740.c=20
>> b/drivers/pwm/pwm-jz4740.c
>>  > >  index 9d78cc21cb12..fd83644f9323 100644
>>  > >  --- a/drivers/pwm/pwm-jz4740.c
>>  > >  +++ b/drivers/pwm/pwm-jz4740.c
>>  > >  @@ -24,7 +24,6 @@
>>  > >
>>  > >   struct jz4740_pwm_chip {
>>  > >   	struct pwm_chip chip;
>>  > >  -	struct clk *clk;
>>  >
>>  > What is the motivation to go away from this approach to store the=20
>> clock?
>>=20
>>  It's actually not the same clock. Instead of obtaining "ext" clock=20
>> from the
>>  probe, we obtain "timerX" clocks (X being the PWM channel) from the=20
>> request
>>  callback.
>=20
> Before you used driver data and container_of to get it, now you used
> pwm_set_chip_data. I wondered why you changed the approach to store
> data. That the actual data is different now is another thing (and
> obviously ok).

Thierry suggested it: https://lkml.org/lkml/2019/3/4/486

>=20
>>  > >   };
>>  > >
>>  > >   static inline struct jz4740_pwm_chip *to_jz4740(struct=20
>> pwm_chip *chip)
>>  > >  @@ -34,6 +33,11 @@ static inline struct jz4740_pwm_chip=20
>> *to_jz4740(struct pwm_chip *chip)
>>  > >
>>  > >   static int jz4740_pwm_request(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>  > >   {
>>  > >  +	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
>>  > >  +	struct clk *clk;
>>  > >  +	char clk_name[16];
>>  > >  +	int ret;
>>  > >  +
>>  > >   	/*
>>  > >   	 * Timers 0 and 1 are used for system tasks, so they are=20
>> unavailable
>>  > >   	 * for use as PWMs.
>>  > >  @@ -41,16 +45,31 @@ static int jz4740_pwm_request(struct=20
>> pwm_chip *chip, struct pwm_device *pwm)
>>  > >   	if (pwm->hwpwm < 2)
>>  > >   		return -EBUSY;
>>  > >
>>  > >  -	jz4740_timer_start(pwm->hwpwm);
>>  > >  +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
>>  > >  +
>>  > >  +	clk =3D clk_get(chip->dev, clk_name);
>>  > >  +	if (IS_ERR(clk))
>>  >
>>  > 		if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
>>  > 			dev_err(chip->dev, "Failed to get clock: %pe\n", clk);
>>=20
>>  Never heard about that %pe. Will do that.
>=20
> Yeah, that's new and IMHO quite nice.
>=20
>>  > >  +		return PTR_ERR(clk);
>>  > >  +
>>  > >  +	ret =3D clk_prepare_enable(clk);
>>  > >  +	if (ret) {
>>  > >  +		clk_put(clk);
>>  > >  +		return ret;
>>  > >  +	}
>>  > >  +
>>  > >  +	pwm_set_chip_data(pwm, clk);
>>  > >
>>  > >   	return 0;
>>  > >   }
>>  > >
>>  > >   static void jz4740_pwm_free(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>  > >   {
>>  > >  +	struct clk *clk =3D pwm_get_chip_data(pwm);
>>  > >  +
>>  > >   	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
>>  >
>>  > What is the purpose of this call? I would have expected that all=20
>> these
>>  > would go away when converting to the clk stuff?!
>>=20
>>  Some go away in patch [1/3] as they are clock-related, this one=20
>> will go away
>>  in patch [2/3] when the driver is converted to use regmap.
>=20
> I'd like to understand what it does. Judging from the name I expect=20
> this
> is somehow related to the clock stuff and so I wonder if the=20
> conversion
> to the clk API is as complete as it should be.

It clears the PWM channel's CTRL register. That's the register used for=20
instance to enable the PWM function of a TCU channel.

>=20
>>  > >  -	jz4740_timer_stop(pwm->hwpwm);
>>  > >  +	clk_disable_unprepare(clk);
>>  > >  +	clk_put(clk);
>>  > >   }
>>  > >
>>  > >   static int jz4740_pwm_enable(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>  > >  @@ -91,17 +110,21 @@ static int jz4740_pwm_apply(struct=20
>> pwm_chip *chip, struct pwm_device *pwm,
>>  > >   			    const struct pwm_state *state)
>>  > >   {
>>  > >   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>  > >  +	struct clk *clk =3D pwm_get_chip_data(pwm),
>>  > >  +		   *parent_clk =3D clk_get_parent(clk);
>>  > >  +	unsigned long rate, period, duty;
>>  > >   	unsigned long long tmp;
>>  > >  -	unsigned long period, duty;
>>  > >   	unsigned int prescaler =3D 0;
>>  > >   	uint16_t ctrl;
>>  > >
>>  > >  -	tmp =3D (unsigned long long)clk_get_rate(jz4740->clk) *=20
>> state->period;
>>  > >  +	rate =3D clk_get_rate(parent_clk);
>>  >
>>  > Why is it the parent's rate that is relevant here?
>>=20
>>  We calculate the divider to be used for the "timerX" clock, so we=20
>> need to
>>  know the parent clock.
>=20
> Then the approach here is wrong. You should not assume anything about
> the internal details of the clock, that's the task of the clock=20
> driver.
> As a consumer of the clock just request a rate (or use clk_round_rate=20
> to
> find a good setting first) and use that.

Totally agreed. I wanted to do that, but you were fighting tooth and=20
nails against my patch "Improve algorithm of clock calculation",=20
remember?

-Paul

=

