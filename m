Return-Path: <linux-pwm+bounces-7277-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FCB4FE0E
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9084E09B7
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037C21B196;
	Tue,  9 Sep 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FTybITak"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930E218580
	for <linux-pwm@vger.kernel.org>; Tue,  9 Sep 2025 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425425; cv=none; b=ZCkbw/fB5W6vsYOgZo4yqlVKtfEI9E3qauIb1k0s679X8Dp9/3WSEoDu+qo6FOTl8wmDjeNZFdTxm1WkCbgODUbNtZ9oMG6s6e26umVQspOYh98yqTXFAg6pBXMw/2lN9hep/JK007lIf/bUArRdHb0qqt4hQPBNHSZaXw79Vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425425; c=relaxed/simple;
	bh=7OCQkXlPaWzKYuwAdJ0JcKihA/NTCTMSGtBM/2sxxKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL9T6Dm11RbPwReL6FFvlZjOLqs2AT9GdB9IjFQUXFyoUJgx3ZrkgsyJWRP7gFEFwzWntx3y8f2lP2YB0a+llMCEwwJCjlO0YRbquvYV5/jzA4STw0ghwUZ3bZ3QsAOxrYenzzWe/FeutL1SZhJbkBDUH02vEXTgqUL7i7Ki7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FTybITak; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso9137675e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 09 Sep 2025 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757425421; x=1758030221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+nWLB9y4BzdWZAFh61duSVbe7oQYF/G0igBbtFxPdK4=;
        b=FTybITakJzkHeX5Bas1/mdTY1Eh5ZEroN23Nt2fAK5p79Q+sJ+xMRGsCE03wS3Tqsq
         49XkoMVEUp0CCx1lJ1S9epQXyzaMVDTtlyzPZ8PXm5iLfxpTQNHzy1qmlGAxykmn8z9z
         ok2WYCe5SV2daKdi3WNUe7bJ8t9oqeQX3fU+UL9jlb6i5tIEXCgoLqzWNZ1IMHvPzpFC
         CVhKJ2HqJd5Sjmg3ovGzXS5RW55w9U18CAAf+2Bx3qjgm+9KQqP25MudA7hjCDl93EEM
         /nJguUwZGYmTGapd1MKpAgOlpb34eF0yLbQ2EdyrMUQnMxwjBOuxDY1cGg+xh/lHYXjD
         MJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425421; x=1758030221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nWLB9y4BzdWZAFh61duSVbe7oQYF/G0igBbtFxPdK4=;
        b=YdtblzJz8+jTzdYRGTKgExcKU5BzhpiG+SxNhpxihOuGYzPkFrNSXIAzv/DQH8erg2
         L9VniBHwerKgZTKpYxxi/JGwJbCzJfYc7ndC8tWoSrmIpNRmVkCDJ+l8rztteihSNJU4
         k60hw6CJ5btFOxm/eLyIJeexEjEuwz8OJpk8cIatCSLXm4KixU3Ulg3ISChBVb0ZKwJX
         XQw0ynHrKxkHK1Ds2cqtBaVCoaO1f9YX7PpDlQJKNYAMZ6hRAkdkN7buV6OK5z1DbB9o
         zME7C5CHA0C8b7ERBjTusf2nKWAJRf7sasjyP9YSIUtu8jlNNnw4SkNkBk6ak0UZ7HOe
         Z1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8s4KgdXP0f0ndbudPZSm+z368MYVBeQRXvrabHyB9r6pOitAikq0jujZM06n/CakmLKhZmx7AqnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6A2MXRTMbl3W/T9acINVMadEsL34RrJyPA2NiyT53B9hLBXAv
	/3LwTNx6P55lrswiTSmQWzgr3eVwvcYIGmhVYNneD7mc1cY7zUSLMagolqFDNKCA/ET+vOtxwEU
	4ZU3t
