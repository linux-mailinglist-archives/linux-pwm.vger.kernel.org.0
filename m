Return-Path: <linux-pwm+bounces-7016-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C9B2207C
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 10:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EFA68571B
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7B1ADFE4;
	Tue, 12 Aug 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SKBwReyO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6562E11DD
	for <linux-pwm@vger.kernel.org>; Tue, 12 Aug 2025 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986513; cv=none; b=XMYP1bkbZ34FUJ7BimUX+iANsKeGmBu+S4/dulUd3oci2VG+/Y2wOku0/UYBGSR5phzOutkJyMfNBLmIt4G77k4hqvlwN71afoWn7aHFhkMy0yhu+FkpIeC84aGzcqPpN+ATjECQdCyXDB4r6z7IgcOhifHNDo+HoRCj/8bEMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986513; c=relaxed/simple;
	bh=oNlOSf9lwria5g4P4bcAt70Ozfm2fLJztO1p5+bHdpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKau7xS+hiBBoRwTjKSv1xgC5Dm2qXsdehpDZfWcXkkSYG31I5rJp1rFa/D47NUKmYLv4s27HFDiWkQaNWvaQU52cUZNy+JzJAwKZYx2nAaYlvyNllor+mC5h3hZnVwNhMVi32oDeF91hLGaO6WnDLYfWEQTevJDANh7IeYI1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SKBwReyO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a12b3f4b3so2205855e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 12 Aug 2025 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754986509; x=1755591309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0RU+EVA/oXhr6629uj/gRIC4NsMhB00Ff4FYPm+o0w=;
        b=SKBwReyOysOJoArO7ntlF3K5xPrid/kUvBQJv622dX08DGOJfXwqbHAIjciVkXtnch
         vUzksxG89WzP/kaSIrQl746Pkl/VP/NuJFqPSGEWWP20oq9cVguAVaO+uniQy7ybvfHK
         sEOyXS+szFodrLp4UIb7Adl9CTGnsXZb7+WVDKV29u/CF+sy/raeZDSyMF2YX2ey9Ds7
         u/FXRBefg9ESjGntDoH8xxq12v2Nq7vWGbhgqF0FZXrx/BlbVrhR0UZcCCCoJ6kg040Z
         dID2af7PQ9wCdcTtT1d2pfvxXFiP/UISq9XzqbeggvbTHsTpTgYl+EPOqB9QxSOu1/Q4
         LaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986509; x=1755591309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0RU+EVA/oXhr6629uj/gRIC4NsMhB00Ff4FYPm+o0w=;
        b=vCR2SrPXiYsvarDuO+j11/6IHN0HAMlSGuNV9Dv4/yfjqpOQyOc97DqbQhgQhMd3P7
         pPpy+SBg0JHBkAa/QhQbTSH6oCqlwDcb3AmyLyUmK82hvDXYXqW+lHVUKeEjcidMPd51
         UKvuUQrK2gtxL8yJ3XKKflB18U2Yra7Ks6kFdaA1Z9sVyUxDiiLy1A/c0a4etTB7/SqU
         z+KDqyWymx54VlWWB2OedeEBXYISIe5XB3pgJW1COTLPmBuPwKvwD9uTDJqGDdnjpoRM
         vA1ZYizvz7reIYVdSG5eqBnb8LB/mUlmoS/tcOpNl4TWkIqSJDDGZGFGAphZrBBqOP5f
         CprA==
X-Gm-Message-State: AOJu0YxQk5Xgu57d2mhlrRJVMNHCAZfwlIT9ZU6N7Kgt82rqjV2Jokix
	M36pf3j7qslT5YncBNzcBSMky5yaQ3LXPTmu1y2J1cRReel+mlNZj0qf0i0uy1BGBgquMyAUhCn
	Fetzl
X-Gm-Gg: ASbGncumjP5l1FB++3NJSzPIhQdNkcfZXtsXyx6SFzO4ARRwfHIASazWRunopaOPgXb
	Z+BvRecAY+dZOki7FqZBJSGYeXopPV6fiKLDpP1qpQOxGQ7HWXD0HeMFyT5ckjGVXCda35wtZDX
	KUzG4MX+bIHva08erpOVhduv3sBNwq8LNp9XahXVFlDnjenU2/qejjqplCiKlmIi6rfN8Gns0Nh
	Vm9lebMI5yFvuUn/zM4lgN+g8DX3C7TOliFDB/5TxkVxmonN+NLw0z3o8xWzI9/wtd423UNbpu6
	4H/KsC9CoZ2B35CBHn/hi03KLdXuLLa0sTVh+l1Z/XOhU+R16VCZOjzh8JpenJJlZwIOVRqaPWR
	oPfX0ZB6VXuiWnqDDLSUMl+v4FGObb987keFVTpuwA9PsgvLULjl2Hil1O+qxqkTb
