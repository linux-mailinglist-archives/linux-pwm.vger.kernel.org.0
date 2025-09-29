Return-Path: <linux-pwm+bounces-7356-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB5BA800E
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Sep 2025 07:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B431785B7
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Sep 2025 05:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9F29B8E8;
	Mon, 29 Sep 2025 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElpsDq2c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E529B8DC
	for <linux-pwm@vger.kernel.org>; Mon, 29 Sep 2025 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124506; cv=none; b=KYquEy/P7GJ7GWa2dFzBW2kaOFRcGiYUaEMoI6n+TtTwL/QRrY2hpiED0FHc/O4aECz0wKbc1X9wWtnlNW2v/X8Wcvhw7+RsK86dxIlVAfuytswAp5pxNKl2wlwLy3hnBd3YthZrkNXJqfNZRVwsbrZpfIznV61lPY7xPH3S9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124506; c=relaxed/simple;
	bh=Lvn8T1wUKlrgTrrq99kvpCDXJ/g1SM5vpZu4qoHH1UE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e5IiYGU0VzKXgLbNSnTrU+SwO9vtrjTZ0VUgjvfXrYlc6xNPWBKIHPLqsoWyVJTTLMb2Qizp3X188rzx1seKV+iThDECaXcPA/uSZ29s319OhjV/+1/FyzoWC6ZgT32fhsYVDzwkPuC4y1VvtCuv1fRWE4CUzb/T0JMTx1d0/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ElpsDq2c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so9809305e9.2
        for <linux-pwm@vger.kernel.org>; Sun, 28 Sep 2025 22:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759124501; x=1759729301; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hgi0ZTEkhCBobMcksMg/fMrDzp6rhP+k5TYYLF7nLLU=;
        b=ElpsDq2cuVEc7E864ePCgL8SxKZzPPShg2JPt9JCxqYwwR/cAl9LACjMQwus4m5nEV
         H2lMz1+XqX0MhHHP7usuLEyKOevPCP5PcYlLUGIr5a1i+XO71D0pzCVungPKvCzfPIeR
         z/x/dviMACgkjPCjdj3gbsDJ/bjGn3BdE5FcjIqsF9Rk5L9lvMxe3PSyvLG+CcTOacur
         ctQdBDSCTFQHpZyn83lCsvN/b8fnFYUqJ81tJsNzS+Aq5k1abqcL28xqJdComzs2XH6P
         EPxEFKPqGyNMFjBIshyEhFWE9916yfsEFarErQSGBRjwahcdTOFVauUlHBZkiwKBg+nE
         j8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759124501; x=1759729301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hgi0ZTEkhCBobMcksMg/fMrDzp6rhP+k5TYYLF7nLLU=;
        b=dsNqbbADEBVgYyuf9nK1tqqG0ZGMM+VSwuSMWJY9xaC8J9tpVAWzKRfVgyvCZ061iw
         kUlhRuMgIHxX1zSFAemNUevMO4ZIRAHgr48gOKUtcB+pAd9D9YP7eizoeJOscjBzNHPt
         gzKFUKr5H9f0zZMf3dMCpS7cN9ozfCVZ0Uw7IyaHb5D3bTh2SLGRf8+euXbSwQGN6AFx
         O764eqgZqdp595YOZOiz3A8CXTt6A3j3vBmDyFWTmxgwBAP20gj2XysZwCV7xA/5aoF+
         /641ZzLUwOEW8tSDTw1KxPwYNJKknihCXBcXNUji2DHNgW2iMdiTbaT0/aS9xRrH2fEz
         kZTg==
X-Forwarded-Encrypted: i=1; AJvYcCVS7yPCWbA2UAUnMOgYwcE+d2awfEtpeRHZSqFfZg/KMHJ0rC1UJMUMDMWI0Z7IJ/QUMaFCO2F7cAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPiYVT3G+mOgaEuwG/sRQxAkca2qAoyXyFn7KMRF1S5UI5BMou
	jUV4cogK/11hF9EQA9w61xGL9VWhmCTJ4vxg48yKMVrb70PKwSLIDeGD5e6NfFHYWd3EjQ4rnmV
	K2bMb8wE=
