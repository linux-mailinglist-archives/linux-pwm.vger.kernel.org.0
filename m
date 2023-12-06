Return-Path: <linux-pwm+bounces-426-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4CB8076FB
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 18:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8BC1F21150
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9896849F82;
	Wed,  6 Dec 2023 17:51:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD3122
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 09:51:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAw3V-00047H-4D; Wed, 06 Dec 2023 18:51:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAw3U-00E0nE-O3; Wed, 06 Dec 2023 18:51:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAw3U-00Fdz2-Ez; Wed, 06 Dec 2023 18:51:28 +0100
Date: Wed, 6 Dec 2023 18:51:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/3] pwm: Reorganize PWM identification
Message-ID: <20231206175128.37hdvhamgo3kzu26@pengutronix.de>
References: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
 <170119076358.215216.6044730842132263589.b4-ty@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhguk4vpyxiriyeg"
Content-Disposition: inline
In-Reply-To: <170119076358.215216.6044730842132263589.b4-ty@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--xhguk4vpyxiriyeg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, Nov 28, 2023 at 05:59:56PM +0100, Thierry Reding wrote:
> On Tue, 14 Nov 2023 12:20:10 +0100, Uwe Kleine-K=F6nig wrote:
> > all these patches were already sent before. The first in
> > https://lore.kernel.org/linux-pwm/20230728145824.616687-4-u.kleine-koen=
ig@pengutronix.de
> > and the second and third in
> > https://lore.kernel.org/linux-pwm/20230808165250.942396-1-u.kleine-koen=
ig@pengutronix.de.
> > The patches were last in their respective series as they had some
> > preconditions. These are all included in v6.7-rc1. Also conceptually the
> > patches belong together, so I created a single series from it.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/3] pwm: Drop unused member "pwm" from struct pwm_device
>       commit: 2fddc79446c5009dca3c29d6e784e2d05dea78f9
> [2/3] pwm: Replace PWM chip unique base by unique ID
>       commit: c572f3b9c8b7eb582b0ce4e2f67535ad76819361
> [3/3] pwm: Mention PWM chip ID in /sys/kernel/debug/pwm
>       commit: b7614b748bb35acad55050e5a91ba6284870f62f

IIRC there is an automatism that should mark applied patches accordingly
in patchwork. Didn't work here. I marked them manually now as accepted.
Is there something to repair?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xhguk4vpyxiriyeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVwtJ8ACgkQj4D7WH0S
/k4T0Af9Fkpbjx7ZLt8OCOu/ULYSWXrnVrczLWPaszTSnKX8BovL6wjXJsDl3k5y
TdVIkxNmRwaQgRWo9d17Ru7TLhqeBOAA84ggu30WoryAB9NO0MZjZHtgv8J/JFKm
O6tVqBJFJpIU2A2GQ0FSL9xdoB8lpSSoClrlMbz/mDLoDMV33oOVQn9z3gn1Q8O8
6LRHoOX7gb+yxLW5dJUHFnGuAWQamc6qMxv297vNxwoz46FZ4e3kdx5wRg73TjLu
TjiVNFOPAOkWMmdQ1ALeeZFmefOvNKO0CX07HdJhE5PJNCXyU25nvp1CKmH9J4OC
6tOPHv0sle6Lc2TbTowYYCZIKMDKRw==
=sbh0
-----END PGP SIGNATURE-----

--xhguk4vpyxiriyeg--

