Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6580F8A88A
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfHLUnV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 16:43:21 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40364 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUnU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 16:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565642596; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S402R7yWPRIlPyhZbuZ2UYbs3ZpBD3pnHEhveVMgT3s=;
        b=blqSD4u7dwHqPMLaySSc90NE9VxPM0z13ash3Mx3uvtEJH3jb5mKcSyE+T16VzspW64AI8
        NPbe1NGCuFWBGL78kASSSoCzmBoISbbwrNpLiAxhUm/sorCIuuipu3vq7lq1LpGqeYMZ6b
        pKqec9O5rvj7vKefVq48HQ3ZqjlcMOk=
Date:   Mon, 12 Aug 2019 22:43:10 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1565642590.2007.1@crapouillou.net>
In-Reply-To: <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-5-paul@crapouillou.net>
        <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
        <1565370885.2091.2@crapouillou.net>
        <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le lun. 12 ao=FBt 2019 =E0 8:15, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil wrote:
>>  Le ven. 9 ao=FBt 2019 =E0 19:05, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=
=3D
>>  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil wrote:
>>  > >  The previous algorithm hardcoded details about how the TCU=20
>> clocks
>>  > > work.
>>  > >  The new algorithm will use clk_round_rate to find the perfect=20
>> clock
>>  > > rate
>>  > >  for the PWM channel.
>>  > >
>>  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >  Tested-by: Mathieu Malaterre <malat@debian.org>
>>  > >  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  > >  ---
>>  > >   drivers/pwm/pwm-jz4740.c | 60
>>  > > +++++++++++++++++++++++++++++-----------
>>  > >   1 file changed, 44 insertions(+), 16 deletions(-)
>>  > >
>>  > >  diff --git a/drivers/pwm/pwm-jz4740.c=20
>> b/drivers/pwm/pwm-jz4740.c
>>  > >  index 6ec8794d3b99..f20dc2e19240 100644
>>  > >  --- a/drivers/pwm/pwm-jz4740.c
>>  > >  +++ b/drivers/pwm/pwm-jz4740.c
>>  > >  @@ -110,24 +110,56 @@ static int jz4740_pwm_apply(struct=20
>> pwm_chip
>>  > > *chip, struct pwm_device *pwm,
>>  > >   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>  > >   	struct clk *clk =3D pwm_get_chip_data(pwm),
>>  > >   		   *parent_clk =3D clk_get_parent(clk);
>>  > >  -	unsigned long rate, period, duty;
>>  > >  +	unsigned long rate, parent_rate, period, duty;
>>  > >   	unsigned long long tmp;
>>  > >  -	unsigned int prescaler =3D 0;
>>  > >  +	int ret;
>>  > >
>>  > >  -	rate =3D clk_get_rate(parent_clk);
>>  > >  -	tmp =3D (unsigned long long)rate * state->period;
>>  > >  -	do_div(tmp, 1000000000);
>>  > >  -	period =3D tmp;
>>  > >  +	parent_rate =3D clk_get_rate(parent_clk);
>>  > >  +
>>  > >  +	jz4740_pwm_disable(chip, pwm);
>>  > >
>>  > >  -	while (period > 0xffff && prescaler < 6) {
>>  > >  -		period >>=3D 2;
>>  > >  -		rate >>=3D 2;
>>  > >  -		++prescaler;
>>  > >  +	/* Reset the clock to the maximum rate, and we'll reduce it=20
>> if needed */
>>  > >  +	ret =3D clk_set_max_rate(clk, parent_rate);
>>  >
>>  > What is the purpose of this call? IIUC this limits the allowed=20
>> range of
>>  > rates for clk. I assume the idea is to prevent other consumers to=20
>> change
>>  > the rate in a way that makes it unsuitable for this pwm. But this=20
>> only
>>  > makes sense if you had a notifier for clk changes, doesn't it? I'm
>>  > confused.
>>=20
>>  Nothing like that. The second call to clk_set_max_rate() might have=20
>> set
>>  a maximum clock rate that's lower than the parent's rate, and we=20
>> want to
>>  undo that.
>=20
> I still don't get the purpose of this call. Why do you limit the clock
> rate at all?

As it says below, we "limit the clock to a maximum rate that still gives
us a period value which fits in 16 bits". So that the computed hardware
values won't overflow.

E.g. if at a rate of 12 MHz your computed hardware value for the period
is 0xf000, then at a rate of 24 MHz it won't fit in 16 bits. So the=20
clock
rate must be reduced to the highest possible that will still give you a
< 16-bit value.

We always want the highest possible clock rate that works, for the sake=20
of
precision.


>>  > I think this doesn't match the commit log, you didn't even=20
>> introduced a
>>  > call to clk_round_rate().
>>=20
>>  Right, I'll edit the commit message.
>>=20
>>=20
>>  > >  +	if (ret) {
>>  > >  +		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
>>  > >  +		return ret;
>>  > >   	}
>>  > >
>>  > >  -	if (prescaler =3D=3D 6)
>>  > >  -		return -EINVAL;
>>  > >  +	ret =3D clk_set_rate(clk, parent_rate);
>>  > >  +	if (ret) {
>>  > >  +		dev_err(chip->dev, "Unable to reset to parent rate (%lu=20
>> Hz)",
>>  > >  +			parent_rate);
>>  > >  +		return ret;
>>  > >  +	}
>>  > >  +
>>  > >  +	/*
>>  > >  +	 * Limit the clock to a maximum rate that still gives us a=20
>> period value
>>  > >  +	 * which fits in 16 bits.
>>  > >  +	 */
>>  > >  +	tmp =3D 0xffffull * NSEC_PER_SEC;
>>  > >  +	do_div(tmp, state->period);
>>  > >
>>  > >  +	ret =3D clk_set_max_rate(clk, tmp);
>>  >
>>  > And now you change the maximal rate again?
>>=20
>>  Basically, we start from the maximum clock rate we can get for that=20
>> PWM
>>  - which is the rate of the parent clk - and from that compute the=20
>> maximum
>>  clock rate that we can support that still gives us < 16-bits=20
>> hardware
>>  values for the period and duty.
>>=20
>>  We then pass that computed maximum clock rate to=20
>> clk_set_max_rate(), which
>>  may or may not update the current PWM clock's rate to match the new=20
>> limits.
>>  Finally we read back the PWM clock's rate and compute the period=20
>> and duty
>>  from that.
>=20
> If you change the clk rate, is this externally visible on the PWM
> output? Does this affect other PWM instances?

The clock rate doesn't change the PWM output because the hardware=20
values for
the period and duty are adapted accordingly to reflect the change.


>>  > >  +	if (ret) {
>>  > >  +		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
>>  > >  +		return ret;
>>  > >  +	}
>>  > >  +
>>  > >  +	/*
>>  > >  +	 * Read back the clock rate, as it may have been modified by
>>  > >  +	 * clk_set_max_rate()
>>  > >  +	 */
>>  > >  +	rate =3D clk_get_rate(clk);
>>  > >  +
>>  > >  +	if (rate !=3D parent_rate)
>>  > >  +		dev_dbg(chip->dev, "PWM clock updated to %lu Hz\n", rate);
>>  > >  +
>>  > >  +	/* Calculate period value */
>>  > >  +	tmp =3D (unsigned long long)rate * state->period;
>>  > >  +	do_div(tmp, NSEC_PER_SEC);
>>  > >  +	period =3D (unsigned long)tmp;
>>  > >  +
>>  > >  +	/* Calculate duty value */
>>  > >   	tmp =3D (unsigned long long)period * state->duty_cycle;
>>  > >   	do_div(tmp, state->period);
>>  > >   	duty =3D period - tmp;
>>  > >  @@ -135,14 +167,10 @@ static int jz4740_pwm_apply(struct=20
>> pwm_chip
>>  > > *chip, struct pwm_device *pwm,
>>  > >   	if (duty >=3D period)
>>  > >   		duty =3D period - 1;
>>  > >
>>  > >  -	jz4740_pwm_disable(chip, pwm);
>>  > >  -
>>  > >   	/* Set abrupt shutdown */
>>  > >   	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>>  > >   			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
>>  > >
>>  > >  -	clk_set_rate(clk, rate);
>>  > >  -
>>  >
>>  > It's not obvious to me why removing these two lines belong in the
>>  > current patch.
>>=20
>>  They're not removed, they're both moved up in the function.
>=20
> OK, will look closer in the next iteration.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |

=

