Return-Path: <linux-pwm+bounces-5552-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44DA9143C
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 08:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03595A1E65
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 06:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB62063EE;
	Thu, 17 Apr 2025 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OdOtCuUM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2BA94A
	for <linux-pwm@vger.kernel.org>; Thu, 17 Apr 2025 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872124; cv=none; b=FHE/dX5+VDj3ZQQJt4pMlhsm0HzH8nY0+9SA04vYvgzf75zawIEmfqQQwxAYT7Tyztj0FcPY3GxaA6KXwqErgMDT7pXzlwiT2m8Z60IVsxw8E8Pn0j39pukvGAy/REYeqvRLBhw1HWD8v8mvJN8xjb6Y8uHgdo9ixd7e427PHl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872124; c=relaxed/simple;
	bh=yaD0o/MpljrBAEdWES6QdpQZ4K0dI6XiiBkGI8DT78w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nepN4CcrjEpBDDeTrK+sLiDJ98Rw2jSuaPiXXXfpgCh2b400kh8xhlPQ0VFQ7ElcjIyBqLs9vEblKE43FRjBlUjEoyxarLU0ghcHyYue0gDcElwbXyczmp2YjofACXj333cdEGp14IA6HxFneeqaAtv63yC0Fn1XEB+avQ8qNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OdOtCuUM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so260930f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 16 Apr 2025 23:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744872119; x=1745476919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eein+VHADvsikPAdoVCtfDd2FF1ntTUl8Rt/ykT+erM=;
        b=OdOtCuUMJfGy4mEIcZmFEUSKclsXdDfbF6uEuEt4FpFlTU8tcg4FfkZ6xYi2gX6lhg
         +K+UuX5z+VnupaVbUY5BxvYk33vmKYs5H9GaJRF+woJOYFUHOkxaNKm0Xq5ked8EMkPV
         aFEMUipUSx2C+SpszFg/x27MouGy9xGR0wcdXwfR9dZPvNH2DR8ODLEuMD3c3uUNRGpD
         icRV137RUrEmzE5OV9RHWeNcv08Gg0QDb16W7hlB/m5oT5gNmoq+46qGJbWn3VauiVsd
         D63dTqGDlGhrm9Wf8ggCIZJDQ9VBVK/Kb75LXTWGOA+1GQrINj02JxhxU8XYxUjZ+QZS
         JqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744872119; x=1745476919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eein+VHADvsikPAdoVCtfDd2FF1ntTUl8Rt/ykT+erM=;
        b=ktskd1rveyIADZ5bEWNs2tKK6OThvNT5ZRZfMe8RvY3VTQ3nF8DWVW5UXySGUBAr6B
         l5GN76270IwhLT/7e5Ms0NcwKCpyesEJtGyP0J9k1v/6R/DNq7Xi+F9/qHj+yxhtmNKr
         2HLVGMGXG2WWFSk3NPzQUvJZS4frFjF3c0gBm1PSor5dHRAivOYXJDusSfhZL0DgT4yx
         mlDY0RnXki1lsF6k3UJgjyXT5VmdfYqbZJ8flnyNWnbP6RuN1MBj4z525W7pGMdXTQ59
         yT3Rlrw6oVB0JlHjXq1jqa1cpdpkgFro6caqGfbeynzu/NDghydxoK5FNqi4XTPF0m8H
         f66A==
X-Gm-Message-State: AOJu0YwUwKLUCXnVqfUV2RyThO+qv+lSnaqaMy8kjEhwKXEc7BAvU5f8
	/cL41UzAv1nMryL6fi7O6s9KW4KmwSQrjRdye/0CjKAhTbw4A8f3I/hpHPHF7ac=
X-Gm-Gg: ASbGncvxaZE+S/A4Ax+ATEDa+/fEmkgZQ95ePhPaGRMIkjS6H4zlhLDyUzE5fv/bzAM
	aZUmSmMKCwapb9tjTKbB96asiqNJXFcqJ49HV0xA2zQHuuP70TwsAIsQ6tYtrhMWDfxxTvcmKl1
	4x7PlrQ+lgDF3zgmCSWaSm0RuF3TqgLPAKsSVkLQxuyGlx7iWSAOST5ktsXx516DqBcP9kRKlUq
	0GC2a5nAYTHoIxBc/i2a+uF966SRFcQzskk3aiaiPx6QpTLN6ZKDAmB6OO1n58T9qT4yUXsmDil
	WpewQdSRYX+bDDGr9aj3v1BE88qCaJGMbQIAotCm6myPmeYAtw2Y/SkHxYSFXJMtYcBubHKPzfc
	tuZwhsYA=
