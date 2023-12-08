Return-Path: <linux-pwm+bounces-471-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B7E80ACA0
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 20:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5EF281764
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E847A43;
	Fri,  8 Dec 2023 19:06:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1CE11F
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 11:06:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBgB3-0000wA-G5; Fri, 08 Dec 2023 20:06:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBgB2-00ETfu-Ew; Fri, 08 Dec 2023 20:06:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBgB2-00GYvf-5X; Fri, 08 Dec 2023 20:06:20 +0100
Date: Fri, 8 Dec 2023 20:06:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-pwm@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Simplify using dev_err_probe()
Message-ID: <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bo76icyc46hz2ugk"
Content-Disposition: inline
In-Reply-To: <ZXM72QYBbb32Q_aL@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--bo76icyc46hz2ugk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Dec 08, 2023 at 04:52:57PM +0100, Thierry Reding wrote:
> This is a lot of churn for very little gain.

We seem to have different conceptions of churn. Each hunk here is an
improvement for both SLOC count and usefulness of the generated error
message.

	failed to register somename: -5

is worse than

	error EIO: failed to register somename

, isn't it?

> None of these functions are ever going to return -EPROBE_DEFER. And
> yes, I know that function's doc says that it is "deemed acceptable to
> use" elsewhere. However, the existing error messages are just fine, no
> need to churn just for the sake of it.

We had this disagreement already before. Yes dev_err_probe() is useful
for three reasons and this driver only benefits from two of these.
That's IMHO still one reason more than needed to justify such a change.

And if you think that a function should only be used if all advantages
are useful for the caller, let us reconsider if we really need capture
support in the pwm framework as only two of the 68 drivers make use of
it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bo76icyc46hz2ugk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVzaSsACgkQj4D7WH0S
/k6ozQf/SUXYDUMnY2yOUovZTGROoGOBsfWPHqzKKvQOSdc97mQvafP6W4Mt4/Mn
dao+fXvGBfMJ5JUcMQoiz+J/4VjYF6NXkGN46GEhZrPXwKU0JbFhF0FCWnk/qZel
qL+GQ61NtEW6Oh57Iu9tY9TnJKGMw0tDdCa6DbdKKeQccePVbF3I4yMxN3b60Dbn
Y2iehxV0Goma6DZ26ylIoY8P1PSPJDHlCFZMbvjk4Kv5LPzYAQbXN8JNYxUzL/19
lFTg72YnmMSq76dEVLAGtRcPDuqv0cUtPezqbfMpBfz3LiWhqVkrAMi1r/cEVtTg
BgkXG+mNRWkSGYi8YI8kVGh+9FStbg==
=TWqz
-----END PGP SIGNATURE-----

--bo76icyc46hz2ugk--