X-Google-Smtp-Source: AGHT+IFzfwjMr91Rwcp22dDBo2pGbAACNReQ2jizIX66xTl6+mHxOZwy9Tcfm2HCsLai3a6BpHWpNA==
X-Received: by 2002:a05:600c:b99:b0:459:e20e:be2f with SMTP id 5b1f17b1804b1-45a10baf6ecmr22994835e9.14.1754986509045;
        Tue, 12 Aug 2025 01:15:09 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c46ee84sm42292918f8f.57.2025.08.12.01.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:15:08 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:15:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Clemens Gruber <clemens.gruber@pqgruber.com>, 
	linux-gpio@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Provide a gpio device for waveform drivers
Message-ID: <kzjwaczug2m6lfxh3bncoi5tuupbearhpdawhcuhm3uy6zl6ic@6vkvutgfgl5e>
References: <20250717151117.1828585-2-u.kleine-koenig@baylibre.com>
 <533s3ekqhn2lbk5j7xkwfoi473lkl4prpr6bc5qjd7vzawlmqq@tevygtxqobzv>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zn54w7fsxqkmu2f2"
Content-Disposition: inline
In-Reply-To: <533s3ekqhn2lbk5j7xkwfoi473lkl4prpr6bc5qjd7vzawlmqq@tevygtxqobzv>


--zn54w7fsxqkmu2f2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: Provide a gpio device for waveform drivers
MIME-Version: 1.0

Hello again,

On Fri, Aug 01, 2025 at 12:03:20PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Jul 17, 2025 at 05:11:16PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > A PWM is a more general concept than an output-only GPIO. When using
> > duty_length =3D period_length the PWM looks like an active GPIO, with
> > duty_length =3D 0 like an inactive GPIO. With the waveform abstraction
> > there is enough control over the configuration to ensure that PWMs that
> > cannot generate a constant signal at both levels error out.
> >=20
> > The pwm-pca9685 driver already provides a gpio chip. When this driver is
> > converted to the waveform callbacks, the gpio part can just be dropped.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>=20
> Applied to
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-nexxt
>=20
> as 6.18-rc1 material. (I just claimed the same for the v1 patch, that's
> of course bogus and this v2 is on for-nexxt.)

Now that 6.17-rc1 is tagged I rebase my tree and squash the following
change into the commit for this patch:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b05186b9569e..ec4112e6209a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2511,7 +2511,7 @@ int __pwmchip_add(struct pwm_chip *chip, struct modul=
e *owner)
 			.request =3D pwm_gpio_request,
 			.free =3D pwm_gpio_free,
 			.get_direction =3D pwm_gpio_get_direction,
-			.set_rv =3D pwm_gpio_set,
+			.set =3D pwm_gpio_set,
 			.base =3D -1,
 			.ngpio =3D chip->npwm,
 			.can_sleep =3D true,
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 6e7d02c24991..549ac4aaad59 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -322,6 +322,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @atomic: can the driver's ->apply() be called in atomic context
+ * @gpio: &struct gpio_chip to operate this PWM chip's lines as GPO
  * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this=
 chip
  * @operational: signals if the chip can be used (or is already deregister=
ed)
  * @nonatomic_lock: mutex for nonatomic chips

The first hunk is to make the code compile after commit d9d87d90cc0b
("treewide: rename GPIO set callbacks back to their original names").
The second to please `make htmldocs`.

Both issues were highlighted by Stephen Rothwell, a big =E2=9D=A4=EF=B8=8F =
for the
tedious work to build the next integration tree each day and pointing
out these issues.

Best regards
Uwe

--zn54w7fsxqkmu2f2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmia+AgACgkQj4D7WH0S
/k6UTAf9FgJsxYHtV8rKBcpj0hEIR4eM7klz3prj5Kttcl6n+W/O/cyZ6Rc7PGkF
l+uljY9KLXRPWN1zclh643Z+glt7SBYx9U6P0d4lRkhEOn3uA+lT5tDuJ4T6R1kp
qcgTGDJ4MmaEwfmOMeEAIdjF0aTg63PKfNvma+6k35E8cHVMFrCckUkyYz7ojMeZ
zbdR+4Q23eLTvN4ei+3f5uu+ITUcrtfNJcaj4ihfcVbNYaXtZ3aSWqnuEiieucDN
aXPB901VrXibGSgHuzdLtzycDi8eD5IB+G//+vW6dkAbcV0Sywa2Q05mo7czwN0U
eOvyTDDz/ieKGd5yP1MEd5SSLmKceQ==
=5max
-----END PGP SIGNATURE-----

--zn54w7fsxqkmu2f2--

