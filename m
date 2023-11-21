Return-Path: <linux-pwm+bounces-120-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CEE7F32F2
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 16:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79CA3B21A6F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382159141;
	Tue, 21 Nov 2023 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F77D188
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 07:58:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5T99-0000HI-0r; Tue, 21 Nov 2023 16:58:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5T97-00AcFw-JQ; Tue, 21 Nov 2023 16:58:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5T97-0052rI-A0; Tue, 21 Nov 2023 16:58:41 +0100
Date: Tue, 21 Nov 2023 16:58:41 +0100
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
Message-ID: <20231121155841.hxqujogmm62hidec@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231121151640.GB173820@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwhmmmnud4nrgahc"
Content-Disposition: inline
In-Reply-To: <20231121151640.GB173820@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--rwhmmmnud4nrgahc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 03:16:40PM +0000, Lee Jones wrote:
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
>=20
> Does this need to be taken in with the other 107 patches?

Not necessarily. The dependencies are:

	- This patch depends on #37 which provides devm_pwmchip_alloc
	- Patches #104 and later depend on this one to be applied.

I didn't talk with Thierry yet about how this should be merged. If all
affected maintainers agree to let this all go via PWM this would be
good, but I can also live with going a bit slower and getting the pwm
bits in during the next merge window and the changes to the PWM drivers
not living in drivers/pwm adapted after that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rwhmmmnud4nrgahc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVc07AACgkQj4D7WH0S
/k5Z4Af7Bt9eKtnp4iO1shXcMIFiz6Uy9wyfxBX2Jk1V8eknyckYgVnI6FemukI1
acsKwnlrd/XXyist1clJs89VYKcJo5qB3zFXFbd5rxWvkMIthaxZxJckUYuQNJFl
R9mGvXP/B3ESKp6m50Y8R/+2S3CiOPM+c38X3yQEyBc5GIazGweTe+CzTD7XAZjD
GSEC/O9RtoQgkTUg4LNj0ynMs5zbaCR90+r7sZ5vBtlBOZCijOIDXuU7H2m0bDMP
5+vcN9FSfsIL53GzFy539YxHhvt0uEZo0uSre3ig94WYGw0EpaMbO7lyqvNp2BIV
oZy4cD6KW9rg7qM5i4qFk5KfV0yaLw==
=xjyA
-----END PGP SIGNATURE-----

--rwhmmmnud4nrgahc--

