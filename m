Return-Path: <linux-pwm+bounces-4839-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B72A2F71E
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2025 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDED3A6DA4
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2025 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC212566F3;
	Mon, 10 Feb 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s+MtNltr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A224FBFC
	for <linux-pwm@vger.kernel.org>; Mon, 10 Feb 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212274; cv=none; b=BvdZv4U7yf0b9Ns7g7iL/m6Gnx9sYlBKDFuIeDVG6taCZ+IaIud/ZwptYAGZOcSGaP8zX6IYtSEPCuASsASUucq5roMKa8AfmOWrmnZgpqQmIgHf5xywzGe01f+FjrITY1U84CRD1GZmucI4YQbMyHxtItHNvfZIWg4kJuwE/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212274; c=relaxed/simple;
	bh=etzPapOkZJ8GDSELu2V0389CvMEeFoZv8uZUDou4T6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ1wgEiLDWnqDk5fG1fWP3rEKuYM8XNX1A+yp0hAVOKK+JORypSx1WqYiZvDQ/aJpo080roRq3FBiuxsl5gOE0nvQh585nPnTLNfFhv3IyeG+sClQS5CjKS7XlVWCetF1oxmJ+db4faMkxHzEU0ScN2yLN8vqUtGpSwDFV4ChlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s+MtNltr; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ab7a6758b7fso390968766b.3
        for <linux-pwm@vger.kernel.org>; Mon, 10 Feb 2025 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739212271; x=1739817071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRoVYFJvOYyL8xWCdpgS4WvSxBvenJHq66eRRrS+VXM=;
        b=s+MtNltr6LgKroLh9xZlfY2OrgKdtTqW2OBAm72OFQ7zE37mfdPirqBfGnNyFg1sbL
         6vVcCYRdbFLJ6MdXr9XOHw0Ti5ipUBnOvQ+RE7VZCM92PQ0NgO4ki5SBChQF+xNyUuBj
         5oOSWF40V75w0nWMTOjE6lTAf17TKeUYwSqk8XvO90R5c8qklz6pFY3tnc1Q7sE74/kw
         fMCZTK1xAkiU6wTzWGY54sei7iUv2skWmf1L1M2uWpQlvswCCQ6YadLNbJ1ynYuudKGW
         KgWLxazj1fwANp5sNP6pcZ8hxksRitJIlopK+YelIuhQYX4+31BrfdhlK74DpqYMv4h2
         Flwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212271; x=1739817071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRoVYFJvOYyL8xWCdpgS4WvSxBvenJHq66eRRrS+VXM=;
        b=Zyns0qKdFDgwePszIpezyrmo1O6s5msYwClkNL4L5gMuxjKFYMqEEVg9JQJkGDjXtM
         jl/dwH7g+nvZk62EHvtlwgjkA7AgDiZoP3FT4appc4YL3voZTRWcJhRv29p/Zf9WWjJ3
         csv8PBYCEXzF51+eKV6H3+N1nx/M2T8dg050wNaNgz3aQmORerRDnW9kzqze4Jqixewk
         lN8Hs2gC38L/HqhOd3ym80YDS2qfHp6A0hZWNZaN9ek6jYoQe+5umRVFT50fFTpZTkMU
         z9Loxb2EV1m38GNKbk8RwNXaOtIdA2omwMAbGvBRpvnT8CwgAbejgAhO/y7sX0lYRVTe
         l/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUpdEvWOi6ztCowxJv8DjAqv3PUI2e1zA9HZwqYXM/7h3ocq5iRwQJlb0LKiWr1ZgDHDNKhD0Oc4vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcni6X4hEqDzYR3dslV2DIgZ8sH92QmHDp04lY/Puj6qEFB2I
	JHiSaZATxu/A26sTfs7zn6o0W7fPisNWWXdCNEmXwL5MmAC2B8l2uPcOw3ZuxEU=
