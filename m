Return-Path: <linux-pwm+bounces-476-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6580B4A6
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 14:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253121C20BE2
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B78114F9F;
	Sat,  9 Dec 2023 13:58:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F1910C4
	for <linux-pwm@vger.kernel.org>; Sat,  9 Dec 2023 05:58:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBxpy-0001ft-6E; Sat, 09 Dec 2023 14:57:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBxpu-00Eecd-U0; Sat, 09 Dec 2023 14:57:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBxpu-00H5EP-JG; Sat, 09 Dec 2023 14:57:42 +0100
Date: Sat, 9 Dec 2023 14:57:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Mark Gross <markgross@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 1/4] pwm: rename pwm_apply_state() to
 pwm_apply_might_sleep()
Message-ID: <20231209135742.3ieusuq3h3xlvjfn@pengutronix.de>
References: <cover.1701248996.git.sean@mess.org>
 <37090c1d8d8f42f1e12fa84942027d995189a99e.1701248996.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6j77aatd2k4sm7sp"
Content-Disposition: inline
In-Reply-To: <37090c1d8d8f42f1e12fa84942027d995189a99e.1701248996.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--6j77aatd2k4sm7sp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 09:13:34AM +0000, Sean Young wrote:
> In order to introduce a pwm api which can be used from atomic context,
> we will need two functions for applying pwm changes:
>=20
> 	int pwm_apply_might_sleep(struct pwm *, struct pwm_state *);
> 	int pwm_apply_atomic(struct pwm *, struct pwm_state *);
>=20
> This commit just deals with renaming pwm_apply_state(), a following
> commit will introduce the pwm_apply_atomic() function.
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Sean Young <sean@mess.org>

Not a in-detail-review, but I just noticed again, that we have

	K:      pwm_(config|apply_state|ops)

in MAINTAINERS. That one needs adaption, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6j77aatd2k4sm7sp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV0clUACgkQj4D7WH0S
/k4sEAgArnTQxpu4ZXIskkdh9oxeabDQRo0TziQM0oZ+wnyobvwrkERaAWwUdg1V
BTu5gKnbpp4QbALgpLCjFiCxxODMDE0zFXfZYpvHhZINc9zUPmHu3VvJmAh36php
d+svsxVry/mTbk8WqHHdXLWRsgfuMTup2IcSecthS4EheqiiIB1/3J6zlV0hBEvt
6MR1GepDyknFpPqf5O01Ya8gFZ2lcjJhXLINaH6vtZe+SF9f2ENGsiwPScjzPhY7
Nkojtd82SQdG1VgWLyGe/JHV9MoZQh60GN3/DIsdSRdcDdAVKOvl9ATY87+CM4Le
/qSreDunw+R0VYm9mVeyI7sETi446w==
=Wzva
-----END PGP SIGNATURE-----

--6j77aatd2k4sm7sp--

