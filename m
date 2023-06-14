Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0828272F519
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jun 2023 08:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbjFNGpX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jun 2023 02:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbjFNGpT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jun 2023 02:45:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AAFE79
        for <linux-pwm@vger.kernel.org>; Tue, 13 Jun 2023 23:45:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9KFm-0006iV-9S; Wed, 14 Jun 2023 08:45:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9KFj-007IIE-WF; Wed, 14 Jun 2023 08:45:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9KFj-00E7bn-4s; Wed, 14 Jun 2023 08:45:11 +0200
Date:   Wed, 14 Jun 2023 08:45:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Message-ID: <20230614064510.nm3hhokjxe37hrjo@pengutronix.de>
References: <20230512185551.183049-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oabiqhvlhn4qzbtb"
Content-Disposition: inline
In-Reply-To: <20230512185551.183049-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oabiqhvlhn4qzbtb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 08:55:51PM +0200, Marek Vasut wrote:
> The PWM beeper volume can be controlled by adjusting the PWM duty cycle,
> expose volume setting via sysfs, so users can make the beeper quieter.
> This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0
> to 50% in 1/1000th of percent steps, this resolution should be sufficient.
>=20
> The reason for 50000 cap on volume or PWM duty cycle is because duty cycle
> above 50% again reduces the loudness, the PWM wave form is inverted wave
> form of the one for duty cycle below 50% and the beeper gets quieter the
> closer the setting is to 100% . Hence, 50% cap where the wave form yields
> the loudest result.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> An alternative option would be to extend the userspace input ABI, e.g. by
> using SND_TONE top 16bits to encode the duty cycle in 0..50000 range, and
> bottom 16bit to encode the existing frequency in Hz . Since frequency in
> Hz is likely to be below some 25 kHz for audible bell, this fits in 16bits
> just fine. Thoughts ?
> ---
> NOTE: This uses approach similar to [1], except it is much simpler.
>       [1] https://patchwork.kernel.org/project/linux-input/cover/20230201=
152128.614439-1-manuel.traut@mt.com/
> ---
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
> Cc: Manuel Traut <manuel.traut@mt.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> ---
>  drivers/input/misc/pwm-beeper.c | 58 ++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-bee=
per.c
> index 3cf1812384e6a..f63d0ebbaf573 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -21,6 +21,7 @@ struct pwm_beeper {
>  	struct regulator *amplifier;
>  	struct work_struct work;
>  	unsigned long period;
> +	unsigned long duty_cycle;
>  	unsigned int bell_frequency;
>  	bool suspended;
>  	bool amplifier_on;
> @@ -37,7 +38,7 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, uns=
igned long period)
> =20
>  	state.enabled =3D true;
>  	state.period =3D period;
> -	pwm_set_relative_duty_cycle(&state, 50, 100);
> +	pwm_set_relative_duty_cycle(&state, beeper->duty_cycle, 100000);
> =20
>  	error =3D pwm_apply_state(beeper->pwm, &state);
>  	if (error)
> @@ -119,6 +120,53 @@ static void pwm_beeper_close(struct input_dev *input)
>  	pwm_beeper_stop(beeper);
>  }
> =20
> +static ssize_t volume_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct pwm_beeper *beeper =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%ld\n", beeper->duty_cycle);
> +}
> +
> +static ssize_t volume_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct pwm_beeper *beeper =3D dev_get_drvdata(dev);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Volume is really PWM duty cycle in pcm (per cent mille, 1/1000th
> +	 * of percent). This value therefore ranges from 0 to 50000 . Duty
> +	 * cycle of 50% =3D 50000pcm is the maximum volume .
> +	 */
> +	val =3D clamp(val, 0UL, 50000UL);

I wonder if you want to refuse values here that are not in the specified
range, that is, something like:

	if (val !=3D clamp(val, 0UL, 50000UL))
		return -EINVAL;

I think this is more in line who other sysfs properties work?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oabiqhvlhn4qzbtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSJYfYACgkQj4D7WH0S
/k4WDggAsRPviTQmYHGrsB+ITujDXMk7fmUOBgXeEz5F5LrKdSDgHvE2uJXRfuVu
J5JrWsHzU2Sup5UVd7nnZp5ZryG6dp8vxHSpSQSJbKA9P6151piWg9uxstrcwiuP
BtZyfQoH6xDOOeNaiz0j4I/6fAMhdb9Xekv/OeDiNq7/EEx6vKWQNfdyPGCN6pyo
mV5oUjJJQzOlhUp49EXJPhGvklc9mbUDmzXnAE9c94tqulpENXeddF/DNw0BSxzp
yRevwaPIwXZuvlXgB6tQ1VYSHzwyIuLgx5pK3tzkVRyx/PvZ40Rv4UotgNaEfOio
PGngBpdOuu26mzUEPksWaL+Jhhxm5A==
=bbjy
-----END PGP SIGNATURE-----

--oabiqhvlhn4qzbtb--