X-Gm-Gg: ASbGncusHeklMSoRNpIYA/pmD3iF3ax+k5bCqXIM+sMxRNJGf5BkMPgjcCm0OL+2Zyp
	KxKCuYTxxyUi4ucG5zVWhxOd0F2PsB8+WumxLQ/10SGgtu+Alno1YL/SOI3LrxKqvo97vm5vNUn
	9wQ1+EttF4hSLCG+HrCCJpPfrXWwpHfIeSUMIQqzCTn4I1y7HLGubPAE6P0w5Z5YsVc+cevJMgs
	C1p7lKDxaSPA6jhJyWgF5o+9IMT/qLw7fYaay+mIzKW0X3LPwmrxkXqBsILvHb/CSN2fuwqDwRV
	5TNn0m97H7l1F3tH+TSMSJR7uTR2fvkpjkjJfEcT+JoV/WoaUaS1/7FkDw==
X-Google-Smtp-Source: AGHT+IGxnUYjEIEFumIffoV7za36A5epYh//QQ89hdBeu7W4Q3SvvoIDdRj/qSFbZjMv9ioyPcD/UQ==
X-Received: by 2002:a17:906:9c8d:b0:ab7:c1f:2b63 with SMTP id a640c23a62f3a-ab789bca7e5mr1713691266b.27.1739212271071;
        Mon, 10 Feb 2025 10:31:11 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7aab8d8fasm487594166b.58.2025.02.10.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:31:10 -0800 (PST)
Date: Mon, 10 Feb 2025 19:31:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, 
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pwm: pxa: Use #pwm-cells = <3>
Message-ID: <lzlzq4fh3762kyezzr7eqnbkgsu6nbvzgi7yqzwy5tbsrb4tg2@gdpjz3cqrqq6>
References: <cover.1738842938.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cuu5yijfy6peiu4x"
Content-Disposition: inline
In-Reply-To: <cover.1738842938.git.u.kleine-koenig@baylibre.com>


--cuu5yijfy6peiu4x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] pwm: pxa: Use #pwm-cells = <3>
MIME-Version: 1.0

On Thu, Feb 06, 2025 at 01:06:24PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this series' goal is to soften the special device-tree binding of
> marvel,pxa-pwm devices. This is the only binding that doesn't pass the
> line index as first parameter.
>=20
> Here the #pwm-cells value is bumped from 1 to 3, keeping compatibility
> with the old binding.
>=20
> The motivation for this was that Herv=C3=A9 sent a patch introducing pwm
> nexus nodes which don't work nicely with the marvel,pxa-pwm
> particularities.
>=20
> Changes since (implicit) v1, available at
> https://lore.kernel.org/linux-pwm/cover.1738777221.git.u.kleine-koenig@ba=
ylibre.com:
>=20
>  - Use #pwm-cells =3D <3> also in the binding example (*sigh*), pointed
>    out by Rob
>  - Add review, ack and test tags by Herv=C3=A9 Codina, Conor Dooley, Duje
>    Mihanovi=C4=87 and Daniel Mack. Thanks!
>=20
> I intend to take the first patch via my pwm tree. Assuming the pxa and
> device tree maintainers and bots are happy now: Dear pxa maintainers,
> please tell if I should take the whole series via pwm, or if you want to
> take patches #2 and #3. If the latter: Do you want to delay application
> or should I provide an immutable branch for patch #1?

I applied patch #1 to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
now.

I don't know yet what should happen to the two other patches, but maybe
it's a good idea to wait a bit anyhow to have 3 cells working for the
pxa driver for a kernel release or two before we switch it.

Best regards
Uwe

--cuu5yijfy6peiu4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeqReoACgkQj4D7WH0S
/k4VkQf6AzUwWcUMhatT49kzLrH9Ik8W0qT2EHQhxjiTKiZvylgEcKffpbQkdE63
S3rsHNK2V+sauwfreQSx3KA4YW95TWhVfjGOS/aij1mL4Plse94GOCEhw8zLCzsc
HJi4SKa3A6BPsuRYLuIqdNcgKh0HYEXibFojcux7CKSAyfS9mk9K3WsEuCpw3MVV
6Moq80l2BVV82SKZ9xR9iANgDIxji9xFJpMRTNcK673fnq8++TFwevwzB1u/iMf9
MitOOVkNj5+X/oYZwDZAneQLABUE/qDeYzWEtU6P/2KuT3RiTmP0rGAPcHlzZwIb
GkiTBJZ6Xu07fhBuP9ceT5liCF7+NA==
=GLjj
-----END PGP SIGNATURE-----

--cuu5yijfy6peiu4x--

