Return-Path: <linux-pwm+bounces-4522-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23C9FD1E8
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 09:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7FF7A01ED
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432041531F0;
	Fri, 27 Dec 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LvyPPYYx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8E14AD0E
	for <linux-pwm@vger.kernel.org>; Fri, 27 Dec 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735287628; cv=none; b=gNlWv+sGuor6GguMyPFlK0C90AxJNh3tJNJYSKLoTkCypRO3IVmYUP0ZbGj9ruPAxRRqZpEbxlPvG7QBjb/LvF96BcIfIT6NPEL8/jpqQ58RcY+HHQ1THB2ADDyjeOhmKSQnvHNRRzsuflmbed0rKO70qHVBTPyBkgPmDPsXOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735287628; c=relaxed/simple;
	bh=gjZyma2ZYER6csroLP4LBLybl+Rt0XNSkVRP7WNrBHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3UYMeJkT7TOg1ihORuxLzuUuTLxB+RvJ3ZPn20NqMx2sxUkvyMb/FhbReHGafjlgnizg7waCvGpSphto5O9LYA1Yd/OgtTY3XYeEsSRmo5bc4xz7X7kJXmWVSVQ8FPU5lF2qiFI3HT6aLijfG6D5dXxzbiyNBgSR2ATg4+fx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LvyPPYYx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa696d3901bso536496466b.1
        for <linux-pwm@vger.kernel.org>; Fri, 27 Dec 2024 00:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1735287624; x=1735892424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ymnkaFSKoa88cBBO+Aw6l4UGz2gfKbnPeK/qmnKF3M=;
        b=LvyPPYYxlkPjrgJOGO6GPGmG/0CNSgwte5lVNDyVhDMMPQMKA0kRZxqvt0d+GpKZEF
         9GZOzll7Uhl+xo2zBdCinUn+ziqT28f/94lXTiyC0mcwDymCSNHUFUPwfVNodiPa6CZT
         9Pot1pqeV63cakqRVUv7FvFIbWVENG1VgtMus015GvE0GH+CSkRENCabkXj86p5OZZZ8
         z1qUMmjs8NXeaZRe1Gv9/DOTZoSS4vYnDp9bWUMzTMONomH6gnmRV4GeH6aH55svSmiA
         sQlPqfJhYYqxJP+Pv09ihYtZzVIWxLrESm2LN0LRmD2WvjMdPgmdhFa7VRTqZBkE2kW/
         iPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735287624; x=1735892424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ymnkaFSKoa88cBBO+Aw6l4UGz2gfKbnPeK/qmnKF3M=;
        b=lpvd2kv2UcskN31vzH7HTfhLCYWWYNdzwgX3H/lqldwqP0qobLhHx97WMxRCQElrUv
         lyOf0EwIljZIb76RteJWFeyq7oah8r9Xqz5lmmWNhGaIwqNU8fT4PfXYPed9KwjXUlr2
         V7OkCOuz+Omv2YPfSoZmFyVg96xvRvUGxXCbx8g6+nBmmIscOzyE9GA8TEmeWRQQQMN8
         CbEmyPzANz4xudjlj+iXi4i8IGQJ0/HOotkNmEr0VKfvJoT+IIDQwgrxJDa7vWwf04cs
         3Zm00ApKXWHpKOrWuxIQuQfe3H+na8ILnitsqynLuwXSZm43DNiLOLRiLGV7uBuaqDqs
         J2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlyiZz79tyovelPtr/Vq0Aq9gJGtslsWw7ZKByLcXWezHiZDlzjqwrpc8uBZ2X2Of5GR8SnXGnSWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoXC364Gdf1eEd2kx3rQaxJmwHMtX3oQIOXRJTlYo8PU7Fzi2
	+Nd+QPihUSruXQuOBVv9Hjp0trvFmH+tq2ZtatolUMSLBtxWGIT43Dzvl6aoN08=
