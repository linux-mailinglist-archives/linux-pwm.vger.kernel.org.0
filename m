Return-Path: <linux-pwm+bounces-7055-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44241B2692F
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F299A602C02
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C8212B1E;
	Thu, 14 Aug 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Taw12qG1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB3212546;
	Thu, 14 Aug 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180541; cv=none; b=XuRPFmjA6qFr8OGMzIBYewP390wIVnCEjdS20+QhtFixuO92BbPlC9slqPxJ6rBANcMNCCQcoJCjQgQQpBWqLk0fK/jGMLDnFHpJjy5kn1vBGpQ8i9pQgH5b/iiIwGcSqAPy4i7uuLc+0cgd7Dka5SojbSivuDl7kbRO3naxYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180541; c=relaxed/simple;
	bh=KoWgzximSrrSXOKG05+Ln2RZTFfG6mhzQE07XNVMxr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di1B6zQsccKFZ+zsY5qKl8Fwu2dYJ//OYNXT23ix573oDHw35r7O1wVOMINcwlVfhkwIgSIKVntpG3sBjsGzCV63sOFNSs71/W1e+xZMcKwjwUwBn7WIhl6KoU/rXDo4TQHYbYC4siSFyGqP6w0Le1NMSyzH0PwIAXODuwBP9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Taw12qG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163A3C4CEED;
	Thu, 14 Aug 2025 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755180540;
	bh=KoWgzximSrrSXOKG05+Ln2RZTFfG6mhzQE07XNVMxr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Taw12qG1musZlOg9O2MJdjAn+r2utRcPjMH9lo2Gx4scEDioXCFvdglOn+buWsSPO
	 TWP8z/lZXaJeXSLJC+lzFQTe36YJbtPkFHqcpH1VytyXBVTfSRwJPGvJI4hIPlG6rr
	 NmRsu9HjlOgmYHNTVCVdIa5TIIorSHLjuGSyYZZRadR2B6XRYjd4KusYoiYLxLIdN0
	 qxfTVIF5mWJFwebr0eKSbDWX2pTwnhPm5zadc8yZwF0HlCSs03x/fl6xnVEd/e8bBg
	 BHTtd2DePzkEG2QRrZQZejExx/HxUBICpPqwMod3zylWJ2YBwevKDI+AeVqgeYnZcz
	 O2fvFiAJfd12w==
Date: Thu, 14 Aug 2025 16:08:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] pwm: cros-ec: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <mlvple4tcnvu35a2liva5wxhafshc634fu46kwyrepn75wvuec@udshn3ja6lvc>
References: <aJtRPZpc-Lv-C6zD@kspp>
 <2pgdxifg2zmyhvemm7a2qntprsz5nhh3ustrrlg2vvcqffwj6c@22enjpgycjbt>
 <4b9eea66-f004-4b5f-bf48-4c32205cc8ee@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fuq2btbbfpvvuy3v"
Content-Disposition: inline
In-Reply-To: <4b9eea66-f004-4b5f-bf48-4c32205cc8ee@embeddedor.com>


--fuq2btbbfpvvuy3v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH][next] pwm: cros-ec: Avoid -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Thu, Aug 14, 2025 at 08:48:23PM +0900, Gustavo A. R. Silva wrote:
>=20
> > diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> > index dab49e2ec8c0..8ca9df87a523 100644
> > --- a/include/linux/stddef.h
> > +++ b/include/linux/stddef.h
> > @@ -108,7 +108,7 @@ enum {
> >   	union {									\
> >   		TYPE NAME;							\
> >   		struct {							\
> > -			unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];	\
> > +			unsigned char __offset_to_##FAM[sizeof(TYPE)];		\
> >   			MEMBERS							\
> >   		};								\
> >   	}
> >=20
> > which only leaves one usage of FAM in the name of the padding struct
> > member. I'm sure someone is able to come up with something nice here to
> > get rid of FAM completely or point out what I'm missing.
>=20
> Flexible structures (structs that contain a FAM) may have trailing paddin=
g.
> Under that scenario sizeof(TYPE) causes the overlay between FAM and MEMBE=
RS
> to be misaligned.

That sounds wrong to me; are you sure? In that case allocating space for
such a struct using

	struct mystruct {
		unsigned short len;
		unsigned int array[];
	};

	s =3D malloc(sizeof(struct mystruct) + n * sizeof(unsigned int));

wouldn't do the right thing.=20

I found in the net (e.g.
https://rgambord.github.io/c99-doc/sections/6/7/2/1/index.html):

	In most situations, the flexible array member is ignored. In
	particular, the size of the structure is as if the flexible
	array member were omitted except that it may have more trailing
	padding than the omission would imply.

So I'd claim that sizeof does work here as intended.

gcc here also behaves fine:

	uwe@taurus:~$ cat test.c
	#include <stdio.h>

	struct mystruct {
		unsigned short len;
		unsigned int array[];
	};

	struct mystruct2 {
		unsigned short len;
	};

	int main()
	{
		printf("sizeof(struct mystruct) =3D %zu\n", sizeof(struct mystruct));
		printf("sizeof(struct mystruct2) =3D %zu\n", sizeof(struct mystruct2));
		return 0;
	}

	uwe@taurus:~$ make test
	cc    -c -o test.o test.c
	cc   test.o   -o test

	uwe@taurus:~$ ./test
	sizeof(struct mystruct) =3D 4
	sizeof(struct mystruct2) =3D 2

Best regards
Uwe

--fuq2btbbfpvvuy3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmid7fYACgkQj4D7WH0S
/k5blAgAh5+IokY92+K/+9z3K4qgh2F2Qwfe9kLJkliHAtW0BjPXsSmvDfrl6liX
GHh7M26217I9OMG75Bhpl8C+jpzN6EMtRsAD/zFcdDDl/JACrm7yO56/FcVN1rER
vjf+3ExMbV/ZMhRKY+Rsp3LCAbkkuywX6g2Lr7lDWmu4L/RyEGi1lSXVYSgMGvpi
npJhS+qEtbbHXT2eUQCR/e3aQHHA/PUSPvvXsJ7u5fVDCQzTz6gluHY0zrtXl5su
jXZ4C0ux6veyfj7S7m0ayFZRRdavN2SOhBVcWSIwNewhGFjQZCAuFBZ6ht9TzwyF
nL6IkD2TrBgj6T2mtyWwmt8eHuM4tg==
=CpNn
-----END PGP SIGNATURE-----

--fuq2btbbfpvvuy3v--

