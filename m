Return-Path: <linux-pwm+bounces-7316-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDFB574F8
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7675316D255
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236BC2F546D;
	Mon, 15 Sep 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doMe+Eas"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D07189BB6;
	Mon, 15 Sep 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929004; cv=none; b=b66hlf9Tk8mRG6zugsRZHq3ruapgmHvbH4IQP2Nh39lhViMaAhGRYNZMliUrCDjsziQjoPA1nPUm6Rb1UQV5LnVpN61TZ3gSpfmqX63BQiWAnIHvLFyZK4cQcvN6dgE0OMqtBcmsFTvGAoalvyE7CBSqcLkKrv7lpt2v3RfwBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929004; c=relaxed/simple;
	bh=o8egUwKVNRfMUymwpa7mC1b1hnq1Hnwp9A7gj+Gh8/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+NeGXgcSOzrX/D6EsbmrQFHotVROrehVl2yHcUU9CVNJkyArK+czwLumBW0rF2MalStqcOXsmHtQo3yJ/F31VxTz4lQlmzNSIdA47wECHwmVklEiGZqdSeDEu9mUSFgq+ztqfbQJSY8HAjkGzfRxBOxZqR7iw5icpd//HYvbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doMe+Eas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17955C4CEF1;
	Mon, 15 Sep 2025 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757929003;
	bh=o8egUwKVNRfMUymwpa7mC1b1hnq1Hnwp9A7gj+Gh8/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doMe+EasFFNVISoxJn9HwkU1XAMZRD4FDdbsW5F9iJZOzBBFcrjoGaV2dpbeUqM8f
	 qWvud8qEXsot2NxsCJMoil0sQ2HfIxkVWA15f8tfK6zhT3IX7A1pEcFnaKaI72Fyk3
	 h0PA9Uk9JEfeLZkPHPnPq2Z6OleYUP9HlvpigwchdYBtMqWtrkxheAyG8T41D5KZq5
	 5qI7qHlZHPlaXoxoq/0+6POCZqUmf71VFDy2xstQUvX2Zrn6lKyQSHqzi4IihS03Aa
	 GKbqW824PjHUDrc64I1HxkUgJ/fWsfU2YDVlZMYAQQ/7k0ZEfP0iM0Gs7QWS/TcjQ1
	 8pyk7KtJUlAnA==
Date: Mon, 15 Sep 2025 11:36:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] pwm: cros-ec: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <pw6lpxztxeg2sjwk5mheqlv4scl3zzhhpegnawf5umap6rxe4y@yckkngbinoy2>
References: <aJtRPZpc-Lv-C6zD@kspp>
 <2pgdxifg2zmyhvemm7a2qntprsz5nhh3ustrrlg2vvcqffwj6c@22enjpgycjbt>
 <4b9eea66-f004-4b5f-bf48-4c32205cc8ee@embeddedor.com>
 <mlvple4tcnvu35a2liva5wxhafshc634fu46kwyrepn75wvuec@udshn3ja6lvc>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3lzyo2zdayjdgtj"
Content-Disposition: inline
In-Reply-To: <mlvple4tcnvu35a2liva5wxhafshc634fu46kwyrepn75wvuec@udshn3ja6lvc>


--q3lzyo2zdayjdgtj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH][next] pwm: cros-ec: Avoid -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

Hello,

On Thu, Aug 14, 2025 at 04:08:57PM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Aug 14, 2025 at 08:48:23PM +0900, Gustavo A. R. Silva wrote:
> >=20
> > > diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> > > index dab49e2ec8c0..8ca9df87a523 100644
> > > --- a/include/linux/stddef.h
> > > +++ b/include/linux/stddef.h
> > > @@ -108,7 +108,7 @@ enum {
> > >   	union {									\
> > >   		TYPE NAME;							\
> > >   		struct {							\
> > > -			unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];	\
> > > +			unsigned char __offset_to_##FAM[sizeof(TYPE)];		\
> > >   			MEMBERS							\
> > >   		};								\
> > >   	}
> > >=20
> > > which only leaves one usage of FAM in the name of the padding struct
> > > member. I'm sure someone is able to come up with something nice here =
to
> > > get rid of FAM completely or point out what I'm missing.
> >=20
> > Flexible structures (structs that contain a FAM) may have trailing padd=
ing.
> > Under that scenario sizeof(TYPE) causes the overlay between FAM and MEM=
BERS
> > to be misaligned.
>=20
> That sounds wrong to me; are you sure? In that case allocating space for
> such a struct using
>=20
> 	struct mystruct {
> 		unsigned short len;
> 		unsigned int array[];
> 	};
>=20
> 	s =3D malloc(sizeof(struct mystruct) + n * sizeof(unsigned int));
>=20
> wouldn't do the right thing.=20
>=20
> I found in the net (e.g.
> https://rgambord.github.io/c99-doc/sections/6/7/2/1/index.html):
>=20
> 	In most situations, the flexible array member is ignored. In
> 	particular, the size of the structure is as if the flexible
> 	array member were omitted except that it may have more trailing
> 	padding than the omission would imply.
>=20
> So I'd claim that sizeof does work here as intended.
>=20
> gcc here also behaves fine:
>=20
> 	uwe@taurus:~$ cat test.c
> 	#include <stdio.h>
>=20
> 	struct mystruct {
> 		unsigned short len;
> 		unsigned int array[];
> 	};
>=20
> 	struct mystruct2 {
> 		unsigned short len;
> 	};
>=20
> 	int main()
> 	{
> 		printf("sizeof(struct mystruct) =3D %zu\n", sizeof(struct mystruct));
> 		printf("sizeof(struct mystruct2) =3D %zu\n", sizeof(struct mystruct2));
> 		return 0;
> 	}
>=20
> 	uwe@taurus:~$ make test
> 	cc    -c -o test.o test.c
> 	cc   test.o   -o test
>=20
> 	uwe@taurus:~$ ./test
> 	sizeof(struct mystruct) =3D 4
> 	sizeof(struct mystruct2) =3D 2

My claim is wrong, while sizeof() never gives a value that is too small,
it might be too big. E.g. for

	struct mystruct {
		unsigned short a;
		unsigned char b;
		unsigned char c[];
	};

there is sizeof(mystruct) =3D 4, but c starts at offset 3.

Anyhow, I applied the original patch now to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

; the discussion here was somewhat orthogonal anyhow.

Best regards
Uwe

--q3lzyo2zdayjdgtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjH3iYACgkQj4D7WH0S
/k6/BAf/ZxOgLU/eXjlpr8Wkqx/8RBOPj6AKUELAGmT737Gz1YQ8MC1JGtImGaqk
xyvLDBepUgDwpn06RX1mjJ7Q9gd3rCT+IgqTKCOP+cHYZM6kQJNyQT+K7t++7i1Q
8rEsGlJiqy34iLjn5xUwydFwbjKikSeR4h3ty8yqEjfMkgK1224DPtKc0bPPI768
jJsKh7zjhJrPtThaS4GCVi4L9GPU2qjCups50MCPWpeP0obC3vA+t4J3JUdS2wWh
hu+S/OBbTYrsWJPUPC39IyVInucEZYgTQ3JVJQ7vy0vYfCIk194Z3qhsuwyi/+Zq
KwzFIo0PRa0iMrL7VFjqVjQ0Rwgx6g==
=ZEL1
-----END PGP SIGNATURE-----

--q3lzyo2zdayjdgtj--

