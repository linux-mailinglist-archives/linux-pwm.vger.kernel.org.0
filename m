Return-Path: <linux-pwm+bounces-4747-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771D0A1DABB
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59FD165A1E
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B478815CD74;
	Mon, 27 Jan 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WwiASt23"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116815B99E
	for <linux-pwm@vger.kernel.org>; Mon, 27 Jan 2025 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996192; cv=none; b=CzhBHIo8iWqFdqVn+PxafjJX44y+ZQZEyPUOZJ4/jhH4xYeZ20VyKNdDWi5ZUWQFplx3hcmvD1BW27wgYZw/KoHwuwzmHnyncYju+H42GGN8e/FUPKWmdzOEvXLI4hqMjrLLw4+Kxg2mk7A6Z6xkxiggjoA8fYL1MmPuAW8Fk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996192; c=relaxed/simple;
	bh=tQiv0QOLxIax2ZYCY7XQhdskHLZhCN9KtuA1ONJS7Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XxUPpc8q3xdTfj4CXIspjZ3tAPYQRBRueAHct15+sVtcF5MgJD8gabT2OaUzhxKL6CpHlwbu79oiVYMFVam9ne3jgXRugwnjz5L1VoDoMWzf0G8VxGQkNVJhZ28F37ApvwU3Z6uC0PhzvX+1Oii6geW/6/SHhHR0hCZ1Ys58ROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WwiASt23; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so741077966b.1
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jan 2025 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737996187; x=1738600987; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FqV90U9nbRHAX87DykUHpDEtd0eNXaoHxariOoC+7I=;
        b=WwiASt23lNnEcbD45NFBwMWEljB+ib0Wk5FG/yyeGhaddSeCzKtvFR4sLcs2xwHaoV
         Dxyr5lARh3uNjVEpanjTs6IDt2hiXOOJKiakpCo12q628DqTnPzxcmbjP6b/eWr0Md2R
         TN072jdyhjSLcrr4Z/y8c4NldTvwzGDF8ebBgx5jVqLPdFpgfgJY3n2rkQXuZ+g26awx
         HJBILfdC0PtFCPN8+dGYyS9MVdCPjHZmL6VHxn2O146KK4+BO5l9HgBqEzo1QeGPUdJK
         xgWs/B+xU1+A93o264SAGjeRz+2/UcjuTvD57SYpjGDdEm4j5t4T1yXQP4CY4j3yjhNc
         +AzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737996187; x=1738600987;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FqV90U9nbRHAX87DykUHpDEtd0eNXaoHxariOoC+7I=;
        b=CmBhYO+scFlV85Ni2AjX1bf7YQtJDMy0XC1DMHNW3pcvRXJGpNHKCYqFgt5QyEmodz
         o0RNG693ufls6SxgdH66sguZ10IcBUueV5vK5xrvDK0YQEGMf0aglj0vT0EwWiuwnHKJ
         UnxSTQLo63045deesWE9HlJJRu+nSRFf3tDUEiH5F3/3wDvkzJL1ArS1oquch7w2v0so
         QCei+JuWzUpTbQY0sSjNNTlQ9Rg/XvhPQjgY4opCX89HMEHIJRUFEPNrslCEOac60Lzx
         ftzD5RqsZc+H/e43SItV7ZJSTkYUWPL0QViQcUNNjzBHVPZMWnoGbaXRVaYt00fr3C1c
         LY7w==
X-Gm-Message-State: AOJu0YzjTsgorSioywweE+H7QyPWFzIQblmtlSapkNY9qudapA1d6L5b
	+X12EZQlGdDGU87IIaO2U06ivLFcgbJ1/SmpO5IPFz3+X+RzHRW51kR5jCuhHKQdQFqFfHC5s+k
	m1V38rA==
