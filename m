Return-Path: <linux-pwm+bounces-2587-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1E913482
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2024 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F111C20D80
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2024 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E171E4A2;
	Sat, 22 Jun 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="seUktwhZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC21E4AB
	for <linux-pwm@vger.kernel.org>; Sat, 22 Jun 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719067710; cv=none; b=lyc2ep2llelsTS3faUs7gKubCVTszz4PbOuAQm9WqNg+ljMOx4qSZr63rYsnHZ2G7d47yVjlHg75eDi9qGLE5sptZD1HrJ3IN/SsD5p5rkRV6PYEBhb5iOT4SC7vONcOcVGlpguEhnWMc+grdLjm2xr4BXy1WKJrNoGQKIoQIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719067710; c=relaxed/simple;
	bh=HtAjVipTpv+/eM7reTguHc/2EGjuecYatomJ4LCDfzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I3sfhvy217blYdzmCtVGL0ZWB5kThJ3ivj5ibrWeiFoZA2Sczi1N9wCESQgDp/d8OJgoRmgA1shmjmVw0jSek67VSlLj5mK5nrTzwXfJfqjSXB+Dgy736F2FNLV4LPN8fYRupQUW8nsgzaJnAmmXyH+s13ZWPR4ImU8TfJJ6ihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=seUktwhZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so40495261fa.2
        for <linux-pwm@vger.kernel.org>; Sat, 22 Jun 2024 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719067705; x=1719672505; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfKYczkJc+XfRv/+SUvwl1Sy4Rv/ard8tqgfoUeUK04=;
        b=seUktwhZm+DtVsRnUBn8Yw3UmiF6a5CCW71zBzg47r9A3LV8ErlvmzDrezg0lGkJTR
         T/wGujSOraqdfJiCw0sptMDwssNXxn9p7j8eFdm0E08NW/BAHS6crebEUspatDFfcWe/
         nXEERT6+oKa8/nDCw/lVaLG6Tn3y+CntmO36xYWAL9ucH6USmHNM8fIpVZy7OIAmrSNa
         1PYOXWRkCaeWTUL7/y8fpgyaiEGkM1EBy3tCcNvA6gN+dTI61c7q8gk6zUetqhlADu9P
         jFxvTLGhPe2M0beNi7gZWJjR4L9Bs+ERl4CVFMbROSncEljt2IOfl40OiMieKPLIEUGw
         DAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719067705; x=1719672505;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfKYczkJc+XfRv/+SUvwl1Sy4Rv/ard8tqgfoUeUK04=;
        b=JzBmH3Yu4l3s9oxLcZVEqCik6NyJRqls0u6epblY/uscG8BQv7KD2WpIpC3sa02C4U
         aWLa/izLUQXVfN1XAqPKTGBoI7XjD5IUU+LgyX4XI+Yp5FLvh8e8bJEouKMtna/gdJsE
         CPXpsp2TThOluuXu1AoCNNKdNACZgZ+twDqTdZ2f6Bje34ekABaxCRoC2Mb8W5mCKduu
         /zYeOlIRIVDHBoD4ApUPntgn0uxTl3gmc34VDk9X7LGhEMwOjs/i7PlhHIeHsJ+M1ZQr
         nllnC232Ze4VmDERPT1s8mLcDZbOOMNka+TC9wgzjMhQvNrRwZEAdNTz5C9GW/O+S+7j
         88Sg==
X-Gm-Message-State: AOJu0YwZ9737Ho4xFlX1SZZ6txJDokMYh7ccqSB39rI8kM7agltPiPFH
	q2+si02dvlDtXGVozR9zQUeO6ff6D6ezZ4mmRsONeXfZ4yHmxRSyhFVdRyaGiyrkb0N0pgAcY73
	MVRA=
X-Google-Smtp-Source: AGHT+IEm6whQQwjbp6HC611VcM3GbWH1hTlxCTYy8luCAlDIHrmY0o4ft6Uh9IC6PUFeA98C1HNQ2A==
X-Received: by 2002:a2e:a17a:0:b0:2ec:4093:ec7 with SMTP id 38308e7fff4ca-2ec5b2e7238mr651171fa.30.1719067704283;
        Sat, 22 Jun 2024 07:48:24 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7169b12999sm56537966b.95.2024.06.22.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 07:48:23 -0700 (PDT)
Date: Sat, 22 Jun 2024 16:48:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: [GIT PULL] pwm: Three fixes for the pwm-stm32 driver (take 2)
Message-ID: <kgjqqj4lw7tc5cnafhjttozhiukrm7hgsb2veutlrhxgfmap57@dxeuw37qo6sg>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4qkuoqnxltzrtyd6"
Content-Disposition: inline


--4qkuoqnxltzrtyd6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.10-rc5-fixes-take2

for you to fetch changes up to f01af3022d4a46362c5dda3d35dea939f3246d10:

  pwm: stm32: Fix error message to not describe the previous error path (20=
24-06-22 16:13:19 +0200)

I already sent a PR for a very similar patch set yesterday. The only
difference compared to that is that now the 2nd patch fixes a corner
case that I missed. I spare you the details.

Please pull for 6.10-rc5.

Thanks
Uwe

----------------------------------------------------------------
pwm: Three fixes for the pwm-stm32 driver

The first patch prevents an integer wrap-around for small periods. In
the second patch the calculation of the prescaler is fixed which
resulted in values for the ARR register that don't fit into the
corresponding register bit field. The last commit improves an error
message that was wrongly copied from another error path.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (3):
      pwm: stm32: Refuse too small period requests
      pwm: stm32: Fix calculation of prescaler
      pwm: stm32: Fix error message to not describe the previous error path

 drivers/pwm/pwm-stm32.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--4qkuoqnxltzrtyd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ25DMACgkQj4D7WH0S
/k6kkAf7BzBM/IaGbM6hE4hPIfK6I9gbdqNaBFd25mPTfpz1MURoanagB/flLCiX
nD3FicwDbss99QLAtATy/GsTDZOqE0HTjn8NDVjWCtBGfhdkbKdPiStHnQYbnnlB
/FjCbC1/wQI9hpBEiDzMrhRh2xY20rTCOKC8SYRUCdJVIZa/Ue4kOZgxdF5mVZMa
Q/5Als56JoUx1oHf0i2KyV0X8F55iu92j3BGXJ7u5OAt9NcjoFmPvMKr6KFVMEZa
7htcD2ZyauNJT8auwOLzakqA8C/k3brmaNrVqb8cfOHpFkbaT8X1eOu+vpjwVZHN
h9ma1plqgx71DoaJHlIRc85gjReA2g==
=ifZY
-----END PGP SIGNATURE-----

--4qkuoqnxltzrtyd6--

