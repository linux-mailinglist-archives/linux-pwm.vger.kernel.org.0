Return-Path: <linux-pwm+bounces-118-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71787F32B6
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 16:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F78282DDC
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575F56776;
	Tue, 21 Nov 2023 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B9A0
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 07:51:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5T2b-0006Jz-7c; Tue, 21 Nov 2023 16:51:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5T2a-00AcF7-KQ; Tue, 21 Nov 2023 16:51:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5T2a-0052T6-BI; Tue, 21 Nov 2023 16:51:56 +0100
Date: Tue, 21 Nov 2023 16:51:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org,
	linux-mips@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 014/108] pwm: jz4740: Make use of pwmchip_parent()
 macro
Message-ID: <20231121155156.pi6e4mlov2ke2rfx@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-15-u.kleine-koenig@pengutronix.de>
 <ba21c20b20364a39d5ffff81dac8bd300a746dbb.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ic7kkssgaahevrve"
Content-Disposition: inline
In-Reply-To: <ba21c20b20364a39d5ffff81dac8bd300a746dbb.camel@crapouillou.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ic7kkssgaahevrve
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paul,

On Tue, Nov 21, 2023 at 03:13:58PM +0100, Paul Cercueil wrote:
> Le mardi 21 novembre 2023 =E0 14:49 +0100, Uwe Kleine-K=F6nig a =E9crit=
=A0:
> > struct pwm_chip::dev is about to change. To not have to touch this
> > driver in the same commit as struct pwm_chip::dev, use the macro
> > provided for exactly this purpose.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > =A0drivers/pwm/pwm-jz4740.c | 17 ++++++++---------
> > =A01 file changed, 8 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> > index e9375de60ad6..555c2db3968d 100644
> > --- a/drivers/pwm/pwm-jz4740.c
> > +++ b/drivers/pwm/pwm-jz4740.c
> > @@ -35,13 +35,12 @@ static inline struct jz4740_pwm_chip
> > *to_jz4740(struct pwm_chip *chip)
> > =A0	return container_of(chip, struct jz4740_pwm_chip, chip);
> > =A0}
> > =A0
> > -static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
> > -				=A0=A0 unsigned int channel)
> > +static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned
> > int channel)
> > =A0{
> > =A0	/* Enable all TCU channels for PWM use by default except
> > channels 0/1 */
> > -	u32 pwm_channels_mask =3D GENMASK(jz->chip.npwm - 1, 2);
> > +	u32 pwm_channels_mask =3D GENMASK(chip->npwm - 1, 2);
> > =A0
> > -	device_property_read_u32(jz->chip.dev->parent,
> > +	device_property_read_u32(pwmchip_parent(chip)->parent,
> > =A0				 "ingenic,pwm-channels-mask",
> > =A0				 &pwm_channels_mask);
>=20
> You could have used pwmchip_parent(&jz->chip) and not change the
> prototype.

Later in the series jz->chip goes away. So following your advice only
makes me touch this code once more later.

> > @@ -149,7 +148,7 @@ static int jz4740_pwm_apply(struct pwm_chip
> > *chip, struct pwm_device *pwm,
> > =A0	 */
> > =A0	rate =3D clk_round_rate(clk, tmp);
> > =A0	if (rate < 0) {
> > -		dev_err(chip->dev, "Unable to round rate: %ld",
> > rate);
> > +		dev_err(pwmchip_parent(chip), "Unable to round rate:
> > %ld", rate);
>=20
> While you're at it - and if you need a v4 - maybe sneak in a \n there?

I'll try to remember :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ic7kkssgaahevrve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVc0hsACgkQj4D7WH0S
/k5x+wf/aMnntCuRfV1rG8EiIOlMpAvPqa8iJIJ/Rt8LLmTjtMir9i+/qzUJcy6M
TqQN61e2vawrSa7PGJvFd5qlUWRKnzLtCHLS32xGcoL1oesAxWMUNH2/sE9Y8RXy
SKL65r/S5fEDCwWIUwnJ91vlc3qHkof3YHLwHqnVf6GmRLJEH6py5PJYlY9yYllZ
GyRRVaD5JeXrQ2+XK122ETY+VbuCdiY6FeP09anuQzwjOFK33mCAzmmIrLPikWq9
nIJKEgax9dDCb5I2djhh8XG5jRMkwsVqVTDzxUZ0qcZqR/5dWrr68C7bTYK6lB0l
/mDPXm9WUJU1ABuqCMCDkRnYU6djgA==
=/I1Y
-----END PGP SIGNATURE-----

--ic7kkssgaahevrve--

