Return-Path: <linux-pwm+bounces-1813-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1033A88BBDF
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Mar 2024 09:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6CE1F3A758
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Mar 2024 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA60F132811;
	Tue, 26 Mar 2024 08:05:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67018C38
	for <linux-pwm@vger.kernel.org>; Tue, 26 Mar 2024 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440329; cv=none; b=fR/js5c2OFhbpRBy6i3DyQOfxn9+PQDiGuijbdvyaq6n9kiAXOvXoYwnGtktzculBlWj6JaoFiUiPDltiGSza0CC5ce4dvdWNXmm9coexuh6a3Gx5NeiQQpi+shucSQmafmLnEYFm++dh9VWqEcp0/2dMN65Q4VZU44gue5NBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440329; c=relaxed/simple;
	bh=W6ykjkToGgPKGyt5QmAKaA8NA5tEEh0OFC/qtrDL9DE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g2dFpiOucGquHSKJmMD8kZN9KXeOgNBDTiIMWlAVJp/ZS2A1t1oZueJ0Vx0Xj95v7XwU5uPbDFOL7eLr4lqs6oQO9b2RncKS02o9zQoNe9IpblStCpRo98UZd4KicvJNs3kPRLCn22xoPzp9Fbuap54N7THPE1L6qVYp2xUa130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rp1o5-00056k-PG; Tue, 26 Mar 2024 09:05:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rp1o4-008ZyV-Ta; Tue, 26 Mar 2024 09:05:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rp1o4-00BbHS-2g;
	Tue, 26 Mar 2024 09:05:16 +0100
Date: Tue, 26 Mar 2024 09:05:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, Zoltan HERPAI <wigyori@uid0.hu>
Subject: [GIT PULL] pwm: A fix for v6.9-rc2
Message-ID: <unlcfjofn5lsga7ttr6egp6wjvsinwysi7lklc646ixap4oumx@uymlfmdyy6jf>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rtzrjzz4jp2s5v2"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--6rtzrjzz4jp2s5v2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following change since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

is available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.9-rc2-fixes

for you to fetch up to 9eb05877dbee03064d3d3483cd6702f610d5a358:

  pwm: img: fix pwm clock lookup (2024-03-25 07:31:26 +0100)

=2E This patch was in next since next-20240321 as
58d03770ac5f78ff2d819caabea9371a041bf7be. I rebased it for this PR on
top of v6.9-rc1 to prevent a backmerge in the next development cycle.

Thanks
Uwe

----------------------------------------------------------------
pwm: A fix targeting v6.9-rc2

This contains a single fix for a regression introduced in v5.18-rc1
which made the img pwm driver fail to bind.

----------------------------------------------------------------
Zoltan HERPAI (1):
      pwm: img: fix pwm clock lookup

 drivers/pwm/pwm-img.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6rtzrjzz4jp2s5v2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYCgbUACgkQj4D7WH0S
/k4sGQf/VevAjXZ5DVBN7U0699/gYhBuEKQwmJLpP5lVALgaybmwlNpylKjOjaoL
iRisIGeBPgYtalJGewBrU8vVx+mxOWyIo4Y+pNSD2mlEuEoS2pImnkBM5MVpu7rp
qRK4YtdY5SwvRJaShwzNUcTwXHQKY4EGBYyk/ZEevdT1CFo2OnBfOc38T21/Yugb
ewY1/CM1fpH+gXtdMwoKjGsInm2jjZvSjOyisgJxayg4KGqP5ebDAbiZEMW7ZOXM
Di0YFFoCROdvM3N6G5vOWIhrcp5/OEIWE92boiqNsCfl0c9p7kOfJM7IXIUw/hFL
LU/VY5MFW/pxuEqgyu1or8pEysaLTA==
=dkXt
-----END PGP SIGNATURE-----

--6rtzrjzz4jp2s5v2--

