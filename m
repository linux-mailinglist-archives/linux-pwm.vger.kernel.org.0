Return-Path: <linux-pwm+bounces-6928-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C9AB17FDB
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE89018906E2
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBF221D00E;
	Fri,  1 Aug 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KNyJHTzI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0575216E26
	for <linux-pwm@vger.kernel.org>; Fri,  1 Aug 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042605; cv=none; b=gKqW2yqQKt1852ga2ebbuQJPX2feuWOSwSZTDT4ldU0A4hjKzhW1k1LE3ln8GIsVMC4C0LXzwqGqHz1ELjj1fPWc67jDwiG+omdSApTtr4MBTiWw5h9Le/KK+RMwjudS2fC3koVUEJES6e4eoQ1FCcH/4fItTfT/yUl74E/w8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042605; c=relaxed/simple;
	bh=eIrZnliW3QIEr5l1gdT1CBF75w/kF8GLk7GcVhln6e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIsFsP1HXcay97tMi52FZR4rSJcrjdKbihASNEjgelfIZeky93ABt+U18VQcgAVOPaBZIiHqr1mKJ+sPdU6XfqCRPlq61JITmVTHCPHfdU7dUjKJSasYjg/Lfnu009glPgN/mSlrx9w+uoGHwdft0YDc4ZiR9J8ICJq4X6VK45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KNyJHTzI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4589968e001so11317605e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 01 Aug 2025 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754042602; x=1754647402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIrZnliW3QIEr5l1gdT1CBF75w/kF8GLk7GcVhln6e8=;
        b=KNyJHTzIYyuya7/3SzYfWg8KLVnJICzzkX9FefMJg7P4+5PAo+EiGP/Gh1ad1xT61R
         5K16VMEotNFpA2JlBwiZ3Gc1/fGEqBT2i9bre7fBn9SW9k/MlDucvrtJO3L6glafnVWE
         42mXi0NUaRsqsuWhOjLP8dx5PGN989X51Hynn1KRSW6sez2GgOFKbC0cYSbPlmzCK/IW
         o8A5+5mckQtm5IJUabcrqA20AFcd6SuzaVMoeEzCItBcJ0KaponNdYUeBKOOyH7FvjAO
         QnZsr2Y9nELFhq99NduSnszQvJlFOUH/+fyIbfwDcl4bvd+iaMKAfKk1AlyKF9IJiztL
         pUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754042602; x=1754647402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIrZnliW3QIEr5l1gdT1CBF75w/kF8GLk7GcVhln6e8=;
        b=AgUTKkcAUJ7XrA+XIuEE6FyFU4KKkbDL/xGIYb9eaBQeNTIn2Wg7yLqZbQf6oKsOhS
         bXXV3DiJe3WmIdy4vPKbphp4g6YASz5TOX2AAYnCyYP55g6SwXJfikoriPrWNwpKBeZp
         0iVp3OzZ+4RZkLFBuobhd6w7bZ/mmXkPbylzU9LsUPYaX/9wXcE2lIaPFt/7wC2lPaZs
         D6W0W3DFLEJU1oChmonIMMmubQQctbKWwEVdCSx1vNYjwT3YE4E0UX7n31UN4xGn1ihu
         f1Sw/SnvgETVKkqZZkCcSKBChp89tF7wECrPx3T4EmWc+gVxRqrCvow/MJBMvcVTX0lm
         V3lw==
X-Gm-Message-State: AOJu0Ywab6Q6izhAJ3irH485Jpq/zTOlFNvZtn6QA/x7SUs2GLlV8aJg
	lzE84UkPYRqlRpCjfdukpdJW6l+nFDcIC20PzShfDKhNJQ8x80S1UhuYA+LgIVfqGNoMeCz0ECA
	pB1KV
