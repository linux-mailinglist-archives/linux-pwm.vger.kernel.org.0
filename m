Return-Path: <linux-pwm+bounces-152-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828387F4EC8
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 18:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C18B20B46
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674AA58AA1;
	Wed, 22 Nov 2023 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E529A
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 09:54:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5rQX-0005dX-SL; Wed, 22 Nov 2023 18:54:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5rQW-00ArYV-A2; Wed, 22 Nov 2023 18:54:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5rQW-005sIg-0Q; Wed, 22 Nov 2023 18:54:16 +0100
Date: Wed, 22 Nov 2023 18:54:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>, linux-pwm@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>,
	Conor Dooley <conor.dooley@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	kernel@pengutronix.de,
	Anjelique Melendez <quic_amelende@quicinc.com>
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231122175413.5yxsdveausehkbgm@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231122115621.GK173820@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrfm7bxqupduhgxy"
Content-Disposition: inline
In-Reply-To: <20231122115621.GK173820@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--jrfm7bxqupduhgxy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Wed, Nov 22, 2023 at 11:56:21AM +0000, Lee Jones wrote:
> On Tue, 21 Nov 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > This prepares the pwm sub-driver to further changes of the pwm core
> > outlined in the commit introducing devm_pwmchip_alloc(). There is no
> > intended semantical change and the driver should behave as before.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/leds/rgb/leds-qcom-lpg.c | 30 +++++++++++++++++++++---------
> >  1 file changed, 21 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-q=
com-lpg.c
> > index 68d82a682bf6..283227e02df6 100644
> > --- a/drivers/leds/rgb/leds-qcom-lpg.c
> > +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> > @@ -77,7 +77,7 @@ struct lpg {
> > =20
> >  	struct mutex lock;
> > =20
> > -	struct pwm_chip pwm;
> > +	struct pwm_chip *pwm;
> > =20
> >  	const struct lpg_data *data;
> > =20
> > @@ -977,9 +977,15 @@ static int lpg_pattern_mc_clear(struct led_classde=
v *cdev)
> >  	return lpg_pattern_clear(led);
> >  }
> > =20
> > +static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
> > +{
> > +	struct lpg **lpg =3D pwmchip_priv(chip);
> > +	return *lpg;
> > +}
>=20
> I don't have easy-vis into the other patches, but if this is a common
> pattern, perhaps add a generic helper in <linux/pwm.h>?
>=20
> >  static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> >  {
> > -	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> > +	struct lpg *lpg =3D lpg_pwm_from_chip(chip);
> >  	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> > =20
> >  	return chan->in_use ? -EBUSY : 0;
> > [...]
> > @@ -1089,13 +1095,19 @@ static const struct pwm_ops lpg_pwm_ops =3D {
> > =20
> >  static int lpg_add_pwm(struct lpg *lpg)
> >  {
> > +	struct pwm_chip *chip;
> >  	int ret;
> > =20
> > -	lpg->pwm.dev =3D lpg->dev;
> > -	lpg->pwm.npwm =3D lpg->num_channels;
> > -	lpg->pwm.ops =3D &lpg_pwm_ops;
> > +	lpg->pwm =3D chip =3D devm_pwmchip_alloc(lpg->dev, lpg->num_channels,
> > +					     sizeof(&lpg));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > =20
> > -	ret =3D pwmchip_add(&lpg->pwm);
> > +	*(struct lpg **)pwmchip_priv(chip) =3D lpg;
>=20
> This is vile!

This is indeed one of the uglier conversions. It gets a bit prettier
with the following addon patch:

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-=
lpg.c
index 283227e02df6..e09eba823057 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -206,6 +206,10 @@ struct lpg_data {
 	const struct lpg_channel_data *channels;
 };
=20
+struct lpg_pwm_data {
+	struct lpg *lpg;
+};
+
 static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int ena=
ble)
 {
 	/* Skip if we don't have a triled block */
@@ -979,8 +983,9 @@ static int lpg_pattern_mc_clear(struct led_classdev *cd=
ev)
=20
 static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
 {
-	struct lpg **lpg =3D pwmchip_priv(chip);
-	return *lpg;
+	struct lpg_pwm_data *lpg_pwm_data =3D pwmchip_priv(chip);
+
+	return lpg_pwm_data->lpg;
 }
=20
 static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -1096,14 +1101,16 @@ static const struct pwm_ops lpg_pwm_ops =3D {
 static int lpg_add_pwm(struct lpg *lpg)
 {
 	struct pwm_chip *chip;
+	struct lpg_pwm_data *lpg_pwm_data;
 	int ret;
=20
 	lpg->pwm =3D chip =3D devm_pwmchip_alloc(lpg->dev, lpg->num_channels,
-					     sizeof(&lpg));
+					     sizeof(*lpg_pwm_data));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
=20
-	*(struct lpg **)pwmchip_priv(chip) =3D lpg;
+	lpg_pwm_data =3D pwmchip_priv(chip);
+	lpg_pwm_data->lpg =3D lpg;
=20
 	chip->ops =3D &lpg_pwm_ops;
=20
Would you like it better then?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jrfm7bxqupduhgxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVeQEQACgkQj4D7WH0S
/k6TSgf+NYrxLt4x3cBqSEIKT19/TgQYrqzFNa0JIttmGljwTrxewu5ux8sNDZe/
Rupp7CxoUv1wz5GGpcllLdN7p5x5/xhsYtRwanwY01fypXsb9urg6qMPv2GpIWyR
AMtpjUNG+dpbd/RVwhMqSYGmDABr8L16yjliBR3ujFi7Q2sOOU/myAl3zVXI/JYy
ONLJofnAsWbfsQtp/UcMaiSSFJkZBJ4ibxuQ0q0m6ZX7T/UOx83UIPTVxmfXPe1H
YVioOQ6a+xEI/SPREfJD0vteUPhYvTx7+f5Fgpz3hPyTeMtbEtf85/XgH5+znn5a
l/ydRbHBWgTmzr6thhQvUwZfJUFbAg==
=4wXt
-----END PGP SIGNATURE-----

--jrfm7bxqupduhgxy--