X-Gm-Gg: ASbGncu+1iZQY0yvhoc9qORq0KHUw9be/kChlowXxloM6mA+Sz3jw01xD96SIqcFT3v
	txBZIgGmL89D9/EC0wgenfDQCAz/mcmKlNkDpI0sfZtYA8jkdC5Jc03wbAnylm6fgt7E0NRd6Pt
	Buxd8HLpYerMl4hH/Sl7nuhbME2O7JrWnXh2NC/aRbJRqL41FzYZSQiTQvlz5D3QjtnXV4EyEsq
	aee+BxTu/YKlrk8rM73icZ36fNbXbjfi+zQ9YX0xlB92vERvFw3avJGl+Ym5LpgIO2jmf5/NpbN
	QnlNP4nQWA==
X-Google-Smtp-Source: AGHT+IHuzMycdQyfPrvUmgREwzA9rbFsJHptvmQJmTsllJlTLnfiJ98OYmXuSGvqenqvilnQMWt6pA==
X-Received: by 2002:a17:907:1c0b:b0:aa6:7933:8b31 with SMTP id a640c23a62f3a-aac3352cef9mr2027761766b.46.1735287623480;
        Fri, 27 Dec 2024 00:20:23 -0800 (PST)
Received: from localhost (p50915bc6.dip0.t-ipconnect.de. [80.145.91.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895366sm1072502266b.73.2024.12.27.00.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 00:20:22 -0800 (PST)
Date: Fri, 27 Dec 2024 09:20:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jxfkviocdptb27ky"
Content-Disposition: inline
In-Reply-To: <20241224093902.1632627-1-nylon.chen@sifive.com>


--jxfkviocdptb27ky
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
MIME-Version: 1.0

Hello Nylon,

On Tue, Dec 24, 2024 at 05:38:58PM +0800, Nylon Chen wrote:
> According to the circuit diagram of User LEDs - RGB described in the
> manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf=
[1].
>=20
> The behavior of PWM is acitve-high.
>=20
> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual=
[2].
>=20
> The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) period.
> The `frac` variable is pulse "inactive" time so we need to invert it.

I'm trying to understand that. You're saying that the PWMCMP register
holds the inactive time. Looking at the logic diagram (Figure 29) of
"SiFive FU740-C000 Manual v1p6" that is because pwms is feed into the
comparator after going through that XNOR where the lower input is always
0 (as pwmcmpXcenter is always 0) and so effectively counts backwards,
right?
In that case the sentence "The output of each comparator is high
whenever the value of pwms is greater than or equal to the corresponding
pwmcmpX." from the description of the Compare Registers is wrong.

With that assumption there are a few issues with the second patch:

 - The Limitations paragraph still says "The hardware cannot generate a
   100% duty cycle."
 - If pwm_sifive_apply() is called with state->duty_cycle =3D 0 the PWMCMP
   register becomes (1U << PWM_SIFIVE_CMPWIDTH) - 1 which results in a
   wave form that is active for 1 clock tick each period. That's bogus.
   If duty_cycle =3D 0 is requested, either make sure the output is
   inactive the whole time, or return an error.
 - With the above error in the official documentation, I'd like to have
   a code comment that explains the mismatch such that a future reader
   of the code has a chance to understand the situation without in
   detail review of the manual and the driver.

Orthogonal to your patches, I wonder about

	frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);

=2E Round-closest is usually wrong in an .apply() callback. I didn't do
the detailed math, but I think you need to round up here.

Best regards
Uwe

--jxfkviocdptb27ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmduY0IACgkQj4D7WH0S
/k4hLwf8DsoYI030gIP8IMTk9dgJdMG1D9J4fZJzTF3l7KOC2eyw0OZhH24H0ErS
Nzmepa8T48/V4wFWqVZ00Zv5JI21c+i+8v0Z+ihxTZDgtgsnEvseEYGDeRVkghaM
Fl3JjlknakL717HMTHLWkJFgS6Hm6VGlKJkinsyb1StbG9hEIP5cvcm8g/bKkfkV
cZsxboyTFSOAXpCQokSpuurM8kl9uyXfXLXhIKPj5j972SMqS7G5BB61MSktm1Cw
1gAH7Ym+E2f7DfqH+ebInOB7ErKsLJCM3UYSWV4OF5AtA9nit4Guc1FTZoEnzsv5
+paB1cp9aflfh05vZYS9tAXVt4tIYg==
=hGQh
-----END PGP SIGNATURE-----

--jxfkviocdptb27ky--

