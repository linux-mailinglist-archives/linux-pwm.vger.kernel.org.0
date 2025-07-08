Return-Path: <linux-pwm+bounces-6793-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C82AFD7CD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88ECF189211E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428F224D7;
	Tue,  8 Jul 2025 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bTj2SvnN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C51F790F
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004984; cv=none; b=fIK6swKc0yp8Z+0qIpJNbzhchox5a4ggiOqsUNI4VFipQ8o1mfOi0op6WPj60JLvl6Z9yvvjvvQfF2R9ZPwLV2dWk4/Yk5Gv7gxnjiuBFWTJF+RjIRdVs5GEBvVsu8ZrHmeWahf+SaUqh6K806ifhJbfUhZ7J0gznZHuqeyzNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004984; c=relaxed/simple;
	bh=sA/jaDLBo2ZwEpYJGBNbz/7FtbueXEy3qPmalo9X7l4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=shCgy7x6hEzUk8ocXBjvUDVOSwf8FLV4hA97saRD+Si4hHD28fFQNdvVLRhMnlbGxKWGZXcdnZ9rKDPbVl2NOLq92fODU2hxorizWVGJv3XyVXGfxPqfVLm2MZfR1woheA6M+cPIypJOu9Ww5SGkdKylJ2ZZ11gPprt/pkpio4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bTj2SvnN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so576373a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752004979; x=1752609779; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELjj0ryeHIzjT3mg2Wy0Eh54m3MZQXeSwE4UOruIu7k=;
        b=bTj2SvnNQg/iju5ygPd39ygEeBZOaTk2XbGafQWSYH24mB3p0GdAsQOyUI/X0STE2v
         eDYMmnNMgxs6XANHVVmuHVJu+b6apuq+63d4uxXSKO7IAHuj7WMd3kIvmYTySzFinD9/
         3qFUOMifLORO1Wm6kftlcTx8UX+PMipYtvFngAeEdjD6vOve9qp6tAshd3Pbb4eRKcUN
         892cC5C3jTK9lSqox7MU/gpJK4MTE6jwT8cDf1DWYmIL1LRXOR2c9z/4d/F/eCCWxIlW
         uGXQEBk8PSm8+kXMhJEde2oxBfwX4oCDV2iZMjoH8gXtHyQW7aoHF57pg5eVmPF1bQWo
         mAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752004979; x=1752609779;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELjj0ryeHIzjT3mg2Wy0Eh54m3MZQXeSwE4UOruIu7k=;
        b=ICCDjadp1eYU4cRx3cJZfywv0+RNGLc0SiQCFFhoQhQZi0sv2AM9WdKmJ1uQUuhSSS
         sGrEYtI2gtpSKF05l06e56tC8s2plXUeViCR98KZ85eYSWgVcVu+V9PVpmDvR3M2ku6Z
         pBZWrBtNxdtOEQcBfMFL4TnRTsJNiASb2aFqShhCDvUMq3wcxtWE85Pp64NU5EQVrIlQ
         GNn0h857rK4rL7bE+sWBOxaY4W06xFw4RfiXg8EDoTGzjTNb+5Sv2hnD5mFI0ivkTID2
         wMngykAXaEY5H87aAZ9tfhUHjV3dBtICL/wyaXUpiVeYQajy0t7H5tRYXBDzWjiaP5aY
         GuMw==
X-Gm-Message-State: AOJu0YzTkitsZH982TLPVPoYuuw2ZhyHGBlRh3h+jTeWrRQ2ccQ9Cx74
	OQ7d4/9JxBknZqv14Qk9sIyp8+ia0C9pgcbUqcsVrCwmZqai8z/P9os9l6voxCS+qFI=
