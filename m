Return-Path: <linux-pwm+bounces-1995-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800A28A886A
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 18:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05941C20A3A
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C31482E8;
	Wed, 17 Apr 2024 16:04:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB2142625
	for <linux-pwm@vger.kernel.org>; Wed, 17 Apr 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369841; cv=none; b=DwIBL5g7PXFzC+2LC13QUDkq0RrGG4VEu/gCXgXl/f4eewZJD/dZBMqioxW3dKgoslhZmnGATOWgz0rEsEHNKl3mqLahZLuN9XiKbtZvom55qzv9/iIZfjSjQ0Rza806mF+adZac8F1O8JSnPqazWbppqanmHCvB1Bxy8HXl5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369841; c=relaxed/simple;
	bh=+/mPNvIok4Lc5yTIsRAECapZLO0suW+pmNir9WbsfG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fNY8kVPMwmq6Iw1KmDP+VKg4rpSGhDrXIKwm/32Wxw31RRxiACQaIFjdufLTakQ33FUJu5e/EGhg1qKYh5bjBiOh9OgaxXygAk6yd8ZSeiT8v72kU2+W4hPNLI0Ob5/h7yWKfZ2nBxx2/ImLh4wcQZsAxAtnIs3bmIEwM0QbhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx7lM-0002Nh-RU; Wed, 17 Apr 2024 18:03:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx7lL-00Cp4U-Bw; Wed, 17 Apr 2024 18:03:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx7lL-002vk0-0u;
	Wed, 17 Apr 2024 18:03:55 +0200
Date: Wed, 17 Apr 2024 18:03:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Raag Jadav <raag.jadav@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL] pwm: Another batch of fixes targeting v6.9-rc5
Message-ID: <qcicxm224x2fw43wrgz5tmntkpiq5v2dro4lynrhomh7sfhtvp@6hh67yqpm423>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5j7ofikdvpkxvgi3"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--5j7ofikdvpkxvgi3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The following changes since commit 73dfe970c038d0548beccc5bfb2707e1d543b01f:

  pwm: Fix setting period with #pwm-cells =3D <1> and of_pwm_single_xlate()=
 (2024-03-29 13:50:10 +0100)

(that you pulled for v6.9-rc3) are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.9-rc5-fixes

for you to fetch changes up to fb7c3d8ba039df877886fd457538d8b24ca9c84b:

  dt-bindings: pwm: mediatek,pwm-disp: Document power-domains property (202=
4-04-15 17:28:13 +0200)

Both were in next since yesterday. The second patch was already included
since next-20240409 as 117c05cf63cd2bbbea0cd4ce3a5d20aeff5d3efc. (I
rebased the latter to have the more critical fix below it, because I
initially wasn't sure if I should send the dt binding fix, too.)

Please pull this for v6.9-rc5.

Thanks and best regards from Germany,
Uwe

----------------------------------------------------------------
pwm: Another batch of fixes targeting v6.9-rc5

The first patch fixes a regression in the suspend/resume path for the
dwc pwm driver that was introduced in v6.9-rc1 when support for 16
channel devices was added.

The second patch fixes a bunch of device tree binding check warnings.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      dt-bindings: pwm: mediatek,pwm-disp: Document power-domains property

Raag Jadav (1):
      pwm: dwc: allow suspend/resume for 16 channels

 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |  3 +
 drivers/pwm/pwm-dwc-core.c                         |  1 -
 drivers/pwm/pwm-dwc.c                              | 82 ++++++++++++++----=
----
 drivers/pwm/pwm-dwc.h                              |  6 ++
 4 files changed, 63 insertions(+), 29 deletions(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5j7ofikdvpkxvgi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYf8ucACgkQj4D7WH0S
/k7mVAf/QxHfMNp26me2d1YNkBo3Y7ss5+fHa172QuEl+VgNd+9GHDWYJr8brFrn
MqTW3i2B1bT0xnHH7kfxa3g0xsbJaROLRqy+Rbu/Cm2X/PpKwvXV1609eS/Gjo8Z
LWgI4HZl+Oka+At2Z1n7owkhD1BJr5HCfl/3zhh2Q7QDpa7xV5HTPHGYfpypRiIk
0vHoUNF6VILN6DaQYAuwmXkD1tuZDC6cjnIsBIBR5AWnk9zAHg8tk5lF4cz6O9Yd
DmCByqDaD2+fz+ZC4PD3PrRCKRAMzkAAR72t4ZhdOCbn6LbeFaOonfh7B+6pNPj9
29naD6nuJeE9dNAUdrZnKTrN4qM02Q==
=6usQ
-----END PGP SIGNATURE-----

--5j7ofikdvpkxvgi3--

