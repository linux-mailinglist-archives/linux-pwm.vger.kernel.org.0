Return-Path: <linux-pwm+bounces-7650-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E9C7AB40
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 599974E0566
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE62D1F64;
	Fri, 21 Nov 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yNJ5ZS+D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E527FD59
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741088; cv=none; b=P8c/GhoshMbyNsyOr5uIKB5oa2k4AdtSwC7lySDpjTSSMJBETtJEIPTsCd4vqXGhV1z82vsXVdgOINyEu/tvfXbTRnCZQoiMdpwhAwqIwmd2cXy7TdKH2dWxMW/0VuGLOHKkkaP1GyqQxWR/6m7qpjVAWOOiZrb1zQrzt0sIkpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741088; c=relaxed/simple;
	bh=6bLy5sIohAIZFypJXZj/qhQkkDbDedcXqSPaG5SIrFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DPiWh+USePx1mrDlaYGkERupWw0ZL2Suai3Xc498ohBv0hBs8MOvo+sq3+lp5lNbYOuzVi3cEcTWnzgFfG6vyjofnG6G80BoPbK+6KQXk/8JFiMdqsUne9eZSXuqbCKTX7xCk+cdeRGBys6wij6l7u/wn+IYQASzVVPtXK25lYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yNJ5ZS+D; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7291af7190so327178666b.3
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763741084; x=1764345884; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TnEOTMUJKSJLGUMKQOWgn/nUDKFfyFQcc5tt9ZaYYQ=;
        b=yNJ5ZS+D2wZVSVEzyRmk5+pD0OxfSnieKEoilxU+tsq5xbmh0XdcUKXanxxWUbkMG3
         GPgfyhKudruqhtoAU92EXZNqWay/czH+TxnHiIOH+SzYtaog9zADX/jC29guoCGRZgov
         lmXc4HDEE3/kcghCuk0Lr8+bJmXzP7ZmMaNRQLk7N0tWxcNWZbMnJqZ7oWF14tR7nOQ+
         3Oqq0DuRu6fFyBMHu9+kJkkngY8L5Sx9g54P2Gfasg/Oa3k7Th0x7XM6io8yB5zx2FS3
         vc5xvgSXaErQflSsHFCiEC1jc+lvdvaDRj5nJPD5pCy7a4VrYjb1+QY436boH9vo27lZ
         ye5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741084; x=1764345884;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TnEOTMUJKSJLGUMKQOWgn/nUDKFfyFQcc5tt9ZaYYQ=;
        b=GVpXY4FwyHfjHAFMRG1dAzmUuiRLnpnjuGMmUUQcHaa+hnLKR4+pjRhxoevUxfeJAx
         3GWRNvu8tpOuH8VdOHJttD96IOdn7FKTqMNxH0vqAKyizhDgnBXeNNgY/c5gcZxskEnw
         RDuMu0yG3C4tBOpCn0nUdyHbby7icDON0TqCbv0HX094DGbE2s1Op3xPyWdRfBjBUNB6
         mrmVTMHN+IrQOz6eDq1cLObJ5YtqXWEfoapxeJHPdiBPeeVJVlPoWfIHuPma2lCfgUJH
         PAA5/PpYpBv4joOwyLhEEw67Aj2IhNCIMacqgVuOtu9QzfD4In6btpE2+1GFpT0s2Gyw
         Ullg==
X-Gm-Message-State: AOJu0YzakIksinf85lp3mc/J4b4HliFdF5pupd/BXWKG66kmPpEn+dY2
	Lty9OsxeWi1PtW8g4u0o0iI5tvdqFq4lEOZiUMD8oh3pfdXv/fLTsVQwcSCn3ULsn4+5kl01Eur
	VRreT
