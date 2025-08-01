Return-Path: <linux-pwm+bounces-6926-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EBB17FBB
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DA23A968A
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B50230996;
	Fri,  1 Aug 2025 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C9OFPXEQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60A20F087
	for <linux-pwm@vger.kernel.org>; Fri,  1 Aug 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042318; cv=none; b=UaGxJy4SPiyyggG8iWqcJJjJ/H1oEfUqznCfaSrL6GtsJmipHo3qSRC3JCJxlriMII0fJiTyv+aBBoProwS2LD4xcHCpHysjomeMv+28mqkjxbgyC7y+LNlFLOiOVThpdt6Zsq+kqxsxc56MmzjGB7Z9xgKzyFqpSIqOjjsewzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042318; c=relaxed/simple;
	bh=67HM9GltOCKjRrdMu3scBfndanIb46dCLTQ9vJk9rQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJItmyaWBJDoOLIJRujKzJVtwFDAr4LLJboEkIqHXTKvQPNL67MQoDoBcRBlzO3pabzQlmcfjwhO/5nm5ipFRw7xGdDgaq29RsKvBHc9N7vJPHhOe9Xd+/JJ7R2y2hzfHRG9FWCK0wcVunYmJxxA34qX5OP7od7svMHtt1cNgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C9OFPXEQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b00339c8so10602225e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 01 Aug 2025 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754042313; x=1754647113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67HM9GltOCKjRrdMu3scBfndanIb46dCLTQ9vJk9rQM=;
        b=C9OFPXEQ/EB8UwM5HSWxqS6W2cWCxuuAbPc+deEgqiuk3PEqBH6ct+1ulNQQSCP0Ln
         naJVtPCQzepwg0WxtoPgPvBtyHlWXOjxAW3xF9DehsYqUk7XMK5uxm96c3qAJCSE42Ch
         PfjpowtQ4pN38golUbQaaTpav1e27BC4u7+6z9oFxXOhlgh6s+a9Ma7A+VSOD9IE0ihh
         49b7r7FZSonIbbZoIARE0hmwXehGwK+kuAdZO8yWjjnNo0Sd9+O6xumElTIJ6GCCaEjl
         MmJclOU36QnMLVvlTCHerHv5r8HgFHYeqKT9cKKshULe6F1+8tRrwh2r+5pK7ZJnnSkn
         nUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754042313; x=1754647113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67HM9GltOCKjRrdMu3scBfndanIb46dCLTQ9vJk9rQM=;
        b=sdRkND54NC2r9I6WGxkqUAF8ThnKYGMjoAoman/RladY7GOKVlJlz7dJiV2ZbdM3l0
         zAF0MERNGXZej6fl2+41Qo9T+JOIR/hYvjatILYaRf8lp1lwcx+Eidc7g/B3YJt4U9/s
         h851Lhw5dqgHX57Ln85WbqSU3QVi9Bk2EkXPhECKIpGn381BrMYAvZmzmgWMYQWwI7LC
         aG4tNNCrqmdtu/niVd/Y38nvCjR6lhvdK7YcjnINLPzjTCmceYAfPZWSLuAyATT9N2IX
         MZtnL9sFhEiUxWry8acYOdQeJoHHjz8RvuzjUvlKYlk38LKgi3w/bYfbAswiWytRfKVr
         f2jA==
X-Gm-Message-State: AOJu0Yx6awZkUUiiWDTtnumK0r2PZWIvidvFf9UIpLKrDUFfOiD3gCxo
	nXKvfpVJCOgGDqWcMTuBddCeh20KUtGlLaKMDae+xz1GP3D4q20YJjE4ZLAZ35vS3XCNHCr5zKR
	idfn2
X-Gm-Gg: ASbGncsIYD2TAovCxrirfjpyNxckEWcwk1SgI4DJ9lsCF95n3eGlCVr9zuTrryiDfD/
	NWo9MOz6ASgEuGvt9aLhVrBddJBQwLE45/vQ45P6I5qtWhGYcLHb3Jx32WhFsXHVJPfOP3Kz0lb
	6j/xkNDqe7tHBVODJi7kHIi/Bz3hr1OjCJlEoRz+iYDybSLYoXVq6u0Ui0hjTeca2/kw0XGggZC
	TWgPENRUOmhkMX4yCyJmUjtUR8ss82Nawh0OPI+FbEVKBU0OknD81tICKjHlYc3jMeOdPuGks2k
	+jTCMIAkixOT36idPiY+2TeLd4149vgwG6GdYtd8NnVjFKxtjTJuwoPa0nOFiYX+0oz59vv+nJR
	6Ozr2oobfY9HtSdXysDiBRHBfGQgFkYXBoEUVGC3/6ZcnU74EHpLrAbS2TlRVIIp8r4mx7SF9La
	o=
X-Google-Smtp-Source: AGHT+IFt3YhHuk534hYe+cy6BYJZHyFop+ZIhZ/4RMb68y0cPReseidwj44kBmLaO8MkyzE0zgF/PQ==
X-Received: by 2002:a05:600c:154c:b0:456:76c:84f2 with SMTP id 5b1f17b1804b1-458aa463272mr20488285e9.30.1754042312675;
        Fri, 01 Aug 2025 02:58:32 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c470102sm5302291f8f.53.2025.08.01.02.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:58:31 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:58:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Clemens Gruber <clemens.gruber@pqgruber.com>, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] pwm: Provide a gpio device for waveform drivers
Message-ID: <yr7eydif5mguqpflydthhigpsenfum3agqie4wufbf3624tvjb@3kog3guxiwin>
References: <20250717073859.1777226-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zlsoaii7lwlvyrik"
Content-Disposition: inline
In-Reply-To: <20250717073859.1777226-2-u.kleine-koenig@baylibre.com>


--zlsoaii7lwlvyrik
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Provide a gpio device for waveform drivers
MIME-Version: 1.0

Hello,

On Thu, Jul 17, 2025 at 09:38:59AM +0200, Uwe Kleine-K=F6nig wrote:
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

as 6.18-rc1 material.

Best regards
Uwe

--zlsoaii7lwlvyrik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiMj8MACgkQj4D7WH0S
/k69Dwf/W4XRoRGYdSrSav3aZhqvA+sdmXVwgGvnbkSNY2j9RyupFfYQLdNBnlLF
CYlxtQBNQFwcqKWkZcllStointVVjO8WlYeQjY2rbs/iCm8+EL4CMXGvjrRUM5Pa
mszLSooueNPnAZ1+uLDxDkwhlkSrERJ6vYuYeIlz7ZgiQQniG4rr0+ggxq7AhrpP
d0o1Z2PWL5LrRvNcIIGg3MDikC63kb+lATkg4A7p6ctvwt8ShSB9NNGNSdQ5c9vo
dVg57WiaP0PuWBblWeoFRxsAsei3aMCVKYdvYlSap3r+g6kh26eJ9thMUvzG3qs+
ZXohWbpv+8GvFW2dpvgnXNcvy5T0WQ==
=0UvM
-----END PGP SIGNATURE-----

--zlsoaii7lwlvyrik--