X-Google-Smtp-Source: AGHT+IFJ0pZYptu4DVUIO71f1H12GuK7CCEW5DL1wtqm6TS2q2pKQQSbrZ1BBYTaYvxv2udBZzesLQ==
X-Received: by 2002:a5d:5849:0:b0:39c:1257:dba9 with SMTP id ffacd0b85a97d-39ee5baea43mr3966148f8f.57.1744872118879;
        Wed, 16 Apr 2025 23:41:58 -0700 (PDT)
Received: from localhost (p200300f65f13aa0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:aa04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39eae96e912sm19370710f8f.31.2025.04.16.23.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 23:41:58 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:41:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Kent Gibson <warthog618@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Message-ID: <twtne72vhwnwwyvld6ipwk6ilszgncgfqtbb53ldfl2hhvns7v@f6vmuburt47q>
References: <20250416094316.2494767-2-u.kleine-koenig@baylibre.com>
 <147fa354-e1fe-46ec-9c47-59794f37bfb7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zgofz546aqvg5vxb"
Content-Disposition: inline
In-Reply-To: <147fa354-e1fe-46ec-9c47-59794f37bfb7@baylibre.com>


--zgofz546aqvg5vxb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7] pwm: Add support for pwmchip devices for faster and
 easier userspace access
MIME-Version: 1.0

Hello David,

On Wed, Apr 16, 2025 at 11:29:50AM -0500, David Lechner wrote:
> the passed wf according to hardware constraints. All parameters are
> > + * rounded down to the next possible value, unless there is no such va=
lue, then
> > + * values are rounded up. Note that zero isn't considered for rounding=
 down
> > + * period_length_ns.
> > + */
> > +#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
>=20
> Should this return 1 if exact could not be met to match the other functio=
ns?

Currently only PWM_IOCTL_SETEXACTWF has that semantic. Adding that
information to PWM_IOCTL_SETROUNDEDWF has to involve calling
=2Eread_waveform + .round_waveform_fromhw which makes it a bit more
expensive, maybe for little gain.

> > +/* Get the currently implemented waveform */
> > +#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
> > +
> > +/* Like PWM_IOCTL_ROUNDWF + PWM_IOCTL_SETEXACTWF in one go. */
> > +#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
> > +
> > +/*
> > + * Program the PWM to emit exactly the passed waveform, subject only t=
o rounding
> > + * down each value less than 1 ns. Returns 0 on success, 1 if the wave=
form
> > + * cannot be implemented exactly, or other negative error codes.
>=20
> It doesn't make sense to me that PWM_IOCTL_SETEXACTWF could return 1 mean=
ing
> that the exact request could not be met. Isn't that the point of
> PWM_IOCTL_SETEXACTWF?

Yes it is. Returning 1 is an error indicator and then the HW state isn't
modified.

> To either do exactly as requested (with 1 ns precision)
> or return negative error code without changing the output state?

Returning 1 was my conclusion of our discussion that -EINVAL and -ERANGE
are both bad. The former because there could be other reasons for
-EINVAL during hw register writing and -ERANGE (also) because the
semantic doesn't fit nicely.

So I gave up finding a -ESOMETHING that has both the right semantic and
could be returned without being confused with a different problem during
hardware access. Inventing a new error code seems wrong to me, so only
the positive number range is left.

> It seems like only PWM_IOCTL_SETROUNDEDWF should be able to return 1. My =
natural
> expectation is that negative error would mean that the hardware output wa=
s not
> modified and non-negative value means that hardware output was modified.

I'm also not entirely happy with the semantics, but still I have no idea
for an improvement.

Best regards
Uwe

--zgofz546aqvg5vxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgAorIACgkQj4D7WH0S
/k7nBwgAm/us9BA2PUkKA2MhpxD+658r51N+iBy1O2cmpJ3mISA/LmAT2PuNXYU7
l0LzbVLFngwJLBcb7UrKaUxFAtmpkIE4eQDy0lDZC7xPZsT4QhoHOB1/fDAZQdAY
mVUyiYM0+7EZAnmR9jrDTTGk62cbNtEHI5ykaaJNbnMmMRAiyF3k4lv7RO8VCQLW
ozIlL/6ATjVTFKUa5UzBqiLaXqppUyWoyzg2Cz6Hyn05dTRYT06nJE9CxGihk7dS
dNPfDd3rfaaw3CUfYbic8c1ZC1Er6yg/yyzbUPj+pKcK/Pkm+SxsBzf8Ugzcp4ks
lsr4R0OrlLwdGTQu90qdNBQ/pJVnPQ==
=OSru
-----END PGP SIGNATURE-----

--zgofz546aqvg5vxb--