X-Gm-Gg: ASbGncvLBQVy8s9FPGWPD1mFyO8uXtDkpG+HwIrc72lKmecW26C5etGMM0rMabKfbZ+
	3chLT9KOu7mpa36A7j3I01TuYrnp8hN3mSXMFLhuMlRsdPknP3el2+VhFkuTGeXBpr5Uq0RUjxY
	NQCwwDaXhDZtGHsNbWKnCI2Hv7Y3YiLi3lf7r+V0eIJXEz0k2aawm7OEOdz1fWVzMUkL4JcTiA5
	Id7EKbU1Id0i6Ox+j0xil7qrwJzGrpkMkaZzhbAmP7cpR9SVmG2mNlS8hQqLyXFFwKxb2Zp5GB5
	xeX2sQh9m9wIbniCo8X3UzVcpBjwBX7CitgSW7IvoqgX9tpmAUv5tPR5/FZZfr2Bei0cBBZGfSU
	S919EBeEqmIGSVSP7xYWLY9VLOYjXMI8xpBiR/iWaHvCHUq1hwWMfUTfMv+4QMUkU
X-Google-Smtp-Source: AGHT+IG67Ewh7sS5pb8O9k3sycQCIZLSNlxo1qxvgoWQaW8f/hn9314Q1eBJTyM2e04rkiXvi0jDLg==
X-Received: by 2002:a05:600c:1d25:b0:456:1560:7c5f with SMTP id 5b1f17b1804b1-4589a700e05mr91893355e9.14.1754042601496;
        Fri, 01 Aug 2025 03:03:21 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3c4d02sm5239526f8f.33.2025.08.01.03.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:03:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 12:03:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Clemens Gruber <clemens.gruber@pqgruber.com>, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Provide a gpio device for waveform drivers
Message-ID: <533s3ekqhn2lbk5j7xkwfoi473lkl4prpr6bc5qjd7vzawlmqq@tevygtxqobzv>
References: <20250717151117.1828585-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3gdvccb5c3frwtk"
Content-Disposition: inline
In-Reply-To: <20250717151117.1828585-2-u.kleine-koenig@baylibre.com>


--h3gdvccb5c3frwtk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: Provide a gpio device for waveform drivers
MIME-Version: 1.0

Hello,

On Thu, Jul 17, 2025 at 05:11:16PM +0200, Uwe Kleine-K=F6nig wrote:
> A PWM is a more general concept than an output-only GPIO. When using
> duty_length =3D period_length the PWM looks like an active GPIO, with
> duty_length =3D 0 like an inactive GPIO. With the waveform abstraction
> there is enough control over the configuration to ensure that PWMs that
> cannot generate a constant signal at both levels error out.
>=20
> The pwm-pca9685 driver already provides a gpio chip. When this driver is
> converted to the waveform callbacks, the gpio part can just be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

as 6.18-rc1 material. (I just claimed the same for the v1 patch, that's
of course bogus and this v2 is on for-nexxt.)

Best regards
Uwe

--h3gdvccb5c3frwtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiMkOQACgkQj4D7WH0S
/k7eXQf9FCeXmZ03f/m0sClqsbYpAQ+XoPqo5A4dD/7XoXQSg1uS+XrbBYD7HiOS
UX81viHubCkLMWXZ5+pdGhyDujPzdgU1yitx81mOCYB/Fne0i+rjFw9AEJnvQI/I
Sdwky6KPoQsa5nXI5l7tAMRkC5AodzYcGw4E1OHHBp/hhNfjatsT8UCUU5q4S9BO
+r/TrOzNFqkgVPt2fRyouE9imzMy/MzKw4WdNYAEUSfLEen9VU1qV3ShF/RliPnl
kEQZY5DvzrhUfTaqAOFMehVJPugK9xIfwsMWfSrMFedDBaXTwgrtQ7WRwuYvOSbV
jxiEIOyUr3r1BRmQmlJ1YfyaoQy9Dw==
=O2A2
-----END PGP SIGNATURE-----

--h3gdvccb5c3frwtk--

