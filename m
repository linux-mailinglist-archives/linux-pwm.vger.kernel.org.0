Return-Path: <linux-pwm+bounces-148-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C599C7F4E01
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 18:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B331280DBD
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14C5786E;
	Wed, 22 Nov 2023 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrzZYS1V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C014C83;
	Wed, 22 Nov 2023 09:15:36 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a00b056ca38so405683266b.2;
        Wed, 22 Nov 2023 09:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700673335; x=1701278135; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0A4v2zEkCQh6vK0gV5ezd/1QpRcyGTIPQVZmBBe+ht4=;
        b=TrzZYS1VzuNRpU8VsOMxj1np5U7fDgb9+Y5Ycur++s8bN8m3ATWwQYtFPFUf5/PYpj
         XK/g0EI2dWSDawD14H4r5h6EuRTN4jgCa9NszQgrl3/avH5GFN2RPaZnApEbBZ2JsRH5
         y+SpYFpRvyebhTf8EPD/6BkZBBYmGJv+yU/GyK42WMEj/dlekZ00S52hH3GitkfUCNgL
         LBMI9ruQHIfQ7WAtE81EXkHLPrm/Zt0xLkFk5dTvbiqiVEDxXEXg4uctKPByH/L2Cc40
         cNnwiYB97Iz1wOymLYPL85hES1OVGwgcHUZxEQcOjoKVPKPyqjRrRrYT991cBCKImb3+
         aRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673335; x=1701278135;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A4v2zEkCQh6vK0gV5ezd/1QpRcyGTIPQVZmBBe+ht4=;
        b=GusssjUcmBHiGtcL4y7n7bdDDOgwh5dRMH39Pcac8MX1ofRCkvOi/qPJe3l6bxnKAB
         XDPMfbjrFQ6PtVIY816juDM5EPPdGXw9rTGCo3u3SOP8KpKpsO221KCMQa53q8lY3pqR
         SgKm8bMSsptZgecA9+bm8YCKmzIsu17z2ui/r4lQtxnXWRqZ7Z8mpSFokfIk1wyMbsLO
         CzBq3ie/IWGhOG1I4iO7rNnKTDrNTNPrzolfJU64NhYbm6JsCkrY6e+Msqd8eQcOou85
         qonOPuFAtScKzeuSUKj2NDyLO49nNqP2bZP7BqqLmn3pXuQc1KwN/THZMXQFPJEZL16/
         t8nw==
X-Gm-Message-State: AOJu0YzufrThMsUaDZJ7DC7u+qUcF2BhINySHUFxhvMpSztOfCFK7aCe
	uZiX83rdb8qOLS0khbOJLkU=
X-Google-Smtp-Source: AGHT+IEnM+zdKXO3s2SNFBpyP4Rkmqts+o476UisMHXXSvyzUTzmcvUAoCzFE5Q9up+ZrBVe0d/6Dg==
X-Received: by 2002:a17:906:7481:b0:9ff:1e84:76fc with SMTP id e1-20020a170906748100b009ff1e8476fcmr1721362ejl.5.1700673334755;
        Wed, 22 Nov 2023 09:15:34 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906560400b009ff10633221sm3805456ejq.128.2023.11.22.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:15:34 -0800 (PST)
Date: Wed, 22 Nov 2023 18:15:32 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Pavel Machek <pavel@ucw.cz>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Rob Herring <robh@kernel.org>, Kees Cook <keescook@chromium.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-leds@vger.kernel.org, kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <ZV43NHr1QN79lsaJ@orome.fritz.box>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231122115621.GK173820@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bVcNKODKZhCay43z"
Content-Disposition: inline
In-Reply-To: <20231122115621.GK173820@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--bVcNKODKZhCay43z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:56:21AM +0000, Lee Jones wrote:
> On Tue, 21 Nov 2023, Uwe Kleine-K=C3=B6nig wrote:
>=20
> > This prepares the pwm sub-driver to further changes of the pwm core
> > outlined in the commit introducing devm_pwmchip_alloc(). There is no
> > intended semantical change and the driver should behave as before.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
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
> > @@ -995,7 +1001,7 @@ static int lpg_pwm_request(struct pwm_chip *chip, =
struct pwm_device *pwm)
> >  static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  			 const struct pwm_state *state)
> >  {
> > -	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> > +	struct lpg *lpg =3D lpg_pwm_from_chip(chip);
> >  	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> >  	int ret =3D 0;
> > =20
> > @@ -1026,7 +1032,7 @@ static int lpg_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >  static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> >  			     struct pwm_state *state)
> >  {
> > -	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> > +	struct lpg *lpg =3D lpg_pwm_from_chip(chip);
> >  	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> >  	unsigned int resolution;
> >  	unsigned int pre_div;
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

Indeed. This highlights one of the weaker parts of this whole design and
I really don't like it. The whole chip_alloc() construct works fine if
you have everything isolated nicely in a single driver and subsystem
(like you usually have in network land), but for cases like this where
things are spread throughout and a device is actually more than just a
PWM controller, it looks like we now have to work around this design
because it doesn't fit.

In fact, this reminds me about the "midlayer mistake" in many ways and
combined with what Bartosz said, I'm not sure this is going to hold up
very well the more special cases we get.

Thierry

--bVcNKODKZhCay43z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVeNzIACgkQ3SOs138+
s6GkTQ//ciTVXCzu6NSf0F65LnTXkqrp2w2cNJwJrskm+q/eRcHFVDJM9wFoZFS2
zJrB3Xni/iRHJxtey5D1v2az1HdHq9JB4HbLaL6J8dA64Jk9RnXpDbUvt6k3UJAK
RVZr2lySGc9kepWY7C2tUxtBHhQbxstHflYxL4DiFldlzPlupjjrimdT9uReGACn
4PQpS1mXvLFFXA3zimM0JttGVzcPerrdOCAXcujI+gQwfow6Fw/ix+B/s/y4Uzmc
opPqvD2ImklRhtwxyc8nhIWUaHvpNTa85OYScy3eWnEaV+bWWtrBruYclgK5OpCZ
5tqcA2xynmIibbs+tRbTm96GtDPENWKueZg/7eM5liU4Q5efbLZEI7h5Oo68Q9XB
kKauSQ2uLNsLNcPn1N3USiFQEGte4Axz6s+l+QkCAKvLj85e+PyuLweCp4R8cdfB
g4X18gOSZUVZBGXJ1vVV5ZZgNkzTmJTLFCSnkBcAAtCl5EeY8jnVUAhKdMRTDByD
JTRhG5ZphsGjAk+CqzKwN+2pU0yDxNnhCReg1fuqWuD1UMbJf1QUdkUSG12YxkeV
Gx3HOfnnC5V504h5mz3SN63+PzDUDPqHaCONR3eHcNhwOkZHIjb5lR8m6xia9Qqu
EJBW8Y0MCzBBOEz0qn9ebtvWiVlpbwGu1DECmySzSq5qOabU8js=
=fmvG
-----END PGP SIGNATURE-----

--bVcNKODKZhCay43z--

