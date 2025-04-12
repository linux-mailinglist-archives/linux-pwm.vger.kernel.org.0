Return-Path: <linux-pwm+bounces-5472-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F62A86CF6
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 14:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58973442BF1
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BDF1E51EE;
	Sat, 12 Apr 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2xxtZZA5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB4C19922F
	for <linux-pwm@vger.kernel.org>; Sat, 12 Apr 2025 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744461889; cv=none; b=PyUAxdQlQP/1RDsgESpVg3Q6MSpD9O/EtflwXDfmhwtpYNoFnSWTA9x4Q9USEv5Z0APwqTFCzyutnIA9fgJ6DE9kPjO1iWU8qqfBK1g7cWwWrpafrJX0omGtHD3dzN3PbC73b097AvA1P/ZOEX/YrPsHHjNl33+x/3dMssuqj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744461889; c=relaxed/simple;
	bh=BXN5IJBy+U/r1XxX80UAHKirNCDRL5Ui7l8cqOrBEuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AShFutPVs1XYozrBGGn80xCCFNhOuluPCBnbFWlGsCArB8xIms4Mh3mdt8xvHBrwxoXp7saVI9wiNOJX3/QrzDioKiWEjQPCmlx8Xbdr28fj2ndp1VuWHoE47yNEbzLwUdn5JsD9wYRTTLEITecpxH2xgsLDL/fgUz+NVp8tmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2xxtZZA5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac34257295dso553049166b.2
        for <linux-pwm@vger.kernel.org>; Sat, 12 Apr 2025 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744461884; x=1745066684; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9LJm9EGmJPHbvs5a7/gVifsXirV3Rhzs2NwLcaoK2Y=;
        b=2xxtZZA5dJLxz9Yy1oEQl1bCld0KpyLC9e9KlHM2PCnWkO16l8daDrJmPzTdhZzi40
         d7smgV0gTSaNWQmM9uZ9xtwsbnR6iS7LzdTSrx9x0fih3d0rBLuSO4EpnyOaJ5lOB+ai
         vPVb2t1hbAO59A9Tt3k4u0DKGGMJGEZJRxWy0I10cfr4yTXx4Hyo3OMyD87wWzkEZ8PS
         jHmP0y5x4kYy/fE6ptrCmM3tcFdC8VujyviBqG5+gqeAYzZX3r/LW4hQ8a/LQyh3PKi8
         eUnouxTnMmUBPOtF5zkm5juOHIS1thbBagXyVBbi/OagWpeYqfqhHoKywr76GmWW/qLC
         pfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744461884; x=1745066684;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9LJm9EGmJPHbvs5a7/gVifsXirV3Rhzs2NwLcaoK2Y=;
        b=w3bDY4Ajk/jgnwh95S7IekuXK1wYh9Etn/qhDQvWeo4s1T33/D1bk+hBbBoCI6tlFu
         3YoJR6HqDdwCBzDAPZcoJkVOEtfBgRtlR4rV6+bM4Li8QD9NvCouxXu6AXhXOeGiybEt
         Hn7ZSC/wM2egOTuAbCndWdyqzra8dN6BuVEFcCEUHJtLCZth6NLClyMnZZ8cG2gBUsV6
         c2IlhB2QXRon2S3jwO3yEisTWuZNNz7sG+Ifku2IRHxMJSZbMoba4LJpqtQVyAJHtuW+
         HeZNJPbXbzg5HxKnYTiTIYPbA8265fMCUJiQjJj6YwKe7QnBM0IwOOY7zGR8/AO3rBPO
         UEtw==
X-Gm-Message-State: AOJu0YwJg13UzvGvriQUzd2bffeZ4qMB98Rcw9V5ewlOFkDym6Gsqw6y
	LcuO+gycNpixXIF2bQIf2IT9oUwSY0wF+V1Y/1t9TRT76U+g/htHy0QkpTzdXXc=
X-Gm-Gg: ASbGncsgTKUeFt2bEVqQ9vdUhZudjCET+l8dkffkjT122A4yq1V0CYlsB0DYnSgbBp4
	gToH7ZF47qgOtjLBW6ikMzRWwUXKZxAhIcqmcwgq/Wi12751oTa4Yj8k3hyRnSY0q3pwMSXWv4i
	07Mtz0JbyySdZBJY282Lfu55h6Be6gmNq6Rhlx/4uKy+aExjcGQ3mYvDClFU7KUaOCGyKxusJsV
	Qu/ZTK3wle/dIzwCUWxI0LNhzNs/PaD9dMBXeEWPQpOt9/ifmVf3z2d3dBk3PIsF2WD82cUaPF1
	20hbKwYOtIroQsjcKzU/G3Ijx2i9Jgt8gRRfPTh38LRZ9A==
