Return-Path: <linux-pwm+bounces-6455-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4EAE18D0
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 12:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377C2165C95
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5E283C87;
	Fri, 20 Jun 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDdk+xum"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6D199947;
	Fri, 20 Jun 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415268; cv=none; b=CO1nbDEPPL9FbY/Sk4viCCVv4H4DTQy3i2ZAZltq4PD3HessslbGzALq8W/QS3ezZutBlU4ATlVxXycxEGw5pSXcEQbXWQeg/Vek/qZfqYPtO8VAPqHL8qLIDPeGT9baUYbrxniAKcIFi4zqZ6vYFodToBumgyjUYZru6SvT/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415268; c=relaxed/simple;
	bh=8ZaXuRIcCN5t1dEdAZ8c4UKN9AUODzeOKp5agQy1JNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbNV1zlxrvOa1oIbZhCkxgHxVYaWoqxXxcP03tZ5e3q4I901Uogty9g75kP3jwOYoJSgz7KiSQP4U+eNKGiH0paHPj4Uf4znsgxUv7YfnUxPkMPmT936XYqoqYedtr5I2Qn9+6jSbJWR7qN4++HXeAMPPowuHc4sJGCro8MF81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDdk+xum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479CCC4CEE3;
	Fri, 20 Jun 2025 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750415267;
	bh=8ZaXuRIcCN5t1dEdAZ8c4UKN9AUODzeOKp5agQy1JNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDdk+xum4CQ3J1mF/DGW1PGg2u89KQk/gjS7/HKD1c4e01QdSlosKtr4KGRjAMOTZ
	 AuNFHwaMbm2FeuTR88thtQ/oWfNyE5dffYaVSVqY2KQfmw63jFNBsaBvobnsOBFM++
	 691ba0s2wtCCmJ+ciQIEd+6o4ND/0rQ9OadKg3zLw62J8dp9BJttTjG81iPbXF3yKK
	 4cMPMMPdAf6jX2h1YeHj5zaNQtQh4mH7LG3/WSlI5b94XfaaGPrJk+GY146PNT5EtI
	 IL2KDy+rUJmn6Q6bFwnKki+uLC06eG9qrcd6ZvwWSocNQiIlPxjRBQBg7e0vjTtIHj
	 93X2tvQqyuRwA==
Date: Fri, 20 Jun 2025 12:27:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Rob Herring <robh@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
Message-ID: <foiatljwemu3owuogzekgiydcyedxbhb2nyvzbs53zuxx7yohs@atpwrceby5fd>
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
 <20250617092037.37229-2-marek.vasut+renesas@mailbox.org>
 <20250617133744.GA1888765-robh@kernel.org>
 <2e152214-5f2d-451c-8659-941184cd8fdd@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c46vdgxgomsxt4zs"
Content-Disposition: inline
In-Reply-To: <2e152214-5f2d-451c-8659-941184cd8fdd@mailbox.org>


--c46vdgxgomsxt4zs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
MIME-Version: 1.0

Hello Marek,

On Tue, Jun 17, 2025 at 03:48:13PM +0200, Marek Vasut wrote:
> On 6/17/25 3:37 PM, Rob Herring wrote:
>=20
> [...]
>=20
> > > +++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
> > > @@ -0,0 +1,48 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pwm/argon40,fan-hat.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Argon40 Fan HAT PWM controller
> > > +
> > > +maintainers:
> > > +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > +
> > > +description: |
> >=20
> > Don't need '|'.
>=20
> Fixed in V4 ...

That sounds as if there is already a v4 on the lists. I don't find such
a patch series though. Am I missing something or just misinterpreting
your words?

Best regards
Uwe

--c46vdgxgomsxt4zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhVN50ACgkQj4D7WH0S
/k6P5gf/TPtqvZOLxU/tA8vZQmMSdQP78vV4Tg9EJnssQRAM03y9ZUxMSQdcw6kf
xHUqZJ0IQLyF4UcWom8JJLZUrtFWEOCx8x0wj53PSWO7+5KQtc2BTiWxWEfqzkJu
1i51XtXB9oPBSjGa8RzW7vboEhzbNGjtT5AVt7ruVW6rT2Y1OsAbKQg90q5wi53K
Ok0Eq8hLKPbKAWTkLm6QfHC08NbSc/0qrymIA2WXKCrxFLaV9sbF9orGltlQBm1N
LPVrSgP+M7vHzShEWTpCd4HaethV/G+YIGjeJTOLIlQjbk3KAG9vdINyUkKlP9gz
fGxuegx0+/2Umu2UNLRvM3FIRe39hg==
=84d0
-----END PGP SIGNATURE-----

--c46vdgxgomsxt4zs--

