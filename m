Return-Path: <linux-pwm+bounces-2942-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652C94272A
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 08:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA80B22C9C
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126B16A39E;
	Wed, 31 Jul 2024 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yfydGHg7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF974413
	for <linux-pwm@vger.kernel.org>; Wed, 31 Jul 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408607; cv=none; b=Zf1gHKDZxGEWkvLPyf3XX6Pk+pi50wnyXuUbCHPZyd8+UkcIpjuT/48fs2FmXQ3Wy1/e+YhpwOgJJWNbp1KRwWj18acjJhHNtRGtA9q3zZvWTRHnhLL+jxsSm3ZsZmG1h8OmC9uN7SRerxQDnKfUMH1SSdmhzmCUreUDAMvXzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408607; c=relaxed/simple;
	bh=i6XxmDrD/zooGcZ4phmJIYPP/6e2e0Clj4uofChOHlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHleAcwGWxdnK1P7d5z50vbF1Cjvo8q212bJc//a9aUMZaunk/1R/JQA49WZ7mu635UZcjIcQXTSMcBRVSWA3oyhw/C63LqtcUUqQLPRIZBdRu6nnpDqeUSg5Znum/BBojAYz/lHvNKEn0R8j+NOvaELCvzfPPWNMf4SBaDSnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yfydGHg7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efba36802so9195863e87.2
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722408601; x=1723013401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6XxmDrD/zooGcZ4phmJIYPP/6e2e0Clj4uofChOHlo=;
        b=yfydGHg7Kj6uFYwkIEr3cUXSkRpHjoKwUYNsS6SFbQYeweRab3l1cleFa7e/RfMbsY
         fyTvUGYj6AFQoMC7JG7p0I+xBzQL5wc4lJqXPicw9mncHwQWgmX9Y8WQ5URvOelJCYIs
         xM/1bRamprIUZ0Ea8XO2AvDdfk0VZ2yyBmsdKezuaWCCS+ph71nnkXsdig1Uofu36BVn
         IOi0Z+KFd/Dp/DkAbcZ0ygmzoRkcEpKnrQfJdX3pWaY5CHEGtegd4ZdZ832wYu4wjZjF
         b7IFrsbYuSGzdxQiak9B3ru2dRwgmv7GZSVuK5pJokU/ZHz8cugUGJyBqjv4W2wnxVT1
         DA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722408601; x=1723013401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6XxmDrD/zooGcZ4phmJIYPP/6e2e0Clj4uofChOHlo=;
        b=AH3i+WTKZ40xtC7MYPQmgSos+LJDhY8THxnTt8RmPdJ5Lo43ZpgT3WinXz+txgKlNH
         I7HRL7Hp1JPYx0cs+3TEcheuMeBgX4jz0B6yoTDXYfD+yV3YSSz6o04vIlyHxKBicJKd
         2ufX4gFRBNgJ+WI1O0J8dCPnpCV3R7x/EAJ99/ZrQC6JwLTxYa3/06logu5TqWTp2dp9
         Q2QRlQo/+0yD5vUoEBNSGsn5VkL0A5hYp7NOj4oAJpjhuwIJyyHOJPzjIAoYW4aJXXYd
         ePTrbEQuMDmh97fMIqkEcCjQ69VHk+BfPakPZ766DGpwnnNALSP9y8dquo5Yi/guCKZ/
         fLww==
X-Gm-Message-State: AOJu0YwlNt3JzIiyWz7+L0BQH/NtikgKF7kbKtcNVubyuDSlz+Omc7cN
	wYQYQZLeNjehJRj2mRs0tidRiWkY8rpPy5mFVuwdAXS11LoEvIAD2s2VDnjGsCk=
