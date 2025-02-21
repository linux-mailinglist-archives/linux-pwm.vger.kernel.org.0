Return-Path: <linux-pwm+bounces-4966-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A503A3F057
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2025 10:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE84175D53
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2025 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DA2036E3;
	Fri, 21 Feb 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="chEgiNjG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4871F4299
	for <linux-pwm@vger.kernel.org>; Fri, 21 Feb 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130393; cv=none; b=beEwhlwcM2LH9GqK9WdWmRj12E78vraEOSqq4Qvc+cmloH3dJr4hQt7LxhI8nmmi6Z8mu3XLm/6Giei+22A7rxHORumZcd/6yXUzVAyxtGMqXbAebsEc+ftPlB5xdlb9pHDlH0HJ5AO1T39hUFGkvDkgv+T7+Qlz78i03b2aa94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130393; c=relaxed/simple;
	bh=NGg3p2v26vAbcIHMvbB45bNMQyP6Fn3VrhfSKVoSKh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4ymqEL6xEQIUgWrzITVKoy77ALT7bxchiRqmKfNQqRwtwyvO4OVAPHMhLYtnpFpRIWJJfMTMVLIMn3SbxsNuA2yklnB4DGLWodxg4EvMaNwfhx8LQgjPSmQoKoG+4NsrtijNkVoMVbBgLYuVNNGIFQXnxB1dMl743xfppKd1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=chEgiNjG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439950a45daso11523525e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 21 Feb 2025 01:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740130389; x=1740735189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGg3p2v26vAbcIHMvbB45bNMQyP6Fn3VrhfSKVoSKh0=;
        b=chEgiNjGRHa9+xBD9Yh22tEAQ0NidzEzFhyafjKh/FDqFpV2K3rPH2GgyJn7pU+JDX
         JFZ0lJX3Hb/sTHM7ZHkhnailidcz3u8MuLcj2eHujfTLIk5aLdRCBcSJJ0fVzh+KP7td
         120wKC2lSsGhTm6JIO0Xqaop3sUdG4+V+ezzbcEzcrZums1ydCzKuAygtBhd6jKmkoUP
         YsxZdOBj38AsMrZoILWX0GIsDe+l8SLi9peR1dhQQ5qXaTtTDV++1/1YFS/pwRV1PD8x
         +HLx2p9FamUb5bBI6yqBidFYjKE4uABfHPDTkGozGprY1fmW+Kb7/vR2ZxLn0OgQgzQX
         7E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130389; x=1740735189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGg3p2v26vAbcIHMvbB45bNMQyP6Fn3VrhfSKVoSKh0=;
        b=p0ai6PzkGPWfsjhmNGwVpwp1rxcXmEFvQbbN0emDKDx5th4icQ3BWSxjtAw01AA/oA
         SoHMB1HKBv34YNsYEHqePHL9MrTA2OCru3pPU60kmqrSeJrM2hY7EMq27B4XaO8jII+E
         k79jYLPsoSWg+YKBkyvXHLpVjU/vQjfkDcRXRYL/ztzhSD5z85YH7UtrquwZBypg0J0V
         CXDTx55Y+erhV+4yxK39oCQm5rtDbwhsfAx/xyYjMawWfVUEkAOqac2acwWrIpeLkgX4
         uVAC0Mv+pxzYtCcfgb7Ml9hNObNCrSVIvp3CpH5rStsx5dObpOCmKrYVWTjuKRhNnwV3
         kZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7bfg0/g/BUMzG30kWAV8rPbMVwGUZBM3dxAsjA9TOjrrxtYXpf8zI/eEr4jABDu7AfiLrrjczJ6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCT/7BWH29orON3DWZ23F0dy+oaqgdZADeoOs3yBgu26mGyuz
	BHoQbCpf2mdbyv/ZmFR5v5nFccoUY6lJ+DjHozS4BO9yWorfSPZRBzhnQaA30hc=
X-Gm-Gg: ASbGnctjv9fEaNrwb6+exeaT2O53MHf7exe9Ks/FEzcYf3tfowRWSt+MOT/4jj6mbOY
	or9Ev2K7M3Z4EL7B71LOQ4Jpp8X3avMsM+RE1NpGcsWvkur/J3PoX7j1wVGSVCTh8zhrchRuzzc
	0i2u+Ql2N+KzdCsJhruS/YA+5t6vbBYUKsruits2695Z4YpjmwAbLws9Jz4CNm8deECY25WTe7E
	PdFfYE5smRo2NDNyKB1Wq1y33fKkd8DyobHRIqTWy4Cz3uTxqXmrQdCMcv98f6Bpsot9B+vU5CB
	4dqXrT3Q44RSKHjChBy19V3tLK0ld9qlAD70Oh2pHPgPhj/i5UZU9SOsLe5wXQm/G1DN
X-Google-Smtp-Source: AGHT+IGt87vL6VHtDibcXnn7l4Vot51++YIbIpXyONWhhD00l415ZfN7rQ/oDaggzOuuyoMOkbdTPA==
X-Received: by 2002:a05:600c:45c6:b0:439:84ba:5773 with SMTP id 5b1f17b1804b1-439ae225a44mr19266235e9.31.1740130389494;
        Fri, 21 Feb 2025 01:33:09 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce685sm11635085e9.2.2025.02.21.01.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:33:08 -0800 (PST)
Date: Fri, 21 Feb 2025 10:33:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Michael Walle <mwalle@kernel.org>, Bamvor Jian Zhang <bamv2005@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 00/15] gpiolib: indicate errors in value setters
Message-ID: <ms373jlzawhooi5j25pvvubu5hu2rueatglbdnils7sbihxnpz@5f6fbooiusf5>
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="et6dryar3l656eqq"
Content-Disposition: inline
In-Reply-To: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>


--et6dryar3l656eqq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/15] gpiolib: indicate errors in value setters
MIME-Version: 1.0

Hello Bartosz,

On Thu, Feb 20, 2025 at 10:56:57AM +0100, Bartosz Golaszewski wrote:
> The value setter callbacks (both for single and multiple lines) return
> void even though we have many types of controllers that can fail to set
> a line's value: i2c, SPI, USB, etc.
>=20
> For the consumer API: single line setters return void. Multiple line
> setters do have an integer return value but due to the above, they still
> cannot be used to indicate problems within the driver.
>=20
> This series proposes to start the process of converting the setters to
> returning int thus making it possible to propagate any errors to the
> user.

The lack of error indication is something that bothered me already a few
times in the past (but never to hard that I invested effort to change
that). Great that you work on that.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--et6dryar3l656eqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAme4SFEACgkQj4D7WH0S
/k4l8wgAkzdhPhGUsAivrDz+n9J2/GJfIld9jGOHEMMiMXR593L37vPr+fgTTuRK
NBrq56VRF5fy5rSfW25/AgTqikJ+z5Ne0i3aCntrNUnDxScKBQnNfUH/kQv1hFej
BsDgBPjTnwj43F3dOUzAQVfze3ZSPheoMuFt+Tb+qAh8gxJP+X56ozXbqW0Y3oCm
FJN++pH14aEFIw15p0ZWTpTg4EyKcGaNi+T8fWKHxnApkrgLdrXuzlEUpJ6XVIF5
q1RO8aeJj806zcPKSlagH5hiepRn3szx07dT13KAAXqafFGpRWOTKK+c4FYdH/Ri
phzUXU5/DjxMEa27RJoRC4oxUAxQHQ==
=U0AB
-----END PGP SIGNATURE-----

--et6dryar3l656eqq--

