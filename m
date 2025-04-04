Return-Path: <linux-pwm+bounces-5330-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC2AA7B839
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 09:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B9A173EA9
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F04186E40;
	Fri,  4 Apr 2025 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rgd4ruqC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B32E62B6
	for <linux-pwm@vger.kernel.org>; Fri,  4 Apr 2025 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743751549; cv=none; b=TvW8eEYmB3QYwPxa90zTuOVj7eRtBVfWX6aWQFg2PUm1H1Mdrm1nAk5yU6yTqjejjSxpM2VApML4ukD5xaH/dfVO7xwInEsZd1UgTkAruV6thA35IwTOhzryeLkvDukqyn3GechJlGkZiNHhL+9f1b/4sHUTwfH5B1fFG8l+/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743751549; c=relaxed/simple;
	bh=Nv40ECzNNtgE+yLTEjb+4x6pUNaEpM5k815fzZGVmBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbDJnp70SzMpWblFjRjm1N1w7NmChj9GkB3BA98uTQHAFLP4AEwifUJPxL98JesrlxN3mVDoquCpkGD0+po/63pFb5xRoItyDVBtK22vyioR4haT/EZguquL13EtnASVuZwyFPFnWYlkzzyLzq6kJmidAgyk+9mKQmfDXGsOqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Rgd4ruqC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf257158fso11370095e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 04 Apr 2025 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743751544; x=1744356344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyx1GX4Pz7oJFjgTe+pwU4vcsJUvohj/pJ1YlNZkH6M=;
        b=Rgd4ruqCcCb5Qt2cEKPjdRS5/yPbMBsxvFuYW0nJCTPe8Yea4GYa0bUweYtglXTRod
         tCrhYsr6ASQEplDXrQZZBYk7jXtZsAtfq017Xja+x4BcjgtM4CHPwx5pObSXGy9P+axJ
         X9cvDnb3Xr2vBDfxyzNlyScoYp/E5Kvs/a/rf6nJWfxZhTnREMphE1LP8CoOPBDYP7na
         HK3aiIOMFv9ZC70iE2l/sK72YI9G4jXXfvAG3akrKj1JYrLHp/qGKbxcyymxr/shvCOC
         SS6h46KxlrvyBp8grNYCHD9uNlNvdCmUicP6qtdnFtSmAcVYoOLGhkYvIDzcCRuL5SD/
         myMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743751544; x=1744356344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyx1GX4Pz7oJFjgTe+pwU4vcsJUvohj/pJ1YlNZkH6M=;
        b=OjIDJQXWT5umPEdY6o2x/HLlX3/s93MFERFGgJaD7lNmTDB5qY0gMVWm4mcAT4CYhN
         +yQyeKsOtgNOyIPLUFz/IQmGiXOZvQ9dIV4mZ1TlScDoPxMOFNVMYAzHA3y23XXyrQn2
         9o07a9OGkZPWhPPilT6ZpVOJIF3rPGZ4ykXTNErwKbpTCUu7R0YmzZBjbQ4HvYIC0ODj
         ryKLubAI1ip8WHHp5qhMKWed/UUXhZLrLPlHLNZAVfpR2kfBkezqHt0dI0i6yxeVoenk
         /THGqWEBS8CSJvjkb/C7/+XD8a3qu1K/gED47X48RGs8dWAilfXJUQdMJJgUOuZTMEml
         5Pdw==
X-Forwarded-Encrypted: i=1; AJvYcCWUprR5WYW7jBvgwQNBIeHKUJ4/OdHt6YnOOOHYier0H5h5x5eSW7dp6cTlQjKB8iEB5ua97ItZ5h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUpco7GBWDj8S0pkTgM7KcyDHiDw4mA9wrCSd0yBGUK6lRiSA
	fWs38vItghpHkhL8QUWvwywrOOI/saepL9f9K5Js7lgN3deJmmZZMeCA2FRXLDI=
