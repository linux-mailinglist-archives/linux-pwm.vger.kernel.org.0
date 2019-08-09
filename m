Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092568814B
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 19:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436887AbfHIRde (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 13:33:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55322 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436858AbfHIRdd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 13:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565372011; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icXuKfalj37N3BS3zcYvCsKRSpIAVMBWGSyQDHHsyjw=;
        b=N0yg7sUqfeUGj36TFupEeSA/BoeodMTG0WZjMZOEhjyfbDtRbuoFvBlkzRPveYQsMADoCR
        tb0QE8NwWgyhIIfoOuaaAge7y6/U3RNz4HHsJ/hJ3JnRCi7Lij6DgQZ0lswdLUHUm6eikP
        UrqTDsPQO6/kqToM5/gkCOdUboKN7Mw=
Date:   Fri, 09 Aug 2019 19:33:24 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 6/7] pwm: jz4740: Make PWM start with the active part
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1565372004.2091.3@crapouillou.net>
In-Reply-To: <20190809171058.gothydohec6qx7hu@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-7-paul@crapouillou.net>
        <20190809171058.gothydohec6qx7hu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le ven. 9 ao=FBt 2019 =E0 19:10, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Fri, Aug 09, 2019 at 02:30:30PM +0200, Paul Cercueil wrote:
>>  The PWM will always start with the inactive part. To counter that,
>>  when PWM is enabled we switch the configured polarity, and use
>>  'period - duty + 1' as the real duty.
>=20
> Where does the + 1 come from? This looks wrong. (So if duty=3D0 is
> requested you use duty =3D period + 1?)

You'd never request duty =3D=3D 0, would you?

Your duty must always be in the inclusive range [1, period]
(hardware values, not ns). A duty of 0 is a hardware fault
(on the jz4740 it is).

If you request duty =3D=3D 1 (the minimum), then the new duty is equal
to (period - 1 + 1) =3D=3D period, which is the maximum of your range.

If you request duty =3D=3D period (the maximum), then the new duty
calculated is equal to (period - period + 1) =3D=3D 1, which is the
minimum of your range.


>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/pwm/pwm-jz4740.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>=20
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index 85e2110aae4f..8df898429d47 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -121,6 +121,7 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   		   *parent_clk =3D clk_get_parent(clk);
>>   	unsigned long rate, parent_rate, period, duty;
>>   	unsigned long long tmp;
>>  +	bool polarity_inversed;
>>   	int ret;
>>=20
>>   	parent_rate =3D clk_get_rate(parent_clk);
>>  @@ -183,24 +184,27 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   	/* Reset counter to 0 */
>>   	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
>>=20
>>  -	/* Set duty */
>>  -	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
>>  -
>>   	/* Set period */
>>   	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
>>=20
>>  +	/*
>>  +	 * The PWM will always start with the inactive part. To counter=20
>> that,
>>  +	 * when PWM is enabled we switch the configured polarity, and use
>>  +	 * 'period - duty + 1' as the real duty.
>>  +	 */
>>  +
>>  +	/* Set duty */
>>  +	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), period -=20
>> duty + 1);
>>  +
>=20
> Before you set duty first, then period, now you do it the other way
> round. Is there a good reason?

To move it below the comment that explains why we use 'period - duty +=20
1'.

We modify that line anyway, so it's not like it makes the patch much=20
more
verbose.


>=20
>>   	/* Set polarity */
>>  -	switch (state->polarity) {
>>  -	case PWM_POLARITY_NORMAL:
>>  +	polarity_inversed =3D state->polarity =3D=3D PWM_POLARITY_INVERSED;
>>  +	if (!polarity_inversed ^ state->enabled)
>=20
> Why does state->enabled suddenly matter here?

The pin stay inactive when the PWM is disabled, but the level of the
inactive state depends on the polarity of the pin. So we need to switch
the polarity only when the PWM is enabled.


>>   		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>>   				   TCU_TCSR_PWM_INITL_HIGH, 0);
>>  -		break;
>>  -	case PWM_POLARITY_INVERSED:
>>  +	else
>>   		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>>   				   TCU_TCSR_PWM_INITL_HIGH,
>>   				   TCU_TCSR_PWM_INITL_HIGH);
>>  -		break;
>>  -	}
>>=20
>>   	if (state->enabled)
>>   		jz4740_pwm_enable(chip, pwm);
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

