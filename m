Return-Path: <linux-pwm+bounces-7961-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03198D3C4D8
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 11:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD3CC6A679F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972853C196E;
	Tue, 20 Jan 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H3ZTpsb8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AA35FF66
	for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901552; cv=none; b=sZlRhc2DF2WK1zVu0sfUKKjvtKag2RH6Lkl7SQHq96GqkeUgVR2dQdm67NCeLd9EAGrtsq8WF/uJwC7HQn6gXz044M5jqTAczHilMks5mFPNDKjhzWASPidQ1s4zUiezqAazAChHSjsK+O9p2G4Jh6qbzraSkSpRbGsDwFAcyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901552; c=relaxed/simple;
	bh=kJdccnKVHr95ZSKzFyw7Q4flYS9ApSCAE6mTdeKwfXw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lXGex9gUAcqBJOmv3CfDHXq2PI+pSpHuM4dM0FBkkL/a51I+d7ZKZReuw3LzwtDyCKBZwL0GvU8YjCMZztaJWDcRYOJrgdhDVCBjV2Go3+OoS9R9PFPtkE+NGZcVQb0S8LlEUr3ypEKnByNax0E6RTLSrZbelaMcdDzyjdUK128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H3ZTpsb8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso35726285e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 01:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768901549; x=1769506349; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y92OknxMdYYFZWfVNlcHVxqawCFb3m5tzZdSt+3HRXg=;
        b=H3ZTpsb8x+weBRp1ElHw7RPYP/yQZy6SdsizT8Ep3tubPlC3elmSJkyaw+Ub5sRe1b
         6nho53VBk2qJyPJhrOT7njnuMqGGwxib7zczUX+SRP0ktfPCZXlkv/lh66JIaM77V7IE
         Nur/N+uwzCcP/ieilwnIrDUxoZVZLmoZK6AzmtJkbHCgWy+OtHSBqI5tCEO3OziPx1tX
         GcfInep6iuHfuz6KGhZqgKg8ZaPM0MS73kc7Edop1VACweYa29V8hNj1E4GGBRBoEBYT
         +aUBTg7GyFyaPhuGg50ORASqJqF0GpNDkt+hSjGV3alsCm7cfbneD8ZA68vAVigsemqC
         DJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901549; x=1769506349;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y92OknxMdYYFZWfVNlcHVxqawCFb3m5tzZdSt+3HRXg=;
        b=wLtp4icuoCFb50tZ3XKRlwSBWlQJgLjae+gJhxeP/7pLRRQ7/hdPAuOfHTaGizEJMo
         CXDAeIbnzu35feFoTCXZBXqtQ8OoFJpxu8QaKdl2wB8lYmMywdH8shYbErX+F+h2htH8
         i034iJ+5mR8FpBwk++N5TQjnc4CI3q/RD3VQBsqDqF6ixPGqJK4Cd1vOLM8gXjFH7A13
         lZqcvkNcbpyN7KtbGHrDEMWxalN68u3hMqnnTDnvrvm9UpbJpJS2cUKbfsR3PjyBVPY+
         7eTdbITJrL19Hv0C/JoPtt3yKrYGhmhi3A9IZsLRhmwIMjiz0e9OloLXZCmkQMKZmeLC
         c/Sg==
X-Gm-Message-State: AOJu0YzcLNhimQuu4ZY6r7E/5FdiF0N6fRPzGZGuIp7MfE+HmvwJM4PX
	uM7mNoW0F6YtxBHt4VE5UOigUye3ZbY4SK9kF+4D1zZEpB27p130oChQLKcHs/rLRHw=
X-Gm-Gg: AY/fxX5leFAWttKkckD2QRbnk20NDiELZM0yfIRUagZMMrVOHzAeZZjcMXPRKZy6Wrb
	O4F6xaQ842+d9X9tqubQNur6fiWdNMuJswyGFQOUWUJPYJdvVVoz7UK3ob/J6Xlq0PXBS1havgc
	EmWSs6P7tLoCHEvtw1++QqCJugdyZ55t1HW9dxEa/pDgEHYGWI0gYLw0X6jvDOt1SlZxbVMdTOS
	0yUoEzAn1MFzYv3kryGCBDH44r+2UCb/BGitux3Pkzkjt5/XfdqXVxrtFywjtrg2a+My3WAbU5g
	xXBppLO5qnqgHcsFwmaao7NV2xsqI1AsxWb810w9/anES9Cpdq3O54S+q/mQWS3tF7wN+rBI5qy
	lLVk0l/RLch251C7D1eKoLF6QgL+L9nvId6kUDdCLiPelEUmyLEM3Zofh9Mzw+xC5My+Zj6QkDJ
	NNZCAGl3W+Po0YgYWVETc16sHybN7YscpgCm4u6QpIYwPAsj8wiISAqMXjuOP4uZoO+vtKNLAc
