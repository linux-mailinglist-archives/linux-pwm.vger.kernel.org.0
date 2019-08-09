Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F27880BA
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 19:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437127AbfHIRFE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 13:05:04 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59874 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437086AbfHIRFE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 13:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565370302; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujX0iA9Z9xPJJ23+DKST7S4VIRynKN5s6HjiqNe7lIc=;
        b=KyEGCBRD9oSQGnis+Gnx7CO48LLy+zQ8qaMvm+Uqlluat7LreuGFr9bfZB++zqEf/9C3BS
        P3Mj1CLJuNS/o0+of5649sNXy2hqHcIMztQrMvQ/8jN8cwGV5q8xKy+jqM9QG4Rn3Rcfsh
        z64mLRPYDhdXS4Vz50x55s5WcSS7zhU=
Date:   Fri, 09 Aug 2019 19:04:56 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/7] pwm: jz4740: Obtain regmap from parent node
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1565370296.2091.1@crapouillou.net>
In-Reply-To: <20190809165147.wf7f5jfsvycysm5h@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-2-paul@crapouillou.net>
        <20190809165147.wf7f5jfsvycysm5h@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,


Le ven. 9 ao=FBt 2019 =E0 18:51, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Fri, Aug 09, 2019 at 02:30:25PM +0200, Paul Cercueil wrote:
>>  The TCU registers are shared between a handful of drivers, accessing
>>  them through the same regmap.
>>=20
>>  While this driver is devicetree-compatible, it is never (as of now)
>>  probed from devicetree, so this change does not introduce a ABI=20
>> problem
>>  with current devicetree files.
>=20
> If you adapt the binding also update the binding doc please.

It's already updated, in mips-next, so it'll be in the next -rc1.


>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Mathieu Malaterre <malat@debian.org>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>=20
> nitpick: put your S-o-b line after the other tags you added.
>=20
>>  ---
>>   drivers/pwm/Kconfig      |  1 +
>>   drivers/pwm/pwm-jz4740.c | 80=20
>> ++++++++++++++++++++++++++--------------
>>   2 files changed, 53 insertions(+), 28 deletions(-)
>>=20
>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  index a7e57516959e..cc4df0ec978a 100644
>>  --- a/drivers/pwm/Kconfig
>>  +++ b/drivers/pwm/Kconfig
>>  @@ -225,6 +225,7 @@ config PWM_IMX_TPM
>>   config PWM_JZ4740
>>   	tristate "Ingenic JZ47xx PWM support"
>>   	depends on MACH_INGENIC
>>  +	select MFD_SYSCON
>>   	help
>>   	  Generic PWM framework driver for Ingenic JZ47xx based
>>   	  machines.
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index f901e8a0d33d..7aea5e0c6e18 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -8,18 +8,20 @@
>>   #include <linux/err.h>
>>   #include <linux/gpio.h>
>>   #include <linux/kernel.h>
>>  +#include <linux/mfd/ingenic-tcu.h>
>>  +#include <linux/mfd/syscon.h>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pwm.h>
>>  -
>>  -#include <asm/mach-jz4740/timer.h>
>>  +#include <linux/regmap.h>
>>=20
>>   #define NUM_PWM 8
>>=20
>>   struct jz4740_pwm_chip {
>>   	struct pwm_chip chip;
>>   	struct clk *clk;
>>  +	struct regmap *map;
>>   };
>>=20
>>   static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip=20
>> *chip)
>>  @@ -29,6 +31,8 @@ static inline struct jz4740_pwm_chip=20
>> *to_jz4740(struct pwm_chip *chip)
>>=20
>>   static int jz4740_pwm_request(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>   {
>>  +	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
>>  +
>>   	/*
>>   	 * Timers 0 and 1 are used for system tasks, so they are=20
>> unavailable
>>   	 * for use as PWMs.
>>  @@ -36,50 +40,53 @@ static int jz4740_pwm_request(struct pwm_chip=20
>> *chip, struct pwm_device *pwm)
>>   	if (pwm->hwpwm < 2)
>>   		return -EBUSY;
>>=20
>>  -	jz4740_timer_start(pwm->hwpwm);
>>  +	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
>=20
> jz4740_timer_start does
>=20
> 	writel(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_STOP_CLEAR);
>=20
> with
>=20
> #define JZ_REG_TIMER_STOP_CLEAR         0x2C
>=20
> and
>=20
> #define TCU_REG_TSCR            0x3c
>=20
> I wonder why the offsets are different.

The offset are different because the base is different.


>>=20
>>   	return 0;
>>   }
>>=20
>>   static void jz4740_pwm_free(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>   {
>>  -	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
>>  +	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
>>=20
>>  -	jz4740_timer_stop(pwm->hwpwm);
>>  +	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
>=20
> jz4740_timer_set_ctrl writes to offset (((pwm->hwpwm) * 0x10) + 0x3C)
> and jz4740_timer_stop to offset 0x1c. The regmap_write doesn't do both
> of them but instead writes to offset 0x3c.

I guess it should have been TCU_REG_TSSR ("Timer Stop Set Register") and
I didn't notice because the next patch drops this write anyway.

I'll do as you suggested in your other reply and swap the two patches if
it makes things easier, it'll get rid of this write.


> So this doesn't seem to be a 1:1 conversion. This either needs fixing,
> splitting into several patches or a better commit log.
>=20
> Stopping my review here.
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

