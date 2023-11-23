Return-Path: <linux-pwm+bounces-169-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC47F5CBB
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 11:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433382818EB
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCB1C687;
	Thu, 23 Nov 2023 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332FFD48
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 02:45:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r67Ce-000478-G7; Thu, 23 Nov 2023 11:45:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r67Cc-00B1Ex-M3; Thu, 23 Nov 2023 11:44:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r67Cc-006Zfm-CM; Thu, 23 Nov 2023 11:44:58 +0100
Date: Thu, 23 Nov 2023 11:44:58 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>, linux-pwm@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	kernel@pengutronix.de,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231123104458.2pfaowqylmpnynhx@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231122115621.GK173820@google.com>
 <ZV43NHr1QN79lsaJ@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovysyocw44w2svsh"
Content-Disposition: inline
In-Reply-To: <ZV43NHr1QN79lsaJ@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ovysyocw44w2svsh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

[adding Bartosz to Cc]

On Wed, Nov 22, 2023 at 06:15:32PM +0100, Thierry Reding wrote:
> On Wed, Nov 22, 2023 at 11:56:21AM +0000, Lee Jones wrote:
> > On Tue, 21 Nov 2023, Uwe Kleine-K=F6nig wrote:
> > > +	*(struct lpg **)pwmchip_priv(chip) =3D lpg;
> >=20
> > This is vile!
>=20
> Indeed. This highlights one of the weaker parts of this whole design and
> I really don't like it. The whole chip_alloc() construct works fine if
> you have everything isolated nicely in a single driver and subsystem
> (like you usually have in network land), but for cases like this where
> things are spread throughout and a device is actually more than just a
> PWM controller, it looks like we now have to work around this design
> because it doesn't fit.

With the patch I suggested in reply to Lee's mail this is IMHO much
nicer and with that squashed into the patch under discussion I'd not
call this a work around.

Note that the thing you consider ugly here (I think) is that for
handling a combined "PWM + something else" device a separate allocation
is needed for stuff that embedded a struct pwm_chip before. With
Bartosz's approach you have that second allocation for all PWM devices
---and so the downsides hurt all PWM implementations and not only those
combined devices.

Also note that among the four external PWM drivers (i.e.

	drivers/staging/greybus/pwm.c
	drivers/leds/rgb/leds-qcom-lpg.c
	drivers/gpu/drm/bridge/ti-sn65dsi86.c
	drivers/gpio/gpio-mvebu.c

) only two suffer from this complication, because the other two use a
pwm specific private data structure already which seems natural to me.

> In fact, this reminds me about the "midlayer mistake" in many ways and
> combined with what Bartosz said, I'm not sure this is going to hold up
> very well the more special cases we get.

Where do you see a midlayer and how would that be better with what
Bartosz suggests?

The relevant difference between my approach and Bartosz's is that I put
the driver specific private data in the same allocation as the struct
pwm_chip and thus reducing the number of allocations and pointer
traversals. This difference IMHO doesn't qualify my approach as a
midlayer without Bartosz's qualifying, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ovysyocw44w2svsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVfLSkACgkQj4D7WH0S
/k5CNQf6Aw84GGRpZOW748iqW1Rde6VK/ve5cBswUtt0282MqNQlGsopWDgO4GHq
KK8kPmyBn9tNFsj9vEqtUswgfG6iGBbjQnJNm8S4h4JQVUVYzFGWTQkvdxQ0I7az
bi03l3dv6SntzYT0DC3B5Lwci0eKx6WexEfYN3OM2cF3/dyF0y9MhJZnPndtPNsC
VRMyzetAAUq3TtTUaBaxfJSqES/5f2uXnqV/iUvaseZ36iN2DyAwlQgYpYkyGLUx
SlX85p1xMLQcC2yhF7T99SlLbTaQigofKArEYxfb9w7CiLjGzxASOv3G2Tmzl6MF
j0j8vkLH5eq7y/HOwqgktIHFu4WTqA==
=41d4
-----END PGP SIGNATURE-----

--ovysyocw44w2svsh--

