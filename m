Return-Path: <linux-pwm+bounces-273-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133037FF3C4
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 16:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442D11C209CA
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 15:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F97524BA;
	Thu, 30 Nov 2023 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C159183
	for <linux-pwm@vger.kernel.org>; Thu, 30 Nov 2023 07:41:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8jAn-0008Jy-97; Thu, 30 Nov 2023 16:41:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8jAm-00Cf9x-Re; Thu, 30 Nov 2023 16:41:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8jAm-00BczD-IR; Thu, 30 Nov 2023 16:41:52 +0100
Date: Thu, 30 Nov 2023 16:41:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH 0/3] pwm: Alternative way to convert leds-qcom-lpg to
 devm_pwmchip_alloc()
Message-ID: <20231130154152.22yudzmxdst2a45s@pengutronix.de>
References: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
 <20231130145308.GB3259151@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3b6i2pmfftpyunpw"
Content-Disposition: inline
In-Reply-To: <20231130145308.GB3259151@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--3b6i2pmfftpyunpw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 02:53:08PM +0000, Lee Jones wrote:
> On Fri, 24 Nov 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > Hello,
> >=20
> > on my way home thinking about my pwm-lifetime series[1] it occurred to
> > me how the leds-qcom-lpg driver could be converted to use
> > pwmchip_alloc() much prettier. Instead of patch #102 it can just not use
> > the feature to allocate private data and use (a new)
> > pwmchip_{get,set}_drvdata() function pair.
> >=20
> > The 2nd patch is just split out of the conversion. In my original series
> > the equivalent was contained in the converting patch.
> >=20
> > I'd expect that this sorts out the concerns about the ugliness I added
> > in two of the "non-pure" PWM drivers. A similar approach can be used (w=
ith the
> > same changes in core.c and pwm.h) for adapting the ti-sn65dsi86 driver.
>=20
> This is much better, thank you.
>=20
> How should this be merged?

This will be included in my next iteration of the pwm lifetime series.
The question about which tree this will go in will get relevant once the
patches this change depends on are fleshed out.

If you like patch #2 this can go in already now. Feel free to pick it
up. If you won't, that's fine, too, then I will keep it in my series.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3b6i2pmfftpyunpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVorT8ACgkQj4D7WH0S
/k7qKwf/RJh/zBAr9Z2+NZtxhlWoVCrqNjAHGDxfaF4ZIKid67tgiGnHGDpQZofE
3QEnQaAdE3w6LLPIqOe2FLT1phkAcWNWHcFYUuU6zSwKX/jbE4dcGS5c0R3Wi8VG
yZ5URbCYilvoMZ+Y+LDOdTIttUPEjyzVxnETgxzqiKynQDys21dQdA3J8Gud6RuU
WVcta5Arbo3iHwzBMWiy2oMqSnC1ymbYfqVP7ZM+tltw5kpeaK4gxrhce1H48Xqs
oYKe2rVv8WYlpCaTrveSIZJpMq+X/fXjwSApUXor2kDOKgXhJ5Et5Ymmr9JJsh8q
iu4n4Diyd0P5+EmC0VinkdyxFTcVbA==
=f9Wj
-----END PGP SIGNATURE-----

--3b6i2pmfftpyunpw--