X-Gm-Gg: ASbGnctjOXvJmuICsHIoi/ux7XMzzXiCj9x62MK9RcjR5xUwLFAd/Qdvlx2XcrpIPyD
	b2ZPXC2tY0I8Kt3hc6Rl1WLC1FzlHt8pbvhKbozHj9OoBhjwglMjXs0+dXAbz8uh5YS/wm/VKcu
	ojdn5pIslQDfJpy0e3tS9garIyitfgRsEgD1SHkHZHaGtoU3IbLJ/hUyokx0S4Q/SO12vAVbfLz
	9qGWnuIa0R+/zc6knlmRytyN8mHoy67pKerenPfEvLLWY7hLSFAA4o4mmRQEv5nB2bpGGgrimqj
	SSeFlJ+QLM2KVxPCHNO2QPBpzIIQgKx7ctf+2FzPI0812B3AFIEOrHwm4mMm+W6Xc655mLY8WGl
	XEGTP6a2YoJ3wTZ+3Kf6X3BEyvD9V5xl6jEbz28p+sP/rd5gH2KFXy4TiOP0FIo+7zzp3jxxUft
	M=
X-Google-Smtp-Source: AGHT+IExZonjFWWehqLYtueahKiysRYM0WBg9S+ifayg52A4BJxC/bn3wEJPtkVa1EA4aEoE0OkwQA==
X-Received: by 2002:a05:600c:4585:b0:45b:8ac2:9759 with SMTP id 5b1f17b1804b1-45dddecf557mr111182145e9.23.1757425421489;
        Tue, 09 Sep 2025 06:43:41 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e75223897dsm2886401f8f.30.2025.09.09.06.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:43:40 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:43:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
Message-ID: <zkqqw2jxtx7mhwbck5jr5kgdg5ze5bk65aqarpdzl2ieh2hdj5@fnm5lybd227v>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <175680932706.2261091.9987211835426797993.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kug3zs2e2qoaurrt"
Content-Disposition: inline
In-Reply-To: <175680932706.2261091.9987211835426797993.b4-ty@kernel.org>


--kug3zs2e2qoaurrt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
MIME-Version: 1.0

Hello Lee,

On Tue, Sep 02, 2025 at 11:35:27AM +0100, Lee Jones wrote:
> On Tue, 01 Jul 2025 11:22:35 +0200, Uwe Kleine-K=F6nig wrote:
> > the first patch of this series is what I really care about: There are
> > hardly any drivers left that use pwm_apply_args(). When all of them are
> > converted to not use it any more, I intend to drop that function.
> >=20
> > The 2nd patch is just a change that I noticed while editing the driver
> > that is IMHO nice. If you don't agree and only apply the first patch, I
> > won't argue. It's an alternative approach to what Daniel Thompson did in
> > commit 7ee6478d5aa9 ("backlight: mp3309c: Fully initialize
> > backlight_properties during probe").
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/2] backlight: mp3309c: Drop pwm_apply_args()
>       commit: d22caa15de3a11b503157aec079cad4bf305ff47
> [2/2] backlight: mp3309c: Initialize backlight properties without memset
>       commit: 71ca0594c11b4030c6dece9ba9b080d652a82473

I would expect to see these commits in your repo at
https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git, but
the exact commits don't exist there and if the patches are included
under a different commit-id it's not obvious to me in which branch. Did
you forget to push?

Best regards
Uwe

--kug3zs2e2qoaurrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjALwgACgkQj4D7WH0S
/k68WAf+J5wpvAmD9PQ9ddCpeNb3UNH+0Vei7XvjmZIMHOe1A9WCJYVk8SaQ0xtk
4nFVbHWjAJUPCxxNqeMD9hR/ENXo2yUgAxD9r2ifDde8PMid35w9o6VJkgDvRTmn
APYswRylywm9RWDTqxO3TzrTvbUXOwUebUofJzrW9wzZIMDbh2TP8m8VS+x7+L59
NzwCKKIUSxvRMH1PzqkMmk9VNGlCksWpKSDa+KZn1QkY0nSgUXqmBzDe9E97rNF/
tRCRy8SRHmKAAuCWW5CwDGhhQExU2iooq3eW5lHa/oFEzfLwni6b+EZsZjzoSBWU
fX5AUmn3Vk2diZgaKg/m8Sc1h2D+9A==
=m9sa
-----END PGP SIGNATURE-----

--kug3zs2e2qoaurrt--

