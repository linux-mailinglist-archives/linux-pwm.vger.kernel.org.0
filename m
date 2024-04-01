Return-Path: <linux-pwm+bounces-1839-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B2893894
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Apr 2024 09:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B76281A76
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Apr 2024 07:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0C3946C;
	Mon,  1 Apr 2024 07:09:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF655CA73
	for <linux-pwm@vger.kernel.org>; Mon,  1 Apr 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711955368; cv=none; b=MpCR4zKb57qyEW8c1vt78LrAkE6MMcT/wBFCA49N1UwCt+HSxVEv74AXOGTj58fthdrl2DWlqtLXIAOwXtdTtRi5dSLRcUYyKM2sR/D0+6wIsyw5T1BIcvZ6Qanndwir04i6Asmtuf9Od9bINIcyAbUP8yn4RJL9KfLN4McZ0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711955368; c=relaxed/simple;
	bh=tLrzw1qbwUo9fjZdtE/jidZK8xe86yeQauW2sJ3gpRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q4w8OyUnRj2pm23QK6XPzBEz8z6lJyGQnowAqS74OXIu4soJ6KFkW100Q9dcKTHSt0vmd6czPtsjD0ZF96saHaWAWh3hkATcyN/lr0iS66Wy4qBt+5JjjnkqwnbUyyGpvnJ5iWbYRZob62/viAh0sNqdnQBioFm0DEkbEmROVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrBnH-000754-Oa; Mon, 01 Apr 2024 09:09:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrBnG-009kSG-Vi; Mon, 01 Apr 2024 09:09:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrBnG-00DxTT-2u;
	Mon, 01 Apr 2024 09:09:22 +0200
Date: Mon, 1 Apr 2024 09:09:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de, 
	Karel Balej <balejk@matfyz.cz>
Subject: [GIT PULL] pwm: A fix for v6.9-rc3
Message-ID: <sflouhdi5i4ekqxhpi4z5vriwnwxd6jobrwazhlpg77avn22qz@2f54bed3yu6v>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2b42trqtlzied2wd"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--2b42trqtlzied2wd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The following changes since commit 9eb05877dbee03064d3d3483cd6702f610d5a358:

  pwm: img: fix pwm clock lookup (2024-03-25 07:31:26 +0100)

(that you pulled for v6.9-rc2) are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.9-rc3-fixes

for you to fetch changes up to 73dfe970c038d0548beccc5bfb2707e1d543b01f:

  pwm: Fix setting period with #pwm-cells =3D <1> and of_pwm_single_xlate()=
 (2024-03-29 13:50:10 +0100)

Please pull this for v6.9-rc3.

Thanks
Uwe

----------------------------------------------------------------
pwm: A fix targeting v6.9-rc3

This fixes a regression intoduced by an off-by-one in v6.9-rc1 making
the pwm-pxa and the pwm driver in ti-sn65dsi86 unusable for most
consumer drivers because the default period wasn't set.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (1):
      pwm: Fix setting period with #pwm-cells =3D <1> and of_pwm_single_xla=
te()

 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2b42trqtlzied2wd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYKXaEACgkQj4D7WH0S
/k6OJwf9HyBN5eu+n3h1zYFw9kk2LOL+4eVBOndlKKn0JPKQ+MmhzYOJV1+0HXsT
+I5pcBhE7MwD/HeEv6/ParMdim871L5I/opi2Xep1Htnyb3tUnJVFI5CMcrXncZM
op3wBLN3RFTe9uBvEpYR+VFSzQVdGfz+kTq/tLZDr+GiQYKPkxkZksQ233OpMhgu
AcxQnEfSriIg5153cAKCvSw+fU470VR3RFms3nGx4A8MKBEPJDJ5StbqtOuk7Wka
0NX4up1MHJlYJftfRMIwlSkwbo6RQLqjkQpwRldo/tk9GikCqBW7R3n8M4BkEDaV
DX3eUKvbWo1OgcR/st/qV2z/UEIDnQ==
=1+jt
-----END PGP SIGNATURE-----

--2b42trqtlzied2wd--

