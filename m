Return-Path: <linux-pwm+bounces-6858-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC81B0C254
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 13:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF51188ADA5
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D876295520;
	Mon, 21 Jul 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bd5zPxLE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF7293C70
	for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096299; cv=none; b=uofO69AZbGBqQGJhEaSISui4hPlaY5ny9yqv9hxmlUimqmNeLaqGS+6mQZXLU+EEircX14sOi9/oFtAHMOwz3QEsD4FEUozYfCBFo6to19+IMDDaPB1tCB+hjhsViVwwfCMeF9m6J+eZnN5M0klakVoKRWtno63IQ6nYfLBs9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096299; c=relaxed/simple;
	bh=pH+6OCwIBqs3/FWaCD5BihVh3R9HRu2YcpuyV9IwBWA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmMLyE5ouxgLU5BT0QPLOTYNpYjF37Gvm/cP89XxiUt47Z5DOX1zdfeRTK1Z1mglAXHmQZNVoQWUraTfewJbdC0BW5qCOvxAfsZ4rBywWrdRnaJVY9nV2vE2xS/Xjwz7IUbU+WVn8XDeKHN137eLje4mYPiWD/jl8lLiqjiLIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bd5zPxLE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so27602485e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2025 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753096295; x=1753701095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pH+6OCwIBqs3/FWaCD5BihVh3R9HRu2YcpuyV9IwBWA=;
        b=Bd5zPxLEkPCj73H3YiWVUpyxkKT7+TE9zjHG/gV7bQfikSqad9N63vjnq5PwIvdUld
         NcgtTHUd/2fxiwpuMN4+5cy7kaUbgqIvnI3gPnJY9XMlhCmWZsLVWXhVCoPu9XEiW0p9
         Co1x7MZflHQbXyZfYH4XQ07rxWCZDo27W/SpmlkX4EzhkyyCXbrxxsi8u4+CYtQOyK1k
         f4HFr9sx1BskVy87BYssafyhaRSlrSZBhZkijFdtyHXLRjad/BdGAkhAwRNw7pIlPLeY
         PudJiMNCs+hfzGgRG4ak7GGuJWP1zKlXRsExi4j9w6S8HCUyuYWChF/CVa7KKiYojqUR
         AqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096295; x=1753701095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH+6OCwIBqs3/FWaCD5BihVh3R9HRu2YcpuyV9IwBWA=;
        b=D8qh8agVLwxUFb1anN95UIKXubyV5E1b6/VHpoYnIQEEkD59JmLmrgzoMVXtuJ7eJc
         DgPza2AZtinmvBZ+iiYtyrH5tDznAL/cPOTIDnU2JJz5uY94C5ZGL8vMPCCjVrHWzLLQ
         vMNve6uxQyK+D2+T95Gtt9L7pxrnU+d2ee+SlibUM+9kVLecYs5MImj7prcdSAZQkkUn
         WjbB/gdDz2+xMN86/EEATmTPI3yDYoXfG+L+bHmQUQTr6ce/qOnP+kNThElxFLr3qaCS
         KbE+tQcgAYrxXoX3JyM5YCwyUv0ydTeVJcIKYjSXsGxx2/GupP8UN0BPpCllmQKw8hre
         GoEg==
X-Gm-Message-State: AOJu0Yy2nY3PCeKuI+a68cpHohBUckYIen7vnEFRR8I11JbHf681yem4
	MXHOY6CN8G1Wqq2MOuGZ2LJ8cDy3DdbMIPcfokZoSlCT6m/gkuHB47pXVBsFTtA8AH7VXW7q/T4
	b7Shw
X-Gm-Gg: ASbGncvu4xTvKamOPPkfQycglZ6wpVqU908cjwzwbb4or2ILU4okc8gibkvIkDQlENj
	0pH2uhUYFYI2S6XNZsk6+ImaG6WQ2v/hxsfeX0flBpJyY0IbICOuIN46hsJmaqh1wLAavT8Er1S
	OhVVemWtxadPJDFaEXFlmKAa9gDiW4dIVW0USjlCWmVS/s0ZtlIKqM43vl+yZOh961+1hH8TuYd
	x9uVfJrQVdmzwTKLtuVO0dIyvlgltAsQTSJ7uikXc9gtQxbVhuN799n36BpCzgz2L7+HLKFvwfK
	3dhPak4dx5jFR5uWP+KKIB6ptxaTB7+9haiA05KWpabfprpmGrKp5FICgffbqTRKYv/B8LkHCUd
	Y+e8NzGBBSrO+icwrj87kdoYSKzzGCKLjtkAu27gZB4gV9qWirOd9+b/5YccFCVVA
X-Google-Smtp-Source: AGHT+IEaIN16Z1XpmbKeAC3nOHnpFLtikTmWP/Te59erwEZ0mKJ6p3MjfhhdVCGUiiMxgW156qbGGA==
X-Received: by 2002:a05:600c:3b85:b0:456:26ad:46d2 with SMTP id 5b1f17b1804b1-4562e32e2aamr172741935e9.6.1753096295039;
        Mon, 21 Jul 2025 04:11:35 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca25443sm10179774f8f.9.2025.07.21.04.11.34
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:11:34 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:11:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH libpwm] pwmround/pwmset: Fix check for invalid duty_offset
Message-ID: <iknurj2ze24y7pawun6dyo46pqtamd2m5awclvcag6trymy36z@r3tnbecp74aa>
References: <20250710160417.2089742-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yuzgt57ra5fkssq4"
Content-Disposition: inline
In-Reply-To: <20250710160417.2089742-2-u.kleine-koenig@baylibre.com>


--yuzgt57ra5fkssq4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH libpwm] pwmround/pwmset: Fix check for invalid duty_offset
MIME-Version: 1.0

Hello,

On Thu, Jul 10, 2025 at 06:04:18PM +0200, Uwe Kleine-K=F6nig wrote:
> .period_length_ns =3D=3D .duty_offset_ns =3D=3D 0 is a valid waveform that
> shouldn't trigger a warning.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git main
=2E

Best regards
Uwe

--yuzgt57ra5fkssq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmh+IGIACgkQj4D7WH0S
/k5RSQf/RrXdjKuskIyvsiqLUtTNka+uL22SEXgBn9gIgiTETbuTYKe6LF4FRQ9H
n2NHCVsUFUXYjQ/KFaV+qgiX9687KsqsudPvx5pgu9X794QBKhdzQmQ4clwfJScI
0H/riUGYYWAkQGUSXKPRs1zVgt1TtGBMr7SJAcwTMyObikZXnHVXceQ2MxeqzHT0
bpgaNmAYjWh8mXOFfAetPAU8MQNpwuZJCvcpiwgyVK7g7rNqdFUigBj23cCbry0B
ZLO+GG1o/aquxP/WDy91Ttc4Bfi70GvcOEx8KFU4Iti7zZcsYNfGmzyPUbpnLtfb
Fqpcmdxij8nDXS/ngqgAl+uesh4jFg==
=6Y59
-----END PGP SIGNATURE-----

--yuzgt57ra5fkssq4--