X-Google-Smtp-Source: AGHT+IFZqTNsJLJgRJ4eT+fjHh3JB8voB7D3OP+G5m+Xx66UKomnClF+t/p67ZkQsyVFoF76gmdnHw==
X-Received: by 2002:ac2:5923:0:b0:52c:a0b8:4dc0 with SMTP id 2adb3069b0e04-5309b27b0bdmr8908612e87.28.1722408600649;
        Tue, 30 Jul 2024 23:50:00 -0700 (PDT)
Received: from localhost (p200300f65f164800ca5d02fee8f4878b.dip0.t-ipconnect.de. [2003:f6:5f16:4800:ca5d:2fe:e8f4:878b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63d4720dsm8353533a12.58.2024.07.30.23.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:50:00 -0700 (PDT)
Date: Wed, 31 Jul 2024 08:49:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 5/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <cjmj5p3czu5hbwnk2xfhsz4yftyw5qgjcdkglfzxolcn6ml2qh@lqzurmeecqfn>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <7e50f9901d63c3aa27cdd02194f95b0ed79765f6.1721040875.git.u.kleine-koenig@baylibre.com>
 <80dbe964-6e83-4085-b56c-609babac2ee5@baylibre.com>
 <impohkxfro2udihqhckracjhzo66ft66c3o4vgnje3phtauf5b@4mvr74dupo2h>
 <9902d366-5abe-42c2-a355-66c6e0a366dd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bfnaqs4j5q74pqtp"
Content-Disposition: inline
In-Reply-To: <9902d366-5abe-42c2-a355-66c6e0a366dd@baylibre.com>


--bfnaqs4j5q74pqtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Tue, Jul 30, 2024 at 01:41:32PM -0500, David Lechner wrote:
> > This way a consumer could find the
> > respective device directory below /sys/class/pwm without parsing the
> > chip id from the filename (assuming a sane udev configuration).
> >=20
> > Would that make sense to you, too?
>=20
> How do we expect users to find the "right" PWM to use in the first
> place? If libpwm is going to use libudev to enumerate all PWM devices
> to find a match then we will already be able to get both the /sys/ and
> /dev/ paths for the device from libudev.

I guess I have to take a deeper look into libudev. Until then just
dropping the ioctl for getting the number of pwm lines seems sensible.
Adding something later should be easy, when and if we see that an ioctl
for getting the chip number would be helpful.
=20
> And wouldn't the file name in both cases be "pwmchipX" (e.g.
> /dev/pwm/pwmchip0 and /sys/class/pwm/pwmchip0) so we wouldn't need
> to scrape the number out of the name if we wanted to do the matching
> that way?

My train of thought was independent to libpwm. It was just: What if I
have a file descriptor for a pwm device (provided by some HAL lib maybe)
and I want to find out the /sys dir for it? But maybe that's not
something that will occur in practise. And if there is no such ioctl,
I just need more info than a plain file descriptor.
=20
> So I'm not convinced yet that having an IOCTL to get the device ID
> it is especially useful.

Thanks for your input.

Best regards
Uwe

--bfnaqs4j5q74pqtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmap3owACgkQj4D7WH0S
/k7Lfgf6Aia5wQv3rqNu2BI3g4rK9twW33qoref306nfzgEwdz67cgRPRXFw+rm3
2oScPiwlTJn2fkXcZMk9pxu3SKrzwah+G9L4idw9efm34SJ+YR4P7BkMS2OvY+qk
7WsP6CmA3oGkasAUIFUnxLxJ/OwiBeTzzpj/X/ogujgQfhNibe0jusqxL3xZh9Ej
7fuH1OoOKWn+EMkR10CZVzQ23FxJD15hgKu+BGWNUKp8vtVwcsk9GYYw43+6Xjit
2HjitNaxRFXetPpWubKbzYQBYAXvyWB8+Fl+PYHg6NIVXS+t6PlbaCP4U4OFKkBs
CQ2xqVFkMTW5vKZ7H1y3mHaBzx14JA==
=HUxM
-----END PGP SIGNATURE-----

--bfnaqs4j5q74pqtp--

