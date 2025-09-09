Return-Path: <linux-pwm+bounces-7276-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D535B4FC34
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 15:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202253A2185
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1831C571;
	Tue,  9 Sep 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IQ1d6tuK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2721B9F6
	for <linux-pwm@vger.kernel.org>; Tue,  9 Sep 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423822; cv=none; b=AOjtVdvltpt1L1RhAI2ZPGpn0O4YYYjhYzcTdFmbYb6azjzV5juZcSoDeJmRs5/imLL1F45SKOhIiBsRDt2mfhPqcJiGi6hoWiTKlrZUOYF2FiG1NokuzMtiVe+TIXL4PO/O6Bw1r61lsdIaBYobEmw0QxVldvaiZYRgOt1nWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423822; c=relaxed/simple;
	bh=njG3LFyIk9lOK/0Fwe0ao7xj9bNzObnhRx5BUKhzFJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzunhqYDt/8DCdcvy48pP2aBJgtNQFzLC0kwSFexBXtnOZcdypBbZsRGZ7guNuWvarYxreJXi2SLay8vZ/748jErUSio80qBjY9Fdh/47d8X4KWAAmxd+gbpDl5/L6mZUDNkwJZrpD/JHRnUCC+Y9gZZ9PwY5EoYEgVkaM/82BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IQ1d6tuK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e5190bca95so2004219f8f.0
        for <linux-pwm@vger.kernel.org>; Tue, 09 Sep 2025 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757423819; x=1758028619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdo9zUh3cC7JZ4YMFIK1It9t13duwlrpE1xo6oVXcCI=;
        b=IQ1d6tuKESQPX32N+lZB9IPpoBqJopYTlu7RisNoZJXDPI+bOfH/l79xp4gROYbPE/
         fyCGSUcozm9UXtyXvd55yp5BJfFeL6OftpYQphXlXQQw4/Jm0CpMxCirHNhfFldAvlrR
         ibWERWhMUkCHMX20ENHGi7WCanMvZMq+rhMb/Sv/uuYQyBwSK81mHg/V6u9DNWjyKIAQ
         I78G8efJKAIFU7BV17wZgDtMG/7m8A/Ep2t8lu3TRtOqq31CO7DmiF7lPXWuALlrSYE0
         +Gzn1WMGwJc3EkzqqOFUUkqRAudafP1AWqXGnl4ipQNSojCZTquYJgh9GOBeFELdzdlO
         U5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423819; x=1758028619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdo9zUh3cC7JZ4YMFIK1It9t13duwlrpE1xo6oVXcCI=;
        b=bja6dXW9QBydLyKT8siT02BQJZyBUEUh2lg9VQpNoULRNQLNduEmr8/CA6yRO4rARN
         XLvnPBCJK0L7ZjFHRXo8EvvUDLM0IZn77PrSsAjibqZ16HWMPxqPjHxVStzyWL4ONYue
         WTbgraL3k+Ix8nd57ndmR2kQCBouYLNrMOnUNQmfq4TH4NRYI1yhNMYyJ/arM0fynsbA
         EsK/rXy9SaTWDS2Xg2l+KZIOHPKd1rZk7Ac4AJIHmQgeY4WG5E63ouJX1q3Kyn51RHwF
         +8QI8zjws5ugQ7HCpF2/KA+Ub+yKluLStjB5cZ/VgdMAaHwVaGSd4Uu7HT3r9XChoO0T
         kp+w==
X-Forwarded-Encrypted: i=1; AJvYcCVZCxuQOz1uE6bbm1zevVVAB9gU4lcpfzUlVQo/aoFlulUy6ZNcuoXOqia0jF24erS1NypkGLuNy+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0MwhPspNB/DyrDFJMKi7agJ7+oVQiIn+2yq3nlrsVDRrARrul
	qjADjeiWi8jmuK2okq7wUihjralOANV2vj0SWdacsk9wS1gfnWCJ+4+uFMlf2crSh5c=
