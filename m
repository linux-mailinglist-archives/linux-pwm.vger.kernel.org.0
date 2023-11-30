Return-Path: <linux-pwm+bounces-272-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A35507FF3B1
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 16:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B012B20C3F
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A4524BD;
	Thu, 30 Nov 2023 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176AF10D5
	for <linux-pwm@vger.kernel.org>; Thu, 30 Nov 2023 07:37:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8j66-0007gd-Ip; Thu, 30 Nov 2023 16:37:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8j65-00Cf9X-Mp; Thu, 30 Nov 2023 16:37:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8j65-00BcjX-Df; Thu, 30 Nov 2023 16:37:01 +0100
Date: Thu, 30 Nov 2023 16:37:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH 1/3] pwm: Provide wrappers for storing and getting
 private data
Message-ID: <20231130153701.kawj2qy6pokbnsgl@pengutronix.de>
References: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
 <20231124215208.616551-2-u.kleine-koenig@pengutronix.de>
 <20231130145027.GA3259151@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="47doehy2vigesk7k"
Content-Disposition: inline
In-Reply-To: <20231130145027.GA3259151@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--47doehy2vigesk7k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 02:50:27PM +0000, Lee Jones wrote:
> On Fri, 24 Nov 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > Also call pwmchip_set_drvdata() in pwmchip_alloc() to have a sane
> > default. Might replace pwmchip_priv()?!
> >=20
> > After struct pwm_chip got its own struct device, this can make use of
> > dev_get_drvdata() and dev_set_drvdata() on that device.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c  |  2 ++
> >  include/linux/pwm.h | 19 +++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 17577a1c4efc..0cbce704cc0b 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -216,6 +216,8 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *=
parent, unsigned int npwm, si
> >  	chip->dev =3D parent;
> >  	chip->npwm =3D npwm;
> > =20
> > +	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
> > +
> >  	return chip;
> >  }
> >  EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index 3c62cf329ee0..7a32ac687717 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -302,6 +302,7 @@ struct pwm_chip {
> > =20
> >  	/* only used internally by the PWM framework */
> >  	struct pwm_device *pwms;
> > +	void *drvdata;
>=20
> I appreciate that this may be temporary, but why not use the precedent
> already set by struct device?
>=20
>   void            *driver_data;

Not sure I understood your question right. You wonder why I named the
struct member drvdata and not driver_data, right?

That's easy: I didn't look at struct device and just picked a name I
considered suiteable. I'm fine with driver_data, too, and will use that
for the next iteration.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--47doehy2vigesk7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVorBwACgkQj4D7WH0S
/k4sjAf9FVD/O2EvXRPJlRBtJmWVT3oQDzcFiJYCF+jAm5VszEdwlhNNkp4bd21C
Ca8ClRMPflZVAtiAOZESzEaTULg8rYLiDIyUuju2H53/sTXaAYTbbPnkFfn78ZUW
F/ocMzGx6FihIMo/vrqEUaM3G3C4hPeLkGNq8meA5xMqesGMmk1nHzZpOk4rGfMZ
quRP1/GkMuOiTLRaMO+hMt6CIhYftK9y/ACL7vkNYt/LXqiDPaxPbW1ovPr+3pFZ
ngfRIUPbD0K2d13vnzRS8JaeXvBtzhihB2fyBLzD+46wBAV/MVIopkG0SupZz4S1
XX5w35AhexO1wqxH49n7AYBppi3gGQ==
=S2bA
-----END PGP SIGNATURE-----

--47doehy2vigesk7k--

