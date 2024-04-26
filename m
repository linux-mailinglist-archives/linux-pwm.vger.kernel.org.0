Return-Path: <linux-pwm+bounces-2117-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCF68B3073
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Apr 2024 08:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFC71C219F4
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Apr 2024 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8426AC5;
	Fri, 26 Apr 2024 06:31:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3A631
	for <linux-pwm@vger.kernel.org>; Fri, 26 Apr 2024 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113116; cv=none; b=ae93wYk6wohGGVTL4XOrPY4vtvd7Cn3TgUnnV77e0ZFnFhtlChq9cOFWF1dYJClhD8xednkJGEnrv/D9lCIWooqmKfCmEkKYD5CTln8b3u8himmX9CDswiNuFWLo3qVNKvTtsf1hYunRBBWq+KdwkK5CfqVEU9ETNpupzxv4Yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113116; c=relaxed/simple;
	bh=su+atXghKMgF4V7XqaGPcM0Vgqr72C0JOQgjOLMUQGI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FUGTs2gdDg4Xjd+QiFR+eTIpjuTM+EdnNuDmb2Jqu0PZbjHkHi0NQWcC1mPb1z9SbktJZE6VSBJANif8d5maVg7IKBkbdP0LuZ8tFlFU7c+9F69QCIWq0YioTdjoZrR+vWeLbZtFV4AhAYRi8F4VxsheMgoxK0gOeeWMoujfaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0F7g-0007Zw-PD; Fri, 26 Apr 2024 08:31:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0F7g-00EOfZ-67; Fri, 26 Apr 2024 08:31:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0F7g-0097iY-0M;
	Fri, 26 Apr 2024 08:31:52 +0200
Date: Fri, 26 Apr 2024 08:31:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de, 
	Thorsten Scherer <t.scherer@eckelmann.de>
Subject: [GIT PULL] pwm: Update Uwe's maintainer entries
Message-ID: <wkokeh5mkc3d3j5d3aumdj3g4fzk5znbye2prdroqgwlhzledw@eskutdgi72nv>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ckzhtjp5cdktz4t3"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ckzhtjp5cdktz4t3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.9-rc6-fixes

for you to fetch changes up to 190f1f46ede17ca0d7153ac115d6518ec1be2ba3:

  MAINTAINERS: Update Uwe's email address, drop SIOX maintenance (2024-04-2=
6 08:20:14 +0200)

This is just an update to my contact email address as my Pengutronix
address will stop working soon. I also drop my co-maintenance for SIOX,
but that continues to be in good hands.

Please pull this for v6.9-rc6.

Thanks and best regards
Uwe

----------------------------------------------------------------
pwm: Update Uwe's maintainer entries

This is just an update to my maintainer entries as I will switch jobs
soon. Getting a contact email address into the MAINTAINERS file that
will work also after my switch will hopefully reduce people mailing to
the then non-existing address.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (1):
      MAINTAINERS: Update Uwe's email address, drop SIOX maintenance

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ckzhtjp5cdktz4t3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYrSlcACgkQj4D7WH0S
/k4qPgf+OCSN5jFjGB6BE48wQDFcBuUrGk8zfgGTkL8E7kFNwwVFRs7nmPhwvXbD
69ouFq5WsqGeTjhg2PmjbsJTN+RDXF1KzjRtvcH3gO9ao4PdrO13IAI75E16A/bv
JqyJOMzndnmTQt4twwFa/VjWzuCn3HEW/lxIEDnDrYJBAkbzZM60Yo0zX6z8ftNM
FnpRwDa4ECEnJ9Zyx/XkGmvjinCHZH4ByFBSiPmtPBIekxTHQ0PJ+HJiApQorFOd
7QMt8BIt3pmDm85a8EwE7N6GEBZgjvMm/+1yZjK350ywIQtOSaWIo4MSsg2povwL
Nfe6wKeiN7OPLG69kn1B95qpbiQY9w==
=1Lq6
-----END PGP SIGNATURE-----

--ckzhtjp5cdktz4t3--