X-Gm-Gg: ASbGncsUkdHB2zrXk5Z0gsvT9vprU50/72mCPW/vMgDDbwx6ttiKg5vBAWHVTwhGeoF
	Xx08KNSBY/FSXzc+ER1/tndTW5tuUMwVfc6jV7t2XLzaI2Q/cwbPdY2rVxt0jtdep4JrsOx7bmf
	i8tzxd0YLzecUhpjMOfd1rNcvuZUaAIUIS8rh6RfTG75rSW1WfK4faaZgSXeoNCMoeVFbaJVle3
	WMLRX93eHk1e85PzfxlufndTVUBmcp1FjnLVD5pZ29OdvjsTZsRDdD/FbHKUiaCec6C7AQuFlqM
	dvontJUsNurCC/8otUDYVIhZf2HItNz5x5E2fR6I938reJpyKahyWHbLEKYlR9dgBj1erNKcbrx
	bCYmwDffp5QOCmjapk07Wx2kDCLCRF8reCoP/xajX6GonaD212dT18PjLSIY6MuAAS3WaqCh3wb
	E+zXJ4/82D6Z2hkr9mfdJNksyul/P2dWi5BHoTQXjhuqgJThMscu0t2F9S/7Wl+sr8di9JzziRR
	m8=
X-Google-Smtp-Source: AGHT+IGNnPt/tENTvZRfMz7dDnx+S3e83PkusKURWnnEKG/LZusrtTZNy1b+pBxtxptorAJOSAvaxg==
X-Received: by 2002:a17:907:944f:b0:b5c:753a:e022 with SMTP id a640c23a62f3a-b767169544emr336908466b.29.1763741083674;
        Fri, 21 Nov 2025 08:04:43 -0800 (PST)
Received: from localhost (p200300f65f02670826fd414c160457df.dip0.t-ipconnect.de. [2003:f6:5f02:6708:26fd:414c:1604:57df])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7654cefe53sm489373566b.13.2025.11.21.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:04:42 -0800 (PST)
Date: Fri, 21 Nov 2025 17:04:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sean Young <sean@mess.org>
Cc: linux-pwm@vger.kernel.org
Subject: PWM and rounding for pwm-ir-tx
Message-ID: <o7fry6bjh3trqrjb5vethqq4mumg37wjnvqafjlzuxc2ynedck@nb4x43jajm3j>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zeb2hfryacorqouh"
Content-Disposition: inline


--zeb2hfryacorqouh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: PWM and rounding for pwm-ir-tx
MIME-Version: 1.0

Hello Sean,

I'm currently working on the pwm-bcm2835 driver, converting it to the
waveform PWM API.

A result of that conversation is that calling pwm_apply_atomic() will
result in the period being rounded down instead of rounded to the
nearest possible value. Looking at commit 11fc4edc483b ("pwm: bcm2835:
Improve precision of PWM") I guess you will be unhappy about that.

The obvious way forward is to let the pwm-ir-tx driver make use of the
waveform API which allows better control over the actual hardware
output.

I looked into the pwm-ir-tx driver to check if I can do the conversion,
but didn't understand the protocol good enough to try that.

I wonder if you are still interested enough in the driver to do the
conversion yourself? Alternatively can you point me to some documention
resource explaining the protocol? Maybe there is even an easy way to
test changes?

One thing that I noticed is that

	pwm_ir->state->enabled = !(pwm_ir->txbuf_index % 2);
	pwm_apply_atomic(pwm_ir->pwm, pwm_ir->state);

is conceptually broken because the output of a disabled PWM is
undefined. Many hardwares emit a constant inactive level, but others
might emit active instead, or a random level or might even continue to
toggle. If you want to be sure to drive the inactive level, keep the PWM
enabled but use duty_cycle = 0.

Best regards
Uwe

--zeb2hfryacorqouh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkgjZYACgkQj4D7WH0S
/k6ZBAf/WPCsTnMn9VFPKh4a/hIb42j4Es/ul4wB7b4bZLVQGG1ofKPEFpvcIJpo
eulC5u6bfpdK5klt4D2DHQ+zdRogsIoU35tP9qyOuVendKd2ddTnsqWq7YAB+fe6
HXZsGMY+EXLDqUlB7tr6PwkdDDjRM+N+JZtjyU1G1InmwWCoL+M/9vTf1rpSave5
N2euRu8beWMCAoCN26RP+D9qdB3nQmNpSFuPQ57QPFTnzxIEUap7jDlSCtcN9z7T
nt2Z0AR9KBF7PKtxpbXJ5xk5yy9pAQs+RACdXrMQJfRNhsOBg5EIEHN/JZnjjJmW
b6YuMp5aNbg06NrH32So2WNZ6n+RHA==
=psex
-----END PGP SIGNATURE-----

--zeb2hfryacorqouh--

