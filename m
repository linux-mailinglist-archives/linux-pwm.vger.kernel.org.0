Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B00880FE
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 19:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406944AbfHIROw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 13:14:52 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39928 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406904AbfHIROw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 13:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565370890; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBF70ikDL6fPc+9/M1xLUZZCUEyNQzKqucMV2lu69b0=;
        b=OHuayD5C4YxMSNWFpLoKb4za3Mo+lSg86cemNyoEcNWI7ikdgP9TYbYZ/A6e6RLaU+ecX8
        sSfo2fNw/j+xfuaMLUr2+hLDPIQIaX7sHGZ2G1aG/UJK2NJDbiKQnmIXsjzoBocBYGhstY
        HyzfDhc3jAbONzTXyeb8suYuRNiJsYQ=
Date:   Fri, 09 Aug 2019 19:14:45 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1565370885.2091.2@crapouillou.net>
In-Reply-To: <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-5-paul@crapouillou.net>
        <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le ven. 9 ao=FBt 2019 =E0 19:05, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil wrote:
>>  The previous algorithm hardcoded details about how the TCU clocks=20
>> work.
>>  The new algorithm will use clk_round_rate to find the perfect clock=20
>> rate
>>  for the PWM channel.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Mathieu Malaterre <malat@debian.org>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>   drivers/pwm/pwm-jz4740.c | 60=20
>> +++++++++++++++++++++++++++++-----------
>>   1 file changed, 44 insertions(+), 16 deletions(-)
>>=20
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index 6ec8794d3b99..f20dc2e19240 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -110,24 +110,56 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>   	struct clk *clk =3D pwm_get_chip_data(pwm),
>>   		   *parent_clk =3D clk_get_parent(clk);
>>  -	unsigned long rate, period, duty;
>>  +	unsigned long rate, parent_rate, period, duty;
>>   	unsigned long long tmp;
>>  -	unsigned int prescaler =3D 0;
>>  +	int ret;
>>=20
>>  -	rate =3D clk_get_rate(parent_clk);
>>  -	tmp =3D (unsigned long long)rate * state->period;
>>  -	do_div(tmp, 1000000000);
>>  -	period =3D tmp;
>>  +	parent_rate =3D clk_get_rate(parent_clk);
>>  +
>>  +	jz4740_pwm_disable(chip, pwm);
>>=20
>>  -	while (period > 0xffff && prescaler < 6) {
>>  -		period >>=3D 2;
>>  -		rate >>=3D 2;
>>  -		++prescaler;
>>  +	/* Reset the clock to the maximum rate, and we'll reduce it if=20
>> needed */
>>  +	ret =3D clk_set_max_rate(clk, parent_rate);
>=20
> What is the purpose of this call? IIUC this limits the allowed range=20
> of
> rates for clk. I assume the idea is to prevent other consumers to=20
> change
> the rate in a way that makes it unsuitable for this pwm. But this only
> makes sense if you had a notifier for clk changes, doesn't it? I'm
> confused.

Nothing like that. The second call to clk_set_max_rate() might have set
a maximum clock rate that's lower than the parent's rate, and we want to
undo that.


> I think this doesn't match the commit log, you didn't even introduced=20
> a
> call to clk_round_rate().

Right, I'll edit the commit message.


>>  +	if (ret) {
>>  +		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
>>  +		return ret;
>>   	}
>>=20
>>  -	if (prescaler =3D=3D 6)
>>  -		return -EINVAL;
>>  +	ret =3D clk_set_rate(clk, parent_rate);
>>  +	if (ret) {
>>  +		dev_err(chip->dev, "Unable to reset to parent rate (%lu Hz)",
>>  +			parent_rate);
>>  +		return ret;
>>  +	}
>>  +
>>  +	/*
>>  +	 * Limit the clock to a maximum rate that still gives us a period=20
>> value
>>  +	 * which fits in 16 bits.
>>  +	 */
>>  +	tmp =3D 0xffffull * NSEC_PER_SEC;
>>  +	do_div(tmp, state->period);
>>=20
>>  +	ret =3D clk_set_max_rate(clk, tmp);
>=20
> And now you change the maximal rate again?

Basically, we start from the maximum clock rate we can get for that PWM
- which is the rate of the parent clk - and from that compute the=20
maximum
clock rate that we can support that still gives us < 16-bits hardware
values for the period and duty.

We then pass that computed maximum clock rate to clk_set_max_rate(),=20
which
may or may not update the current PWM clock's rate to match the new=20
limits.
Finally we read back the PWM clock's rate and compute the period and=20
duty
from that.


>>  +	if (ret) {
>>  +		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
>>  +		return ret;
>>  +	}
>>  +
>>  +	/*
>>  +	 * Read back the clock rate, as it may have been modified by
>>  +	 * clk_set_max_rate()
>>  +	 */
>>  +	rate =3D clk_get_rate(clk);
>>  +
>>  +	if (rate !=3D parent_rate)
>>  +		dev_dbg(chip->dev, "PWM clock updated to %lu Hz\n", rate);
>>  +
>>  +	/* Calculate period value */
>>  +	tmp =3D (unsigned long long)rate * state->period;
>>  +	do_div(tmp, NSEC_PER_SEC);
>>  +	period =3D (unsigned long)tmp;
>>  +
>>  +	/* Calculate duty value */
>>   	tmp =3D (unsigned long long)period * state->duty_cycle;
>>   	do_div(tmp, state->period);
>>   	duty =3D period - tmp;
>>  @@ -135,14 +167,10 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   	if (duty >=3D period)
>>   		duty =3D period - 1;
>>=20
>>  -	jz4740_pwm_disable(chip, pwm);
>>  -
>>   	/* Set abrupt shutdown */
>>   	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>>   			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
>>=20
>>  -	clk_set_rate(clk, rate);
>>  -
>=20
> It's not obvious to me why removing these two lines belong in the
> current patch.

They're not removed, they're both moved up in the function.


> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |

=