X-Gm-Gg: ASbGncu1SJbqT4kEdSuPFSnR5U7H05yhlLASDc4nP7fiXesrWW33MnihgyAAc3fuiZh
	Yl+cMGO3STC6EaOMQwKdBecARASLIMSwGTEDqmMpNJdIlVy6NAdvFXJtLaONWMGyB8UVUdSZmrs
	DvQ0n+4iQpzmS3k9Ad9X8ro17bqxvG4rLvG9zyx1M7EWqvXK3AHCxb2+Q20ucuOSYicek3CygqB
	UUXdu7Lq8TXBrXCuPZ5CPex69PkJM23xhqr+o14Fl6LZ/6oTOoDTZrYk6KVSuogGeFLct1hE5Sy
	fj5b2b08rKNwJ3Nke7a6VTanyZzsKmzlRU3Sx1CZD+J980NTUkDvFaEm3IGCuNsn8JnVKhbdgAJ
	9HKjo1Prs/5A=
X-Google-Smtp-Source: AGHT+IGl5weI27ORb52nYASuHzz5ZOcVy9gSOcRVIKR36Nf1VkzNkhx+6dySUJvFMjtdN0jANovJYg==
X-Received: by 2002:a05:600c:c07:b0:43c:e8ca:5140 with SMTP id 5b1f17b1804b1-43ecf9fec23mr14301665e9.23.1743751543683;
        Fri, 04 Apr 2025 00:25:43 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c3020d938sm3658877f8f.65.2025.04.04.00.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 00:25:42 -0700 (PDT)
Date: Fri, 4 Apr 2025 09:25:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Simon Horman <horms+renesas@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, linux-pwm@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 2/3] pwm: rcar: Improve register calculation
Message-ID: <vioka33ydwo5x3drbdypwc2z7gb2ia5kcs2bzniu4m7pfbj7ho@okccu2kfc2zs>
References: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
 <ab3dac794b2216cc1cc56d65c93dd164f8bd461b.1743501688.git.u.kleine-koenig@baylibre.com>
 <f8d83f02-4a9b-22d4-bfbd-4949f2010007@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6lceaa5canzc3x3w"
Content-Disposition: inline
In-Reply-To: <f8d83f02-4a9b-22d4-bfbd-4949f2010007@linux-m68k.org>


--6lceaa5canzc3x3w
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] pwm: rcar: Improve register calculation
MIME-Version: 1.0

Hello Geert,

On Fri, Apr 04, 2025 at 08:48:47AM +0200, Geert Uytterhoeven wrote:
> On Tue, 1 Apr 2025, Uwe Kleine-K=F6nig wrote:
> > There were several issues in the function rcar_pwm_set_counter():
> >=20
> > - The u64 values period_ns and duty_ns were cast to int on function
> >   call which might loose bits on 32 bit architectures.
> >   Fix: Make parameters to rcar_pwm_set_counter() u64
> > - The algorithm divided by the result of a division which looses
> >   precision.
> >   Fix: Make use of mul_u64_u64_div_u64()
> > - The calculated values were just masked to fit the respective register
> >   fields which again might loose bits.
> >   Fix: Explicitly check for overlow
> >=20
> > Implement the respective fixes.
> >=20
> > Fixes: ed6c1476bf7f ("pwm: Add support for R-Car PWM Timer")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> This is now commit b41a4921d409c909 ("pwm: rcar: Improve register
> calculation"), and has the missing include.
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I added your tag, the commit is now e7327c193014.

Thanks!
Uwe

--6lceaa5canzc3x3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfviXMACgkQj4D7WH0S
/k5X5Qf/VT5Gta/CcjoRf1GYfQFvfN/nst1EUtuy0We+xAHvbB0OaNRyI9IA6u7E
x7cgQGwivHGTN28geEI+fXjmkQ/qoshuY0r8YLNXlKgf0PGJhT7yuIoqilBN9hit
118LlA1I+flxm3Xy+viHKhmdIPHJZVfRjxiwnmiGnKoUW6xkC5yU5KVHaFf6q7TU
ZbjPdJ7eiC0D55SkvL3xqv2SryeucFgX+TZk/k1iWQq2GahVjTPXETvkvzMQrwLP
/dlQnX+PXq/4mBDr87P0q+YOsbWeXFygau5OniAmXxsKvQSH8lREz32eiToQMEQu
6MbJLfPf2KTA2MGR3n5NLssvN//ReQ==
=6t3b
-----END PGP SIGNATURE-----

--6lceaa5canzc3x3w--

