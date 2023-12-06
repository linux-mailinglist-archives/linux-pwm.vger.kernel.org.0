Return-Path: <linux-pwm+bounces-425-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A128076F2
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 18:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEBE1F2113D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 17:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DB6A32D;
	Wed,  6 Dec 2023 17:49:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58297D4D
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 09:49:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAw0Z-0003ZN-Ul; Wed, 06 Dec 2023 18:48:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAw0V-00E0n0-Jx; Wed, 06 Dec 2023 18:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAw0V-00Fdvj-A8; Wed, 06 Dec 2023 18:48:23 +0100
Date: Wed, 6 Dec 2023 18:48:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	joel@jms.id.au, andrew@aj.id.au, corbet@lwn.net,
	thierry.reding@gmail.com, p.zabel@pengutronix.de,
	naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Subject: Re: [PATCH RESEND v10 0/3] Support pwm/tach driver for aspeed ast26xx
Message-ID: <20231206174823.ok6rrufhez33rte5@pengutronix.de>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xahfw2iectdfzaf3"
Content-Disposition: inline
In-Reply-To: <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--xahfw2iectdfzaf3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:02:43AM -0800, Guenter Roeck wrote:
> On 11/7/23 02:50, Billy Tsai wrote:
> > Unlike the old design that the register setting of the TACH should based
> > on the configure of the PWM. In ast26xx, the dependency between pwm and
> > tach controller is eliminated and becomes a separate hardware block. One
> > is used to provide pwm output and another is used to monitor the freque=
ncy
> > of the input. This driver implements them by exposing two kernel
> > subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
> > existing drivers for controlling elements such as fans (pwm-fan.c),
> > beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driv=
er
> > provides sysfs interfaces for fan.
> >=20
> > Changes since v9:
> > Change the type of fan-driving-mode to string
> > Fix some typos and formatting issues.
> >=20
>=20
> What is the resend about ?

And to the original v10 there is a reply by Krzysztof;
see https://lore.kernel.org/linux-pwm/3d9e50db-19f0-43b3-8042-2f80a1e7b79e@=
linaro.org/ .

I'll mark the original and this resend as "changes-requested" in our
patchwork. Probably the most cooperative way to object is to send a v11
and point out the changes compared to v10.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xahfw2iectdfzaf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVws+YACgkQj4D7WH0S
/k6h9gf/WbDCCPB8gEoBy04/59kS+pKvmePtsjuxxGtkiYQdKXw4e8Q7ceGH7jHL
HcjE2lXZJ+PbjcK9zRbglyTKkbJT0cl4pYDYxaSbb3b87GCmImjsNGPb0pkOb3id
e6JgbB8kWpXtpoDWTSrCUYUiTwmwTpcaLEA8/ybJpnbV4G/+ZquEc+hYl/f4LViz
HhuTGL/AAd3aa6F8g6+3u0NCp9fdJwwYBJw3nyg5UWwF/YzauUoNNHpa/u7Wm5qg
3BIwHt2JcOIrs187TPDHTRsTRoCRNyZv1gifyXDZhIsi48EyYKUuXMdr/IHq8Fuy
GX73E7Tr65j6LyKnQ9p2YwEggAzSVQ==
=3LdD
-----END PGP SIGNATURE-----

--xahfw2iectdfzaf3--

