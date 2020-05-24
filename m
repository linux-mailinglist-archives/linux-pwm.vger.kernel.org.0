Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1631E0143
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2020 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgEXRvg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 May 2020 13:51:36 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53810 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgEXRvg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 13:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590342693; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHKb/Iq1AG0ntYJ2JavpAxwKFvwXNJiyIwNojQekjnc=;
        b=STVIqDnaxuWOvarIU0u80E3ZXic3lrHT0axrrRvff4XGCFXLqm0A3gazUzDrPwxWv06Nu+
        NIfdvsEufqyZ3X4PfsToZHSrEzpHveGzVFJEwfagFn5w+kZ6rZrd0E9q7F/3chrAhFS1IL
        HDX/yRNgLTtdJbr0mw0lBw7r2Ir/yYk=
Date:   Sun, 24 May 2020 19:51:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] pwm: jz4740: Add support for the JZ4725B
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <N9KUAQ.VPI8V42FNJQU@crapouillou.net>
In-Reply-To: <20200524173711.ofprgoueyimhkowj@pengutronix.de>
References: <20200413121445.72996-1-paul@crapouillou.net>
        <20200413121445.72996-3-paul@crapouillou.net>
        <20200524173711.ofprgoueyimhkowj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Le dim. 24 mai 2020 =E0 19:37, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Mon, Apr 13, 2020 at 02:14:45PM +0200, Paul Cercueil wrote:
>>  The PWM hardware in the JZ4725B works the same as in the JZ4740,=20
>> but has
>>  only six channels available.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      I did not add documentation for the new jz4725b-pwm compatible
>>      string on purpose. The reason is that the documentation file
>>      for the Timer/Counter Unit (TCU) of Ingenic SoCs will be
>>      completely rewritten from .txt to YAML in a separate patchset.
>>=20
>>   drivers/pwm/pwm-jz4740.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>=20
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index f566f9d248d6..bb27934fb6c2 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -22,6 +22,10 @@
>>=20
>>   #define NUM_PWM 8
>>=20
>>  +struct soc_info {
>>  +	unsigned int num_pwms;
>>  +};
>>  +
>>   struct jz4740_pwm_chip {
>>   	struct pwm_chip chip;
>>   	struct regmap *map;
>>  @@ -36,7 +40,7 @@ static bool jz4740_pwm_can_use_chn(struct=20
>> jz4740_pwm_chip *jz,
>>   				   unsigned int channel)
>>   {
>>   	/* Enable all TCU channels for PWM use by default except channels=20
>> 0/1 */
>>  -	u32 pwm_channels_mask =3D GENMASK(NUM_PWM - 1, 2);
>>  +	u32 pwm_channels_mask =3D GENMASK(jz->chip.npwm - 1, 2);
>>=20
>>   	device_property_read_u32(jz->chip.dev->parent,
>>   				 "ingenic,pwm-channels-mask",
>>  @@ -214,6 +218,7 @@ static int jz4740_pwm_probe(struct=20
>> platform_device *pdev)
>>   {
>>   	struct device *dev =3D &pdev->dev;
>>   	struct jz4740_pwm_chip *jz4740;
>>  +	const struct soc_info *info =3D device_get_match_data(dev);
>>=20
>>   	jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
>>   	if (!jz4740)
>>  @@ -227,8 +232,8 @@ static int jz4740_pwm_probe(struct=20
>> platform_device *pdev)
>>=20
>>   	jz4740->chip.dev =3D dev;
>>   	jz4740->chip.ops =3D &jz4740_pwm_ops;
>>  -	jz4740->chip.npwm =3D NUM_PWM;
>>   	jz4740->chip.base =3D -1;
>>  +	jz4740->chip.npwm =3D info ? info->num_pwms : NUM_PWM;
>=20
> Can info be actually NULL? I don't think so, so you can just use
> info->num_pwms here and drop the definition of NUM_PWM.

In *theory* it can be NULL if the kernel is configured without=20
CONFIG_OF, which will never happen on any board supported by this=20
driver. I can add a dependency on CONFIG_OF in V2, then use=20
info->num_pwms there.

cheers,
-Paul

>>   	jz4740->chip.of_xlate =3D of_pwm_xlate_with_flags;
>>   	jz4740->chip.of_pwm_n_cells =3D 3;
>>=20
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> https://www.pengutronix.de/ |


