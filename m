Return-Path: <linux-pwm+bounces-7797-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FCCB8A76
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Dec 2025 11:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 580A7300D03C
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Dec 2025 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04023195E5;
	Fri, 12 Dec 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="feEGuTkN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05730DEB9
	for <linux-pwm@vger.kernel.org>; Fri, 12 Dec 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765536768; cv=none; b=AiXQHeUcUMkZFGl+UmlCcOjB0W3xXJqGd8vCCKx9NgG92EEAy5rfYEUtN77Oo87uyaP343bkMA8KTLZc5SeteDgPG4MQ1oPGcWO6bIUzK6/BLJxAmb19dobMRBzRFJ3F8cm0/bKsEcqQJzj+uwebojgNRtgD6v39wH319sH1Lz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765536768; c=relaxed/simple;
	bh=Z9e0bIvylOYkZ2L79bdYTrjNmPoQ5w7t9+2lqW4Jg8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=teGCxGTtm5iu/bdY3M+50F2ywHzxdf4l8BgqeG6Un/GQxYasaZdObUZ2iFbgtIEB086f4ywIrWSvfZi8TFgZovW+NHrhsar2NaMsuCBDdc6oOfSkUXOGP6lPK7Rn/zbULhsGCv92mFYxz0P/wZULK+LfHFbvRHn4U3f08Gby76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=feEGuTkN; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so12679035e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 12 Dec 2025 02:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765536763; x=1766141563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSOSR+fI7c8RQw4r3NpLYa+ZLhsBLqJBsjJSCh1j838=;
        b=feEGuTkNcBH/uV53Hr7PHyAmjbe9uPSfsE7lXqwU6wUEIsHptC6glrV/JTdXxxzIIP
         fHks3NxOhvF6WHuGR0ZcGdCy/Ra901k6OJy0QZjVEyyk99nYaHIfwrL9zY0GhKscnz6L
         eOC7sYPEIaC7Z+wLoXQSmfVAWUW8IiB+jmtQTkBA+cMJvVgxBKv5uDh1VUWNBlVfuf2k
         +TDjhHa0BhLy1YaWXeINY3TiFGnvc/KBneFKwmlw4nY0HW6BGDZm+krBMnwERXds52++
         AetgF/GJLHD/Bij19cydU4vIgreLJrJKHrFwDcPAfgoEAtFgAu1osVuegVLIDZc4ETmB
         xUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765536763; x=1766141563;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSOSR+fI7c8RQw4r3NpLYa+ZLhsBLqJBsjJSCh1j838=;
        b=Sj4RervHG/nvn+JSCBy/suJJy97J5Chcl69EqQLwZJ64npp6rryKLmIP7WpQRECEAY
         5I2AGsZPcH+C2W9IqNKqBBfW6oZFWbYHe27w1oG7gZy/r8DvFbmxr/RYBH/fhIdnxJsW
         m+uKRKID4soLwVQU5qUmfRiRtgb61kr4D2kqFp6DrIldMUg4ZJGnCbApKc3j6n+ze3Hu
         IW2pFqnqTibldmBETREFHR+o68Q7LN/tvP6AeMN0QTeWUi+HvnBZbfbtkA3iF2zPFGkV
         eR9uWjSl7U0ajjuVy2y05fdIea956PbZiITgv0/p9us5irgp2WnQ9haBba+fbsp5zD+4
         TuTQ==
X-Gm-Message-State: AOJu0YyE/lj3E84Lw7bF/I57T2CvBJJWDZuRSg8WW7hBAP5bBKooLqpy
	WiQPHbL+MQwtX2Aw+0stw1DgM6YaMzVokDdnYUDYI3Ya38QXL7mlr4xdNhk95uU4HvY=
