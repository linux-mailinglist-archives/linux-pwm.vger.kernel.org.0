Return-Path: <linux-pwm+bounces-2815-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BD931B3F
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 21:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4162826D3
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 19:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF44136E09;
	Mon, 15 Jul 2024 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kUvDrxzy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E01369A6
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073172; cv=none; b=UDvi8VB8gB3du937nlDhRnhZISp91faVufnnZSiQ19mD5G5gC40Qip+ZvcjIY9LsbAB9xwXMuNxoOk0E/DXPCearegcI/t2talAuIg0PxBuCC5SsZptk8AFFwUrSmuBd9wLHlQgU3J+vozArU2rGp3OZ6dTlKLh/50n8A7ALo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073172; c=relaxed/simple;
	bh=gVIptCJwdyduue5elVkeu9Vo8vtYeQBySP6LT1wVBps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guF9r+Xoac/gtT6NT7O76qfkGInnfAMw6m8kmcoerEIvlMPeHW0Lp32J0eIJcqQ/zwvwlaMoSb1ZSGhqbIMgDAxdaFetHrosRWQ6SHok1pSfoOw2a+StjB/mMdBeQFSrSBddXL8uZeNgNPVtmG9LLbxsQARTRhn7NvhhWAhBwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kUvDrxzy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso5743105a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721073168; x=1721677968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWagT8wWI6gI8R2I8WvxMWoYur2CzikFfH0bCBKYcfE=;
        b=kUvDrxzyvCZuUYvxd3op7mdrpUTn3VoBbKfMh93HcW1lMEIZ/wCAaZ8bAwIRwDgyrI
         1PCujymXoVwhytrYDyQ2+m3M54713WtZchc+t2aOE6acTNqWjPSiHd/Fia4pcASJLIeM
         VoPKs1YqkgGPtOgC/s4wq7wCtMN+IkeLS/VEymh2Mr0TD2gAqa8NPy/2gRI0HaFnOqx/
         RLCckeWbUKXWY7X3DpGHBYy5PblCcuM1ck07rtMK382IceTCIYcJxU7TAzwObc4C5DvH
         FM4bCi1kwqiYqg7SK2VHvCjN6KjjTnPpqFTIIjwqrxlq74YidE/bhuhdkkZsKO24IBDE
         APng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721073168; x=1721677968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWagT8wWI6gI8R2I8WvxMWoYur2CzikFfH0bCBKYcfE=;
        b=ahs9yu6ipGzAMywba/1NtFy9xyJt1FujW2RLTCZFilhoS4uNLj9NkjAS+cNgAICTb/
         5TiadNmXP4Jy5bTk5LIScUCM1zqqvfmURJsnGwcYLaMvqIfSdqLWRt7ae+dl25WLLOdr
         8zbzX0OFmQs0Y19YCZrSGYQ0n521GVZG3rDVukqx5QxPK8hureySb5zzNy40vLSkRFm6
         qUscRKQe411j3MmyiAEfpK/t8IkFx4+1PEan+u0v+6rQz98Dfm6lMwUV93LBAHFbL0LA
         /8W4WuGXUCCKWXxqHB+9MwxTbMet8plfueKfTkjUpwTjoQb+ZXwjLGbkMBVY/91+deeb
         sy3g==
X-Gm-Message-State: AOJu0Yy67EZQSPdgEC8vjufYLwe6RntW9y+eIBqnQNk7O3Lwc+Zw10YV
	mYioITG90/AbXVQ235YQpWa1BX2rqseZ1Oh58gwf4+uMpAM/a9lvGH4tGUE8Y4M=
X-Google-Smtp-Source: AGHT+IGYPT/br3szyJ7bjdq6M5SJi9VbfcO4Pa7kjhjOP8c3Ofm6LzvMGgal9gTjmY3M+PQfjawcvw==
X-Received: by 2002:a50:c048:0:b0:58c:909f:3d60 with SMTP id 4fb4d7f45d1cf-59e9724a722mr605831a12.16.1721073167723;
        Mon, 15 Jul 2024 12:52:47 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a76cadsm3735902a12.15.2024.07.15.12.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:52:47 -0700 (PDT)
Date: Mon, 15 Jul 2024 21:52:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 5/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <7a6edhtedn64kgu3y3i7r4xwuarpjq7z4zx7mdvpiv2prildww@ewzsbaesa3nv>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <7e50f9901d63c3aa27cdd02194f95b0ed79765f6.1721040875.git.u.kleine-koenig@baylibre.com>
 <80dbe964-6e83-4085-b56c-609babac2ee5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h5zoseswnfridceb"
Content-Disposition: inline
In-Reply-To: <80dbe964-6e83-4085-b56c-609babac2ee5@baylibre.com>


--h5zoseswnfridceb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 02:37:57PM -0500, David Lechner wrote:
> On 7/15/24 6:16 AM, Uwe Kleine-K=F6nig wrote:
>=20
> > +#define PWM_IOCTL_GET_NUM_PWMS	_IO(0x75, 0)
>=20
> What is the use case for PWM_IOCTL_GET_NUM_PWMS? This info is already ava=
ilable
> from sysfs, and it doesn't seem like there would be any performance consi=
deration
> for using an ioctl to get the same info.

This is provide all relevant information without looking at sysfs. Of
course "relevant" is somehow fuzzy. While it's nice not to have to look
at sysfs for basic operation---libpwm currently doesn't explore
there---you're right, the information duplication is somewhat ugly.

I'll think about it.

Thanks for your feedback,
Uwe

--h5zoseswnfridceb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaVfgoACgkQj4D7WH0S
/k73wwf9Fay75sXkc2prlX/56BOccATS6l8ADKSZEZjU9r/8+IO8UB7flZccZhCI
77/p0auWLgoIaaO5rSATRXLQabphQr7I692gb9bzXUFkRHjElIaKZUo1JoI3Xw7W
IxtoPxpJoH9sNftoxnsZ683l70IqluaZow/EakJcAenHIi3ZyV3Clkms1dsPXnGl
fovrLPtdT/bDYXle7mzzKL0VH+qvSD05NhvmmmmJdfCdbzd6q3CO2WQRfu49ez6W
mGZFZF4GHmLRlOywTJ/oEfEm7LvSHN8tMw//iU/Nur5XNVdFBYWecbcpw1jIhRGn
3NOI1AjU2Lzr0RYmt7jTpjbfAYFufg==
=/SC2
-----END PGP SIGNATURE-----

--h5zoseswnfridceb--