X-Received: by 2002:a05:600c:5246:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4803e7f1b66mr12837465e9.30.1768901548579;
        Tue, 20 Jan 2026 01:32:28 -0800 (PST)
Received: from localhost (p200300f65f20eb040d9b4237dff0028c.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:d9b:4237:dff0:28c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47f428b954esm293350125e9.7.2026.01.20.01.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:32:27 -0800 (PST)
Date: Tue, 20 Jan 2026 10:32:26 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Richard Genoud <richard.genoud@bootlin.com>
Subject: [GIT PULL] pwm: Two fixes and a maintainer update
Message-ID: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iq2jec5ndipongvk"
Content-Disposition: inline


--iq2jec5ndipongvk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Two fixes and a maintainer update
MIME-Version: 1.0

Hello Linus,

the following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.19-rc7-fixes

for you to fetch changes up to 0a155a8a24ddc647aaf28ce7cdb14af7270c158f:

  MAINTAINERS: Add myself as reviewer for PWM rust drivers (2026-01-20 09:5=
3:18 +0100)

The commit that triggered this pull request is the ioctl one that I
consider critical to get in. I only noticed this problem recently, so
it's not in next yet, but it should be obvious and simple enough to be
correct.

I wouldn't have bothered you for the other two changes alone, but sent
them along now that there is a fixes PR. These are both not very
critical, but also simple enough to not have to fear regressions. The
max7360 commit also sat in next since next-20260116 with a different
commit id (i.e. 3bbf529821f64cebad9f385af19e149a9dfffead) as I initially
thought to not send it to you and now had to rebase it to not include
merge window material. The other patch is just an update to MAINTAINERS
to prevent people sending rust pwm patches without cc:ing Michal.

Thanks for pulling this for 6.19-rc7.

Best regards from Germany
Uwe

----------------------------------------------------------------
pwm: Two fixes and a maintainer update

Included here are three changes:

 - pwm: Ensure ioctl() returns a negative errno on error
   This affects two ioctls on /dev/pwmchipX where the return value of
   copy_to_user() was passed to userspace. This is fixed to return
   -EFAULT now instead.
   You might argue that this is an ABI change, but I still think it's
   sensible to be fixed because a) other exit paths already return
   -EFAULT so userspace must be aware of this return value; b) the
   interface is somewhat new (commit v6.17-rc1~181^2~35 ("pwm: Add
   support for pwmchip devices for faster and easier userspace access"))
   and the only known user is libpwm which relies on the fixed
   semantics (and uses the ioctl correctly and thus doesn't trigger that
   problematic error path); and c) it's very unlikely that
   copy_to_user() fails if a moment before copy_from_user() on the same
   memory chunk succeeded.

 - pwm: max7360: Populate missing .sizeof_wfhw in max7360_pwm_ops
   This fixes an oversight in commit v6.18-rc1~168^2~3^2~6 which added
   support for the max7360 driver. There is no user-visible effect
   because the .sizeof_wfhw member is just a safe guard that the memory
   provided by the core is big enough. While it currently is big enough
   and there is no reason to assume that will change, doing that
   correctly is necessary.

 - MAINTAINERS: Add myself as reviewer for PWM rust drivers
   "Myself" here is Michal Wilczynski who cares for the Rust parts of
   the pwm subsystem. Several of the patches sent recently for the (for
   now) only Rust pwm driver did not add Michal to Cc which resulted in
   the patches waiting for review as I thought Michal would care but he
   wasn't aware of them.

----------------------------------------------------------------
Michal Wilczynski (1):
      MAINTAINERS: Add myself as reviewer for PWM rust drivers

Richard Genoud (1):
      pwm: max7360: Populate missing .sizeof_wfhw in max7360_pwm_ops

Uwe Kleine-K=F6nig (1):
      pwm: Ensure ioctl() returns a negative errno on error

 MAINTAINERS               |  4 ++++
 drivers/pwm/core.c        | 10 ++++++----
 drivers/pwm/pwm-max7360.c |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

--iq2jec5ndipongvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvS6gACgkQj4D7WH0S
/k5wYwgAtXt6qlZw9kQCZeyA1DHyGk1NY4DelMekO4qUV1GToOg5jjkcoM8jKfQq
E1K7d3eB70auZuUKe1vkxiV7qXKkXf0ErkfXuGEHliVtbDGhylLI+N9dfgEtLrKt
OKOTYIqIDF0fbsZXIRn4WSA5/b/7dBvMwiZ67tzQiE48uyDKzLHaDPIdH7oe0W0U
/yQaOnr9FtchCgo6vaaRhkQ1GbClLJ13tvNXvsISjx4hbkaP0vfzCYz0KKmimRct
p6abM6kUS8GPXlkPbQgNg9+PrK2+F8Jf7lIKfkFscXMHJpfFbibTOzqtQWFGkKGn
eUGHihLkOBpH8WdIzT8IWlWiExhupQ==
=NLNn
-----END PGP SIGNATURE-----

--iq2jec5ndipongvk--