X-Google-Smtp-Source: AGHT+IFDjG6IwXL2D/vHahVH43yBABIgjB4DWpSp8xfVirmah2ldFLYOZzmBiVJ84VzE+7aHO3wzSQ==
X-Received: by 2002:a17:907:3f1d:b0:aca:d2f0:d291 with SMTP id a640c23a62f3a-acad34449acmr590784866b.5.1744461883538;
        Sat, 12 Apr 2025 05:44:43 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f36ef562b6sm2306964a12.24.2025.04.12.05.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:44:42 -0700 (PDT)
Date: Sat, 12 Apr 2025 14:44:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Trevor Gamblin <tgamblin@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [GIT PULL] pwm: A set of fixes for pwm core and various drivers
Message-ID: <7ebsnb2uoriokrmxswii64fiqjmtnojq26gk3xu733bgblmcm6@4rpajnkrc723>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3i2ttvofc37ysysw"
Content-Disposition: inline


--3i2ttvofc37ysysw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: A set of fixes for pwm core and various drivers
MIME-Version: 1.0

Hello Linus,

I was unsure if I should send a fixes PR given that the problems
addressed here are minor in each patch. But given that there are six
patches now (which is an unusually high number for pwm), I thought
bothering you for that is fine. These commits were included in next
since next-20250408, the first three patches even a tad longer (with a
different commit id though as I added a Reviewed-by tag since then).

The following changes since commit 6df320abbb40654085d7258de33d78481e93ac8d:

  dt-bindings: pwm: imx: Add i.MX93, i.MX94 and i.MX95 support (2025-03-10 =
17:13:54 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.15-rc2-fixes

for you to fetch changes up to a85e08a05bf77d5d03b4ac0c59768a606a1b640b:

  pwm: axi-pwmgen: Let .round_waveform_tohw() signal when request was round=
ed up (2025-04-07 15:10:30 +0200)

Thanks for pulling this into 6.15-rc2.

Best regards
Uwe

----------------------------------------------------------------
pwm: A set of fixes for pwm core and various drivers

The first three patches handle clk_get_rate() returning 0 (which might
happen for example if the CCF is disabled). The first of these was found
because this triggered a warning with clang, the two others by looking
for similar issues in other drivers. Similar patches were merged earlier
for v6.15-rc1 in commit 92b71befc349 ("Merge tag
'objtool-urgent-2025-04-01' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip").
The remaining three fixes address issues in the new waveform pwm API.
Now that I worked on this a bit more, the finer details and corner cases
are better understood and the code is fixed accordingly.

----------------------------------------------------------------
Josh Poimboeuf (1):
      pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()

Uwe Kleine-K=F6nig (5):
      pwm: rcar: Improve register calculation
      pwm: fsl-ftm: Handle clk_get_rate() returning 0
      pwm: Let pwm_set_waveform() succeed even if lowlevel driver rounded up
      pwm: stm32: Search an appropriate duty_cycle if period cannot be modi=
fied
      pwm: axi-pwmgen: Let .round_waveform_tohw() signal when request was r=
ounded up

 drivers/pwm/core.c           | 13 +++++++------
 drivers/pwm/pwm-axi-pwmgen.c | 10 +++++++---
 drivers/pwm/pwm-fsl-ftm.c    |  6 ++++++
 drivers/pwm/pwm-mediatek.c   |  8 ++++++--
 drivers/pwm/pwm-rcar.c       | 24 +++++++++++++-----------
 drivers/pwm/pwm-stm32.c      | 12 +++---------
 6 files changed, 42 insertions(+), 31 deletions(-)

--3i2ttvofc37ysysw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf6YDQACgkQj4D7WH0S
/k7LSQf/UX24apQltg4p9pW7xTxFE5hIv1Vjs1w7jLYIHMV9nT0IepC8sWVB28TS
NotRH0DToWv3KP9hINd2/WKaYpxQDjlrbnFMN7xn9CWW9g38HXZIgC5obZwrfOb0
GlfSscBOYMouqykFhgN3VxvCqMSIFMyYdJ5h268wLfXHViqTZglBy1O+S5WTXvbk
X7qeXyYVlbZJKfpHhCuadjsMEuw0zcylV1zmt1i5q1jBD5RrMzyBj6ye89GF0Dbb
HhqeyuzMnCuUeJNFGGLGYs7+gSCOtdh8OeTclJXUo3WPNvYCgOhd/6KqWJG8+Q6r
RBevPH5VrjSopbYFgmgiGifSrCH9xA==
=sQm7
-----END PGP SIGNATURE-----

--3i2ttvofc37ysysw--