X-Gm-Gg: ASbGncvlW7eBYCe1J0l7Sh9/F1MkLc2mmUbH92EDa40+ZRyc/FaMZTJHHRJyAVHqd7z
	mFRvbnLlMK+pP45YHNRfuRXXiGFRdaW+ya7iY3IV2Htme6WEtu/v/qb7nUdmwB+ttUawe0np8eg
	kPWnwisRQRsWHENumohx16r0q9O6Hy7+zX53sSzrCocG2I6ux6cuUCkJnBcY5UT0C8LQSow5Bfr
	JRFJY3KshaaA7w27H44Pa4LmlUt5d5f0TIjBAjgPKjZgB9i4m1LW5MK9f2c08ZWlvslLgMdWAN5
	1F1A3sgv34iogGa/bH/V8C+zrlbzT7HKg3rMrAT/m8zppsmokrZ2fbZ2vWdvXG8oAZM=
X-Google-Smtp-Source: AGHT+IG4zv8db/vyk2Q6Pfv42xbp88H6t/OTuVefTDzdjvsa/5RakHVr3peMqqQub2f6GfKlFMUyfg==
X-Received: by 2002:a17:907:6d28:b0:ad5:9ff3:c6ce with SMTP id a640c23a62f3a-ae6b2366e9fmr423181466b.4.1752004979310;
        Tue, 08 Jul 2025 13:02:59 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f66e7d4asm933074466b.23.2025.07.08.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:02:58 -0700 (PDT)
Date: Tue, 8 Jul 2025 22:02:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Fixes for 6.16-rc6
Message-ID: <fmymgdr7p3ergu7i4u2n7mwwkjakhs3krq4btywcepbgt2266x@swjnq4cy7s2c>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gunn7eaf2v4jhu2i"
Content-Disposition: inline


--gunn7eaf2v4jhu2i
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Fixes for 6.16-rc6
MIME-Version: 1.0

Hello Linus,

the following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.16-rc6-fixes

for you to fetch changes up to 505b730ede7f5c4083ff212aa955155b5b92e574:

  pwm: mediatek: Ensure to disable clocks in error path (2025-07-07 08:34:4=
4 +0200)

----------------------------------------------------------------
pwm: Two fixes for v6.16-rc6

The first patch fixes an embarrassing bug in the pwm core. I really
wonder this wasn't found earlier since it's introduction in v6.11-rc1 as
it greatly disturbs driving a PWM via sysfs.

The second and last patch fixes a clock balance issue in an error path
of the Mediatek PWM driver.

----------------------------------------------------------------

I would have preferred to have these changes a tad longer in next, but
the fix for the core was only found on Friday and since then there was
only a single next tree. Given that we're already after -rc5 I don't
want to wait longer to get this fix in. The driver fix is harmless
compared to that. But it's simple and obviously correct, so I sent it
along.

Thanks for pulling these two changes into your tree for v6.16-rc6,
Uwe

Uwe Kleine-K=F6nig (2):
      pwm: Fix invalid state detection
      pwm: mediatek: Ensure to disable clocks in error path

 drivers/pwm/core.c         |  2 +-
 drivers/pwm/pwm-mediatek.c | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

--gunn7eaf2v4jhu2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhteWwACgkQj4D7WH0S
/k5HTwf+PROKm8ZuZn5DEmnZnm2rKVZc38KoP6FUSMI7YhJbmc4kAThU66w/0B3g
06eEMjZgiRl+OijUKPtAPzECCbALGLp4Z2PRePdlML5ggjBX3PnJrSBr8j95oQtZ
671JMJpMEh/hMfrJV4RX4KJeP9QLXibp3XQztQPRpRbu2I54Lr64MV+VvLxP0/mQ
C+HAD89ct5DNdwVxuaX4Yb6qXo5if9wUBaL7T/zcjQvy3p2/2NdSESdv6frnYpXo
pQOTckJ1/r0HEYUkbxF5q+RduH3dExEEPvFdubbcKxcJrqJuipxJ1oHizhgNbu6V
mN0Lpd9DpwZDuIN+Fj9RCkRndHs7mA==
=gA5l
-----END PGP SIGNATURE-----

--gunn7eaf2v4jhu2i--