X-Gm-Gg: ASbGncvfcslEdlAZW6OVaTrRcK81uzLbFnE/YLyn1n2gWOU87TjbyVHIod1IWBPZSWX
	h4ee5Okh+GcK8FN6y6meFNyCCwUReESc+t1/URKIjI9ywwS3GNbAPfMkNGDJRdI9swfuO/0jSrc
	gp5XQ/pDSgDAdkN0GWipUeYIbxJBu+jD6GfLBoriV+qOI/AFB706Klujeh4RpjNyaTVkAAVM7TY
	1QfvlDyB8wSSRo99puuBobu8CgO71AH/S00I7amK1xu+4ogpR6XxpNpESxhpHWk7uAf+UhivqVL
	hoguB4HFhQ==
X-Google-Smtp-Source: AGHT+IG2ooThduLGdyzxeWCjVmTw/nAsz93TMUK3acid1OgtHyRRC0k4oFaaoATXkSiCI/29cG+B+Q==
X-Received: by 2002:a17:907:3e1c:b0:aa6:a7ef:7f1f with SMTP id a640c23a62f3a-ab38b0bb338mr4120765566b.11.1737996186773;
        Mon, 27 Jan 2025 08:43:06 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab1c0sm605717566b.121.2025.01.27.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:43:06 -0800 (PST)
Date: Mon, 27 Jan 2025 17:43:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: [GIT PULL] pwm: Two fixes for v6.14-rc1
Message-ID: <l5pzdnng5lha6vxfoetrectekbujvkqir35fc5cemo6qadqno6@abdgcnbtevb3>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hy33gi3mg5yv7cdx"
Content-Disposition: inline


--hy33gi3mg5yv7cdx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Two fixes for v6.14-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit e8c59791ebb60790c74b2c3ab520f04a8a57219a:

  pwm: stm32: Add check for clk_enable() (2025-01-17 10:41:56 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.14-rc1-fixes

for you to fetch changes up to da6b353786997c0ffa67127355ad1d54ed3324c2:

  pwm: Ensure callbacks exist before calling them (2025-01-23 20:35:53 +010=
0)

Thanks for pulling this for 6.14-rc1.

Best regards
Uwe

----------------------------------------------------------------
pwm: Two fixes for the pwm core and the pwm-microchip-core driver

Conor Dooley found and fixed a problem in the pwm-microchip-core driver
that existed since the driver's birth in v6.5-rc1. It's about a corner
case that only happens if two pwm devices of the same chip are set to
the same long period.

The other problem is about the new pwm API that currently is only
supported by two hardware drivers. The fix prevents a NULL pointer
exception if one of the new functions is called for a pwm device with a
driver that only provides the old callbacks.

----------------------------------------------------------------
Conor Dooley (1):
      pwm: microchip-core: fix incorrect comparison with max period

Uwe Kleine-K=F6nig (1):
      pwm: Ensure callbacks exist before calling them

 drivers/pwm/core.c               | 13 +++++++++++--
 drivers/pwm/pwm-microchip-core.c |  2 +-
 include/linux/pwm.h              | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

--hy33gi3mg5yv7cdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeXt5UACgkQj4D7WH0S
/k4j/wf/cjLJaH3ue6kfph3pEmqt4RAhkbDnUlDxNHdADciR+CxOYtIr59oxjCwM
5h3C8S9Fy2RoR8qcSRN1Mb2DXSHYRNT/RvvrJB3b8SfsUk0k3YN5/8F8liMLo82n
ZIVc2p1CBpALmZ5BOsHj6mtssy9hdA0mznD/QrWOXOqbJ+r5hYLgW7DobJJDAsaV
ZdJWd0KUC+Tk173EjNq7OLyUtNCGs+xf4DEbzOQ2QooOAb9iOevyx7n6Ikv3c83h
7gL8i1E/cMjgLVmw5ABZshLYw7gTdU5gRWaTVuGvUWM56pIwrav0mHQrpL2yx6aG
e1Pd9dGAWeBEq4Oi3xuGau0cfJ9XPw==
=YHQ8
-----END PGP SIGNATURE-----

--hy33gi3mg5yv7cdx--

