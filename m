Return-Path: <linux-pwm+bounces-7643-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 900F3C6E317
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 12:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADBFB356576
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 11:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD7F3321BC;
	Wed, 19 Nov 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idki2hsL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A3307AF5;
	Wed, 19 Nov 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550773; cv=none; b=hu8tHPx8b4GYxHm69wMfYPJIv3iHO5yNCgyW8IVfp055uuKCQQCHkRutZBorh7CfRlD6yLqzhZd6Tv3rM77m/E4AKMSrR3ICGtSVkPssoS5MRpnJZi4UVeO9cNuJlxrBroU/Ik5RRF9WvLBT1rA76YmR+VovigPPeKjMruQVCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550773; c=relaxed/simple;
	bh=roNhmaJRK24WKiOuRbJbxQl2s7i455LhnirupaR/0Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eRRz9zIt6SRQaJGS8eW/0YXIWwhnqt0Vnx1mLgsuiRKk4tjf7/mvvRbkpivtX0+73/ZxNd6/Zp7fW2tjXfh4zGPmC+eKviwGdMnsxtaFPUea68DDfC4Cf3c72oOQEbDS+N+8DeRqvDpsBoRWGNLuuiA2Ec1Ncb4a3idSopuxD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idki2hsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F65AC19425;
	Wed, 19 Nov 2025 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763550772;
	bh=roNhmaJRK24WKiOuRbJbxQl2s7i455LhnirupaR/0Tg=;
	h=Date:From:To:Cc:Subject:From;
	b=Idki2hsLryMVaMAs78tFmsx/HvXdBQaY4d5ijH8UUjR/kGHnfVFF9VZtz9MROzvRs
	 Nbkoa6iGyjPhjk2i4slJQPMajo/tbtq5/JTpuvCT4DWVHWeK/M32IZndfkh2lblijR
	 +6YflB7zAc2TgWDdJqG1YacwZcmJsDgnT8nqu+WocSeYfjiXdAuKtPBMw2fb0SrPJJ
	 O8ms1qViv2xvGX/lbtYhSpY09aujGMBxOIMuRhT7HSbxM/bwh02YOpd2jx2nx+sOWV
	 p2LlGees0mhXsN65WMMSkNLY1P64l3r3YwOvkxZcehhv4Mv2ea2xoQgzWq+GgE3AZL
	 N1FxtUgOzrXnA==
Date: Wed, 19 Nov 2025 12:12:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luke Wang <ziniu.wang_1@nxp.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Liu Ying <victor.liu@nxp.com>
Subject: [GIT PULL] pwm: adp5585: Correct mismatched pwm chip info
Message-ID: <envt2p43cxalzvnvakjq5m4vjvejkxb3c34rcw2eyicq6ehimf@dfmihw6e7uz2>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvubloj2533shgcf"
Content-Disposition: inline


--lvubloj2533shgcf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] pwm: adp5585: Correct mismatched pwm chip info
MIME-Version: 1.0

Hello Linus,

the following change since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

is available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.18-rc7-fixes

for you to fetch changes up to f84fd5bec502447df145f31734793714690ce27f:

  pwm: adp5585: Correct mismatched pwm chip info (2025-11-14 11:55:56 +0100)

It's a single obvious fix for the pwm-adp5585 driver found end of last
week. The change is included in next since next-20251117 without issues
and merges cleanly into your current master branch.

Please pull this commit for 6.18-rc7.

Thanks
Uwe

----------------------------------------------------------------
pwm: adp5585: Correct mismatched pwm chip info

Luke Wang found a problem in the pwm-adp5585 driver about how register
information is mapped to the different device variants. This effectively
made the driver non-functional. That didn't pop up before because the
driver change was developped as part of a bigger mfd series and the
original author didn't retest PWM functionality after it was tested in
an earlier revision but then reworked.

----------------------------------------------------------------
Luke Wang (1):
      pwm: adp5585: Correct mismatched pwm chip info

 drivers/pwm/pwm-adp5585.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--lvubloj2533shgcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkdpi4ACgkQj4D7WH0S
/k7g/gf+Oci2UOvR/RuPDkoy5n8N1yRgMGBI4OpK+Q8L70UKAAw6PO3h6krRJv6a
GFsQ7Dvm+jJULPoHXOgmQRNSreb1XvbQSgtoUqT6Ts6LlXdU7FoGKOc03jn7K5Ep
oyX4gcujsHhtvzY/nMgHKStTF9Boflm2glwz1h2KcdSwIZouNhen8Dn8wJwMFxVC
pmeEddJzXf02a3xv4kfi+JyGF5ZaRGWQOUrA+AQAsEnm34H92tzUY3gTNc3B/a6U
KLZAbiwzSzEdhr7x5cLoPmon6g1TopsvlhdFiagcRwIUNmYPmfiRmB2xT9giBnBO
UeZNTiizA9YBgZqslPuFKIxZHP05OQ==
=yWr+
-----END PGP SIGNATURE-----

--lvubloj2533shgcf--

