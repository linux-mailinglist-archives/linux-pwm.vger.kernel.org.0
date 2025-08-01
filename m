Return-Path: <linux-pwm+bounces-6925-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19392B17F51
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 11:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EDB1C8147D
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0E62253A7;
	Fri,  1 Aug 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="az/T6/1K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CE226CF9
	for <linux-pwm@vger.kernel.org>; Fri,  1 Aug 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040669; cv=none; b=OccDZpAMZ8oLZc+BZ1FpGqs+EUd0iW3QI9HkCTdLSFLSbMZapZ7++666KIei0bc7cQjmymk0Y4pCZ9ZqeTqaop19lUZEy9zdyBIsXR/V06n41teZNiny3w0rrdmvlyzw2BLey9APD2TAQcrAd5blon3MeVspu3n0RXkxMHseh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040669; c=relaxed/simple;
	bh=FZWJASLtdk2/SbSM8D7q05Vi4kiga5l2OeIJuR+p6r4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR11D7sVqFSd3zNfo9WKnhKij0GNzoMt/ZbNxkp9FhQvSr6eTkUqCej6sbrZvqwiQstLxoYHSt81J2Kx79R0BvLUhRIQsWmz+y7ZQ1Kud6HbcNVWAA7TH5lF66bpystglETmlCoa8FwaawsirG6YhhRPgDHWmPw26EPgndNzA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=az/T6/1K; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b788feab29so850536f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 01 Aug 2025 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754040663; x=1754645463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5f7OR8aJerv29d0bFL20GKjSlgrFL4uMAdpdIovaDzw=;
        b=az/T6/1KoeR/1DZ9WAHc9M6mp/Fu5jrB+ZcmTCama2e5XJpXIXjPHlaTrZay2N8deX
         pQrdIOuJgTUmI3AA81yll53JSwK7H1tR3G8v5AuGAoLi/WmINo5yEbqSyOGHWp9ZV8CO
         vpAIxSk9cvRzwvCoANYsVdFEXix/3Ok9Nx8Bsddk2mISmiYpL6MZ2o1RqgLrgVIFghcv
         7+SeriF93Bm7csNIAWuCv+2uWnHKApOauJEApfxs8LQd5TO18Z6E8Z8+1Vz/o5c04/Oe
         tmXmPK7iHvMJLeP8piR8aTJELZYwx91Vt7hJe1bGwPURopFKIjqoHDZ+hO2ZFbPxyRUm
         r0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754040663; x=1754645463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f7OR8aJerv29d0bFL20GKjSlgrFL4uMAdpdIovaDzw=;
        b=aMH/KhJEBC6N4OgKDrsQ2M+3w2waXxEQlRS/dC7p/IM22+mWbhgveXsrvddYtJUkR7
         SDJon4oSqUxdKy0KBWYB7ujCvlMOZzd0dBeqj6VCFd/irHfSlbztU6IUiOVPOnRaCA82
         A0hYN/KekDueskA36hdRCJkqDLGLAznM0p8ogX3RvVTuNR5bx7S3OW9G0CP0IRxSObUS
         HiIKApY2n4SmU5x/lk66tCBUSpdP7n1oBNbJJ2i3+X+1nF1N8GttrEK+mOxqpKL10noi
         kVIOkjoWkWhJ1hQW94QrDFyEwbZ+q40vvJTM0r+tRZFBeX9HFgfLzSkTY4ESR5mxdG8y
         Ilmw==
X-Gm-Message-State: AOJu0Ywrea7Utnt8pdFuxEYuO2uo2CxodhqPKGeysgqaip1t5ACJ5JWb
	d+0D3cf865s1C/aDybjSFYSziUIF5UdgvYX1FvEh0kEyIkdLpqTHnweR43BPUNUkEl9KmIAGdaO
	DtVV5
X-Gm-Gg: ASbGnctjLR9Sj7LdTf97Lg+sx59dn/8U7XkLvLrRPus48gidVg+z1/y2Mr/HqBk0oER
	+e8N69bs8PzZFsCZVTo5iXeWtgIPidMXBUeHy5rTuczheXcjZlm/bv8mdGtdkyg/HWtUC2Ka4Zz
	+cnKmlukt2ZztF9KDAC1QYZ5D77vW26AUew7YWtPjVkSarpwhwMoR2hCdhl7aDIBmvkX05jpGve
	t4z8YbJu90qJ3hWrYQ6x9JyCWmCw02K3SvBCbVw2Z+/dwwrdqHhm1zQ/j2Iy0QB4AUSYnpahQsc
	WghSzDHcDfTfxezq0KHGHdakMKFVlcca4DIRw4IcPoSOMWUhq6LWqkVJ9nUC1B/lb6meFE9wSIn
	tX6e78Z3dYoLW9lC2xKUmsxJqSIp0gYNxYqnEAjOlAt0Kpmj1LIHsWU9phzbpYa0p
X-Google-Smtp-Source: AGHT+IHPIa9CgezeNvVng6FbHLzUzEAy71xoAXCXv3lXbXA3vkBrHWB4xqPX+IeCS0HGb74HhujpyQ==
X-Received: by 2002:adf:a1c4:0:b0:3b7:95dd:e535 with SMTP id ffacd0b85a97d-3b795dde614mr6081323f8f.42.1754040662890;
        Fri, 01 Aug 2025 02:31:02 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3bf956sm5370925f8f.24.2025.08.01.02.31.02
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:31:02 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:31:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] pwm: Improvements for PWM_DEBUG checks
Message-ID: <b7tnxtqfdv7x7tv2ereck4r4ud4mgtkfbn3ga53eriytgd2d33@n7d2lnxoitec>
References: <cover.1751994988.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6unj6bucx2lo7ycl"
Content-Disposition: inline
In-Reply-To: <cover.1751994988.git.u.kleine-koenig@baylibre.com>


--6unj6bucx2lo7ycl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] pwm: Improvements for PWM_DEBUG checks
MIME-Version: 1.0

Hello,

On Tue, Jul 08, 2025 at 07:17:59PM +0200, Uwe Kleine-K=F6nig wrote:
> while working on the pwm-mediatek driver I found a few corners in the deb=
ug
> checks that result in false positive diagnostics. Find the two resulting
> patches in reply to this mail.

I applied this series to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-nexxt

as 6.18-rc1 material. Will push it to pwm/for-next after 6.17-rc1.

Best regards
Uwe

--6unj6bucx2lo7ycl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiMiVEACgkQj4D7WH0S
/k6qRggAkI38pOpEUO044D3OHGfJx0Piglu131i42dAIPBNJ38u2rSitX0icJCzm
2A2MQ4EFN3PruS6t4vE7XfUgbG93weQhPpQlozJpn/FE79KJUq6HInmh5pbqPvVW
bD5Uen/hzgFrw2MYLC8jXGuw0Ial4c6XKE4UE7IyX2W45jBXQo3fO2No6zyQAK+F
ZdPtXd/VKuebWNMv2dyTqE/rW3T60rUuvTZtcVjwW6+B07qDG71JUkLsiT+3qXgQ
DFtBC79xfBT00A3xuof6bqQ1LzDoOtwgS+N8H4vWPkkIzrCs8GL/MIPRej4wqGfM
9gFoRUMr7LBsRXjqjK7wOPy476EzDw==
=UfQL
-----END PGP SIGNATURE-----

--6unj6bucx2lo7ycl--