X-Gm-Gg: ASbGnctxAq1ATBLfveqzMANI9FmUUzSP5GTJvLzHs0P8QoNlidZCDIpjSAPwq1tXm7Z
	ucoT7AH0njick2eXrvT+yN2+F5Z9fEpLw0saXRijUIKT7OI2UtpKYFZ3Pa7vGzExqwuItdIm3cN
	ODXFHYZWxJxJECAzManOz2rZIoKWoGetpxCfxpoDcmIL/O0cO4lCm2ZOvoxiAeDj1e1ITjvP0lg
	jgjRKgBVdt/SQ1oLOEpkns536HEDpjWrvS0EvJaABRMQ3tu3fdSDZcUgGbIs5jNHeGRPxyyeuUH
	38bAde+5r5AyVv4CyIVcRaD22FW8Hg8wb2kRyUECC5IDX8sYXQP2s8+IGeynn2IWbt+d2qQoBJG
	BVchXBkZvThLWgJM8G864AeJqN11i/MxqRZ7WRyLjHDqdD503/Y1qFYqp28yLCdgMavjpPw==
X-Google-Smtp-Source: AGHT+IEaKb3g6sQ6remUeoL/AUn5TgHYVpNIer58FUutG2qpwQrKJqse5m9ODma5Lan4BZIkg1Txbw==
X-Received: by 2002:a05:600c:83c7:b0:45c:b5f7:c6e4 with SMTP id 5b1f17b1804b1-46e32a18479mr129257235e9.35.1759124500781;
        Sun, 28 Sep 2025 22:41:40 -0700 (PDT)
Received: from localhost (lfbn-nic-1-10-73.w2-15.abo.wanadoo.fr. [2.15.106.73])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33e3b300sm90269625e9.1.2025.09.28.22.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:41:40 -0700 (PDT)
Date: Mon, 29 Sep 2025 07:41:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lee Jones <lee@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.18-rc1
Message-ID: <jeblxobrtuzcsgs3r7g5fxvpmauttof3qzrlvlaglueg4ls4ea@dk7kpwkplno2>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kejepkqwbc4zpbkh"
Content-Disposition: inline


--kejepkqwbc4zpbkh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for v6.18-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.18-rc1

for you to fetch changes up to 8f2689f194b8d1bff41150ae316abdfccf191309:

  pwm: cros-ec: Avoid -Wflex-array-member-not-at-end warnings (2025-09-15 1=
1:39:47 +0200)

----------------------------------------------------------------
pwm: Changes for v6.18-rc1

The core highlights for this cycle are:

 - The pca9586 driver was converted to the waveform API.
 - Waveform drivers automatically provide a gpio chip to make PWMs
   usable as GPIOs. (The pca9586 driver did that in a driver specific
   implementation before.)

Otherwise it's the usual mix of fixes and device tree and driver changes
to support new hardware variants.

----------------------------------------------------------------

There is an immutable branch pending for this merge window that was
created by Lee at

	git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-inpu=
t-pinctrl-pwm-v6.18

=2E I didn't add it here because it merges cleanly into my tree; you'll get
it via Lee's PR and probably others, too. (For the next time such a
situation arises: Would you prefer me including such a merge anyhow?)

