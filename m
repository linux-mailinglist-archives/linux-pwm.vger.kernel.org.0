Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF41A8A8A3
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 22:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfHLUuI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 16:50:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46294 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfHLUuI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 16:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565643005; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5cu4TbrdhiCsOGYq9bAxCaKQGkNk/ZGyyL86bqYhdk=;
        b=N9VyZvxxVB7k2t0mOE1IDnJixL17ZlQQE9aHvyOQjYmQV4536NxH5fz67LrZkQIdMxuYoH
        Qm9apbRg+zt34yldxMH4yJqoXXjzlK9L129ibTLoRWHGKzPFUJJizfF59W6s2Ey2p5mxS9
        p1QFprDz4Xjm2Krmz9uBKSHGmGMrr24=
Date:   Mon, 12 Aug 2019 22:50:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 6/7] pwm: jz4740: Make PWM start with the active part
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1565643001.2007.2@crapouillou.net>
In-Reply-To: <20190812055515.ne7o4ujchfeubjid@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-7-paul@crapouillou.net>
        <20190809171058.gothydohec6qx7hu@pengutronix.de>
        <1565372004.2091.3@crapouillou.net>
        <20190812055515.ne7o4ujchfeubjid@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le lun. 12 ao=FBt 2019 =E0 7:55, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Fri, Aug 09, 2019 at 07:33:24PM +0200, Paul Cercueil wrote:
>>=20
>>=20
>>  Le ven. 9 ao=FBt 2019 =E0 19:10, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=
=3D
>>  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > On Fri, Aug 09, 2019 at 02:30:30PM +0200, Paul Cercueil wrote:
>>  > >  The PWM will always start with the inactive part. To counter=20
>> that,
>>  > >  when PWM is enabled we switch the configured polarity, and use
>>  > >  'period - duty + 1' as the real duty.
>>  >
>>  > Where does the + 1 come from? This looks wrong. (So if duty=3D0 is
>>  > requested you use duty =3D period + 1?)
>>=20
>>  You'd never request duty =3D=3D 0, would you?
>>=20
>>  Your duty must always be in the inclusive range [1, period]
>>  (hardware values, not ns). A duty of 0 is a hardware fault
>>  (on the jz4740 it is).
>=20
> From the PWM framework's POV duty cycle =3D 0 is perfectly valid.=20
> Similar
> to duty =3D=3D period. Not supporting dutz cycle 0 is another limitation=20
> of
> your PWM that should be documented.
>=20
> For actual use cases of duty cycle =3D 0 see drivers/hwmon/pwm-fan.c or
> drivers/leds/leds-pwm.c.

Perfectly valid for the PWM framework, maybe; but what is the expected
output then? A constant inactive state? Then I guess I can just disable
the PWM output in the driver when configured with duty =3D=3D 0.


>>  If you request duty =3D=3D 1 (the minimum), then the new duty is equal
>>  to (period - 1 + 1) =3D=3D period, which is the maximum of your range.
>>=20
>>  If you request duty =3D=3D period (the maximum), then the new duty
>>  calculated is equal to (period - period + 1) =3D=3D 1, which is the
>>  minimum of your range.
>>=20
>>=20
>>  > >
>>  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >  ---
>>  > >   drivers/pwm/pwm-jz4740.c | 22 +++++++++++++---------
>>  > >   1 file changed, 13 insertions(+), 9 deletions(-)
>>  > >
>>  > >  diff --git a/drivers/pwm/pwm-jz4740.c=20
>> b/drivers/pwm/pwm-jz4740.c
>>  > >  index 85e2110aae4f..8df898429d47 100644
>>  > >  --- a/drivers/pwm/pwm-jz4740.c
>>  > >  +++ b/drivers/pwm/pwm-jz4740.c
>>  > >  @@ -121,6 +121,7 @@ static int jz4740_pwm_apply(struct pwm_chip
>>  > > *chip, struct pwm_device *pwm,
>>  > >   		   *parent_clk =3D clk_get_parent(clk);
>>  > >   	unsigned long rate, parent_rate, period, duty;
>>  > >   	unsigned long long tmp;
>>  > >  +	bool polarity_inversed;
>>  > >   	int ret;
>>  > >
>>  > >   	parent_rate =3D clk_get_rate(parent_clk);
>>  > >  @@ -183,24 +184,27 @@ static int jz4740_pwm_apply(struct=20
>> pwm_chip
>>  > > *chip, struct pwm_device *pwm,
>>  > >   	/* Reset counter to 0 */
>>  > >   	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
>>  > >
>>  > >  -	/* Set duty */
>>  > >  -	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
>>  > >  -
>>  > >   	/* Set period */
>>  > >   	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
>>  > >
>>  > >  +	/*
>>  > >  +	 * The PWM will always start with the inactive part. To=20
>> counter that,
>>  > >  +	 * when PWM is enabled we switch the configured polarity,=20
>> and use
>>  > >  +	 * 'period - duty + 1' as the real duty.
>>  > >  +	 */
>>  > >  +
>>  > >  +	/* Set duty */
>>  > >  +	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), period=20
>> - duty + 1);
>>  > >  +
>>  >
>>  > Before you set duty first, then period, now you do it the other=20
>> way
>>  > round. Is there a good reason?
>>=20
>>  To move it below the comment that explains why we use 'period -=20
>> duty + 1'.
>>=20
>>  We modify that line anyway, so it's not like it makes the patch=20
>> much more
>>  verbose.
>=20
> It doesn't make it more verbose, but that's not the background of my
> question. For most(?) PWM implementation the order of hardware=20
> accesses
> matters and introducing such a difference as an unneeded side effect
> isn't optimal.

There's no side effect. The PWM is disabled when reconfigured.


> Why not add the comment above the line that already used to set the=20
> duty
> in hardware?

I thought it made sense to have the two parts of the trick closer=20
together
in the code, below the comment, so that it's clearer what it does.


>>  > >   	/* Set polarity */
>>  > >  -	switch (state->polarity) {
>>  > >  -	case PWM_POLARITY_NORMAL:
>>  > >  +	polarity_inversed =3D state->polarity =3D=3D PWM_POLARITY_INVERS=
ED;
>>  > >  +	if (!polarity_inversed ^ state->enabled)
>>  >
>>  > Why does state->enabled suddenly matter here?
>>=20
>>  The pin stay inactive when the PWM is disabled, but the level of the
>>  inactive state depends on the polarity of the pin. So we need to=20
>> switch
>>  the polarity only when the PWM is enabled.
>=20
> After some thought I got that. When knowing this, this is already
> mentioned in the comment you introduced as you write about enabled=20
> PWMs
> only. Maybe it's just me, but mentioning that case more explicit would
> have helped me. Something like:
>=20
> 	/*
> 	 * The hardware always starts a period with the inactive part.
> 	 * So invert polarity and duty cycle to yield the output that is
> 	 * expected by the PWM framework and its users. This inversion
> 	 * must not be done for a disabled PWM however because otherwise
> 	 * it outputs a constant active level.
> 	 */

Ok.


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

