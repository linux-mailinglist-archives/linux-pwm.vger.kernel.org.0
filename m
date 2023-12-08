Return-Path: <linux-pwm+bounces-457-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67B80A50A
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 15:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F73281BC5
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026AE1DA20;
	Fri,  8 Dec 2023 14:03:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A87A9
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 06:02:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBbRR-0006od-Hd; Fri, 08 Dec 2023 15:02:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBbRQ-00ERCt-KT; Fri, 08 Dec 2023 15:02:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBbRQ-00GRRD-B9; Fri, 08 Dec 2023 15:02:56 +0100
Date: Fri, 8 Dec 2023 15:02:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de
Subject: [GIT PULL] pwm fixes for 6.7-rc5
Message-ID: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yz3s5ppew7lqb23h"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--yz3s5ppew7lqb23h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following change since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

is available in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux tags/pwm/for-6.7-rc5-fixes

for you to fetch as commit 4e7a8dbd2bc0aec4605a5069df7a779bd9e64db1:

  pwm: bcm2835: Fix NPD in suspend/resume (2023-11-21 11:09:32 +0100)

Please pull this as a fix for the next -rc release.

Best regards
Uwe

----------------------------------------------------------------

pwm fixes for v6.7-rc5

This fixes a null pointer exception in the bcm2835 pwm driver. The
problem was introduced by a combination of two commits merged for
v6.7-rc1 where each change alone would have been fine.

Thanks to Florian Fainelli for noticing and fixing the issue.

----------------------------------------------------------------
Florian Fainelli (1):
      pwm: bcm2835: Fix NPD in suspend/resume

 drivers/pwm/pwm-bcm2835.c | 2 ++
 1 file changed, 2 insertions(+)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yz3s5ppew7lqb23h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVzIgwACgkQj4D7WH0S
/k6KiAgAj5CA9osu5uiuKlf2D3nF3icznjYKC3QeM7/BoJm+u5zwrAVKGfgIQ1i2
ezUH0dWN8CNLDaA6BQWt5jVIvE11C9BmbuNC1x9Arh4EKGWVftSRNRWAFcPWD11c
wyiaSnj7oG+Yhh5iLGJN95X0c7DWTireeDuU1aeq/HUxz6PZ7uQnoIv/Hi69xtjD
jAzR6mwyQcx9/ImuLxP6eYzCJ3zGd5kLow7U50L31/KTlp7MD4ewNq09o0x2YdVi
WzLZRTt369eHx9cYv8Mjeq3iLnfMyVGK1r/kkMsbgAosKoM/+A/oAlSpVIJfuYTq
3gnAPIkVwSSLbxPlqjBa74/Tc6LGqQ==
=v/16
-----END PGP SIGNATURE-----

--yz3s5ppew7lqb23h--