Otherwise this PR should be boring for you
(https://www.youtube.com/watch?v=3DV_ioxeU7Kpw). Diffstat below as usual.

Thanks to all contributors!

Best regards
Uwe

Colin Ian King (1):
      pwm: Fix incorrect variable used in error message

Daniel Lezcano (1):
      dt-bindings: pwm: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32=
g3

Ghennadi Procopciuc (1):
      pwm: Add the S32G support in the Freescale FTM driver

Gustavo A. R. Silva (1):
      pwm: cros-ec: Avoid -Wflex-array-member-not-at-end warnings

Ivaylo Ivanov (1):
      dt-bindings: pwm: samsung: add exynos8890 compatible

Janne Grunau (1):
      dt-bindings: pwm: apple,s5l-fpwm: Add t6020-fpwm compatible

Jisheng Zhang (1):
      pwm: berlin: Fix wrong register in suspend/resume

Krzysztof Kozlowski (1):
      dt-bindings: pwm: nxp,lpc1850-sct-pwm: Minor whitespace cleanup in ex=
ample

Uwe Kleine-K=F6nig (21):
      pwm: tiehrpwm: Don't drop runtime PM reference in .free()
      pwm: tiehrpwm: Make code comment in .free() more useful
      pwm: tiehrpwm: Fix various off-by-one errors in duty-cycle calculation
      pwm: tiehrpwm: Fix corner case in clock divisor calculation
      dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells =3D <3>
      pwm: Disable PWM_DEBUG check for disabled states
      pwm: Check actual period and duty_cycle for ignored polarity test
      pwm: Provide a gpio device for waveform drivers
      pwm: tiecap: Document behaviour of hardware disable
      pwm: mediatek: Simplify representation of channel offsets
      pwm: mediatek: Introduce and use a few more register defines
      pwm: mediatek: Rework parameters for clk helper function
      pwm: mediatek: Initialize clks when the hardware is enabled at probe =
time
      pwm: mediatek: Implement .get_state() callback
      pwm: mediatek: Fix various issues in the .apply() callback
      pwm: mediatek: Lock and cache clock rate
      pwm: pca9685: Don't disable hardware in .free()
      pwm: pca9685: Use bulk write to atomicially update registers
      pwm: pca9685: Make use of register caching in regmap
      pwm: pca9685: Drop GPIO support
      pwm: pca9586: Convert to waveform API

Xi Ruoyao (1):
      pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT

 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |   3 +-
 .../devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml |  11 +-
 .../bindings/pwm/nxp,lpc1850-sct-pwm.yaml          |   2 +-
 .../devicetree/bindings/pwm/pwm-samsung.yaml       |   1 +
 .../devicetree/bindings/timer/renesas,rz-mtu3.yaml |   7 +-
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/core.c                                 | 108 +++-
 drivers/pwm/pwm-berlin.c                           |   4 +-
 drivers/pwm/pwm-cros-ec.c                          |  10 +-
 drivers/pwm/pwm-fsl-ftm.c                          |  35 +-
 drivers/pwm/pwm-loongson.c                         |   2 +-
 drivers/pwm/pwm-mediatek.c                         | 312 ++++++++----
 drivers/pwm/pwm-pca9685.c                          | 555 +++++++++--------=
----
 drivers/pwm/pwm-tiecap.c                           |   4 +
 drivers/pwm/pwm-tiehrpwm.c                         | 154 +++---
 include/linux/pwm.h                                |   3 +
 16 files changed, 683 insertions(+), 537 deletions(-)

--kejepkqwbc4zpbkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjaHA8ACgkQj4D7WH0S
/k6QeAf/Y7JaZiqli26ZPUagiLUzmPPrf7ofqprB65lAS8MdzsufDsX/hq32McVa
Aps56clnG7/62+J8gvO/ZlkBioI4NbMeeKkGL1UAmL+/8jZfwbSz72d3nB6fN1rI
h++6YB5Zp+G4bHhEuV77ys4YRCbah6pOGgzxxHOX2V1Qdebqg+ZE1lf74l0XeBSn
5ugy/6ysbTkEKGrX2arlawRSrWF/5/WUqXXKmvUi5lM0lTfJZTLoO1E4n/vdX6Hw
ZYF8bJ8dn0P1PQTgNktBhOpf62C1w1pKKAqj4I1g40xYe4ccDGARKsd7qzdbtLs2
2K6pRMfvi/1qOneK+XI6uTEZdqurBw==
=YibB
-----END PGP SIGNATURE-----

--kejepkqwbc4zpbkh--