X-Gm-Gg: ASbGncs837KnNu3y+smxh1JhBwWOFUasbR1a7gBuU40H/wu9n2vsAJu5BqViKUW7JnR
	FGsvqX8NeTOCSFlspp2pA9yA+enH+bV6ZCELGjWuiW+lTv8gSRCcZ+TWiKia/YA29nCogwDiCKr
	TnEjmDfVewBwHFmpA3OoV3gya2IEIR5ridv2ChWwto7I2Ux2XiCYkMvkob3WgnsHnE4DY9RnNfc
	0sDWKStITd4O004e4GbNZEh2ELObVLpE0BqrwrlHzEUzAZyU1RpOExr3rjzMeUjogihYTM/6XjN
	16RnaprUT1HmoTFWChB1oHsceV9nH+wwDZpBBsWdIgeJl4rGJ488nEbHcBC8CDSVG+y/1SN+4hU
	v5+am6Vu9QEXdBFUPUPD43ne2E/NKkDAXW7d6mPIOqGfpeASePqIqt9UfQclTq+cI
X-Google-Smtp-Source: AGHT+IFhCowW9gu1/w93obIiBVf6Vuc4ShjzL0HEHZ6PJqdOO6o5Jz7iReA+oY0Aa+n+lLDZfcOsfA==
X-Received: by 2002:a05:6000:4211:b0:3e5:d2f1:403d with SMTP id ffacd0b85a97d-3e6440ef05fmr11560309f8f.36.1757423818701;
        Tue, 09 Sep 2025 06:16:58 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7532f90e6sm2066036f8f.6.2025.09.09.06.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:16:57 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:16:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel@riscstar.com>, 
	Flavio Suligoi <f.suligoi@asem.it>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: mp3309c: Initialize backlight properties
 without memset
Message-ID: <d3mnxjbtek2q4465xgje2orjbzmbrkcicapal4apiqk3hc3hbq@3jp4yytvtmfc>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>
 <aKLvaP55PIVhyFSc@aspen.lan>
 <20250902103632.GH2163762@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dbmzc4rcf7ixa6l5"
Content-Disposition: inline
In-Reply-To: <20250902103632.GH2163762@google.com>


--dbmzc4rcf7ixa6l5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] backlight: mp3309c: Initialize backlight properties
 without memset
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 11:36:32AM +0100, Lee Jones wrote:
> On Mon, 18 Aug 2025, Daniel Thompson wrote:
>=20
> > On Tue, Jul 01, 2025 at 11:22:37AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Assigning values to a struct using a compound literal (since C99) also
> > > guarantees that all unspecified struct members are empty-initialized,=
 so
> > > it properly replaces the memset to zero.
> > >
> > > The code looks a bit nicer and more idiomatic (though that might be
> > > subjective?). The resulting binary is a bit smaller. On ARCH=3Darm wi=
th
> > > an allnoconfig + minimal changes to enable the mp3309c driver the
> > > difference is 12 bytes.
> > >
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> >=20
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
>=20
> Looks like you cannot send tags from non-related email accounts:
>=20
> NOTE: some trailers ignored due to from/email mismatches:
>     ! Trailer: Reviewed-by: "Daniel Thompson (RISCstar)" <danielt@kernel.=
org>
>      Msg From: Daniel Thompson <daniel@riscstar.com>
>=20
> I'll add the tags manually this time.

FTR: The email address *or* the real name has to match the From: line to
make b4 happy.

Best regards
Uwe

--dbmzc4rcf7ixa6l5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjAKL4ACgkQj4D7WH0S
/k5BrQf+JX3ho13wgiKmkcJ0Tjb0+y2mxhAU2VHfSxu0jGL6GsKb00SZXQ7/bQ0y
FpqkmXr91kb5uhg5pOQL0D6W3OxwLRFLf4XfOL84TaAHintXN8gMBOsJA+Pn9iIA
5rqGHhO7dT4zJt9SmdGVn7f9VBu2qdvo4wpf/tvzlIcYTYFGD8W/giikgRQcJcI3
Hb3zRDIrRZWcNfHoN7yGFYC13iL2PyRFns/eyw+YqzCud+fHvfHbWV89l8LEzNod
iwlF/fHCaSa7fqG154A0PgXPyF3ltgNwwi0RUNiwAtX/i0WcZrWYMavCTToq+SgE
KrERYvE7oOdpFcIJNmXdRWQYyeDDZQ==
=qQ6Z
-----END PGP SIGNATURE-----

--dbmzc4rcf7ixa6l5--