X-Gm-Gg: AY/fxX4eNJrkLa6FagaJj1+8VCiWDVfT0AmDbbAYRl1vS3m5InbUmn9sUuxEPAUrmTU
	5zeVe9yQQ0fr+okbJO2VEcXiJCAHkCJ4QFzzbEXCcD2jMA7YRJNrF/Ee6sANKqfO3GN71CSFVzl
	8SoZC38WyH/4N7rpdZ5Zyav0OAIHA4CjzWvf4boqTs08x8EoTuFlhJwdmnl3WJNkBOEPNyYYysn
	O5omAp9PjY9uNogjt2V4DKVCUF5Wbowyar0jBkOwHuJwFOMCTPkRSqR8MS6Psr/MV9TMmnqvHsm
	BBPYPE7HgMLl6A6dY6au1tHD3iy5MNxHMiSuVR+3DlLQEFhXYy1CnwXTUNMjF//JDRLnY6M7JFe
	HnK2GHZw4i5N9nHqgmoPnhWLQTYiEjWyaFz6Wj9jhLxyzO41DHO9HaeqKpzIh24hYNTTXtkRpP7
	m6CAoXKmjiVmdSypM19QsRi6Cos6Cqqb9QraosQD47tlui0YRmiAOR71s+m5Q7ZmOWHZS/m8OS6
	tY=
X-Google-Smtp-Source: AGHT+IFFw1HvvEYBiI/kzIoX2rmeoxM/1oSm9kl0SlZ4NgPnmY/X4hWgXOZsVAELTQ+VYd4BAinchg==
X-Received: by 2002:a05:600c:35d1:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47a8f8bdf0dmr19925385e9.10.1765536762215;
        Fri, 12 Dec 2025 02:52:42 -0800 (PST)
Received: from localhost (p200300f65f006608d84e70c8cba48ccd.dip0.t-ipconnect.de. [2003:f6:5f00:6608:d84e:70c8:cba4:8ccd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a8f776898sm25175625e9.8.2025.12.12.02.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 02:52:41 -0800 (PST)
Date: Fri, 12 Dec 2025 11:52:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Markus Probst <markus.probst@gmail.com>
Subject: [GIT PULL] pwm: th1520: Fix missing Kconfig dependencies
Message-ID: <ntweqab35rlrfyvrkdljo6zebaxrs4ttceqam763ozip6vhbke@inqoc34facoe>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zacr45vy2726z6od"
Content-Disposition: inline


--zacr45vy2726z6od
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] pwm: th1520: Fix missing Kconfig dependencies
MIME-Version: 1.0

Hello Linus,

the following change since commit fae00ea9f00367771003ace78f29549dead58fc7:

  pwm: rzg2l-gpt: Allow checking period_tick cache value only if sibling channel is enabled (2025-11-27 09:58:07 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc1-fixes

for you to fetch changes up to 3c180003dffbc252a72dec4f0c697e12922e0417:

  pwm: th1520: Fix missing Kconfig dependencies (2025-12-10 08:14:27 +0100)

That's a single commit only fixing the dependencies for
CONFIG_PWM_TH1520. The intel build bot reported that issue a while ago
and I was unable to reproduce the issue and blamed ARCH=um. After a real
user report Michal came up with a fix.

Please pull before tagging -rc1 to save me from build failure reports
once your tree is tagged :-)

Best regards from Germany,
Uwe

----------------------------------------------------------------
pwm: th1520: Fix missing Kconfig dependencies

This tightens the dependency for the new pwm driver written in Rust to
make build bots and obviously also users happy.

----------------------------------------------------------------
Michal Wilczynski (1):
      pwm: th1520: Fix missing Kconfig dependencies

 drivers/pwm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

--zacr45vy2726z6od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmk78/MACgkQj4D7WH0S
/k5f6wf/Tbt7eXrSWQBEp+kuTXjCmJDRltMr1k3kqmmnMvCXMTYeXhaGlC+GpXHe
ky/9SdFlOuzCvapLH8z47scxNfWDszu76cMbFPFI471thBlpMbMO82Wyrwn/2pRr
h2FBSULRsUT1ygv19ZrfLwwlnbp8HvafFVxvT13BvaMrCMlUiGLs47AX1yXARjwV
DyQm7ZdKnMPHOqneYEMd3xOl33fEssFSscScCTl7WN8aAWicNjkQ/Bk9Ym1JFN0R
9ks7TiCQd5eU+119y2fngIms50QmFMfLOviVepTlbKlref7x7tqYDvlsLJVlrrpq
0G6kTCMlQLd2zdkE5E5iekVRRa0wYQ==
=rChj
-----END PGP SIGNATURE-----

--zacr45vy2726z6od--

