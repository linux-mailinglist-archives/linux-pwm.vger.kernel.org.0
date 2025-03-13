Return-Path: <linux-pwm+bounces-5144-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F3A5ECF2
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 08:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4633BC9CC
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411C1FF1D5;
	Thu, 13 Mar 2025 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZZIQ0Zf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D01FF1C8;
	Thu, 13 Mar 2025 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850576; cv=none; b=r5XviWtap9hY0rv/GimEB3/Y+FJYGorKn+63AO2FVg5QDYx+mVhHZIVUM4BSBC68onxovcDAA6f48NjNXkcIWqm3RSMjsZaMQIzKw2cFXLUN9deMf1N0Pc2hyKRyJyaukhMRQIhFG64pXuwrDaazfod6vBomq4sBXNUWOGz/Xpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850576; c=relaxed/simple;
	bh=aFeZ0mb9JxHxNrB2IY5dAI8W9F+KCqBlNLKvYHsoUrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmWXsKLkQNgM5cWGmnT6V7MhRxbMtnfyg2C0+ShnzDPWHxihsULwF9bFDxOU4bziC7u8p2/1hUd+OburF3vYHFs5UlmpMv/MpiPwZKKwoHK7EyabB93o/YeAjwPva8VmLkuEE5qYfh4FHPt2qYKvxx8mLkh22gQId5hDEuYCYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZZIQ0Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989D6C4CEDD;
	Thu, 13 Mar 2025 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741850576;
	bh=aFeZ0mb9JxHxNrB2IY5dAI8W9F+KCqBlNLKvYHsoUrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZZIQ0Zf+Wn/FHwFCF0brh5DPmkCHW1BS1cd1iNC0PhnojOpCR/hvAjs0T6TxsxIO
	 iYSZC7Udi+50z/MBOeevkqK7QJp4VeX+v3NUceNdYMHz33m13zbCIeMq2qaKOqyqwG
	 wDmbuyZTBgLUcuwr/H628jKCmOxqY6hbVEoYz2NCKWpYsqaEunNpOro4cnoMnE11iB
	 jwEM+kVFyyPhZ1nKZVDURvDd23e+APOdGjr/9AEwv8r1i96E94z2dIgxgFgCeJ47SK
	 jqpDIoc2pPRFxF/6LAys8KcKhhtbUfPTDjUnCx0+sD73qovvh5eXxlwXL+EiQqYXwq
	 lHyfdJQqgS0NQ==
Date: Thu, 13 Mar 2025 08:22:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, piotr.wojtaszczyk@timesys.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
Message-ID: <b2nlqt3gp4sk7cax722n7t7xonnrjzi6amsfrhylxmurctytiy@yqp7qpttyc5h>
References: <20250312122750.6391-1-purvayeshi550@gmail.com>
 <57ae63a2-544b-4241-a54d-8fa9917c1e44@mleia.com>
 <yvljnqnlka3ecw2n3hw2zgfszlldvbww3k7gq72dczmf6jwzfo@4vqnygxuzvk5>
 <5b62671c-719a-44f2-b28e-878159859a01@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbj5kzio535yua6p"
Content-Disposition: inline
In-Reply-To: <5b62671c-719a-44f2-b28e-878159859a01@mleia.com>


--fbj5kzio535yua6p
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
MIME-Version: 1.0

Hello Vladimir,

On Thu, Mar 13, 2025 at 05:37:44AM +0200, Vladimir Zapolskiy wrote:
> On 3/13/25 00:56, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Wed, Mar 12, 2025 at 07:59:21PM +0200, Vladimir Zapolskiy wrote:
> > > > +  "#pwm-cells":
> > > > +    const: 3
> > >=20
> > > It shall be 1.
> >=20
> > No, 3 is the right choice.
> >=20
>=20
> could you please elaborate?
>=20
> I find that here the only configurable parameter is PWM period, so it
> should be sufficient to have one cell only like in marvell,pxa-pwm.yaml
> or google,cros-ec-pwm.yaml.

These two bindings are special snow-flakes and the only drivers that
have #pwm-cells =3D <1>. Most other bindings use 3 and since commit
895fe4537cc8 ("pwm: Add upgrade path to #pwm-cells =3D <3> for users of
of_pwm_single_xlate()") (which was created for the pxa driver) the pxa
driver also supports 3 cells. The cros-ec driver even has comment about
that being ugly.=20

I intend to convert all bindings to use 3 soon.

While that isn't necessary for each individual piece of hardware to
provide 3 values, having a uniform binding for PWMs provides a nice user
experience and also simplifies matters with nexus nodes (see
e71e46a6f19c ("pwm: Add support for pwm nexus dt bindings")).

Best regards
Uwe

--fbj5kzio535yua6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfSh8oACgkQj4D7WH0S
/k4vDgf/ehubFXBJkC/7G707LTPd9SMCRiU7yo8xzDN/MgRlnqjDQxNaFFrE8xN5
7MIZqJNGy4dCdHGnGsbN6Nk7bpY/gNm/vXJhQepGVo2gBnpNyHrHVHoDsTNVz/Ka
61FazZfuGm6K6sHgwu1RploF6vajrJUYnxf4/+fRJWjLYWbwquaVC0sRrM1k7BXM
97aF6PQYAGMxDLQI4j5CS5Bmn3k4MtOgbgXu2GaPyIIkLP7f9AWy4ZQDmOR96MxN
10z2K223iXO02U8fyRVWwSbu5ya0KZ/q8IANcX/LEmh1gAuaJg56TFQCEDkxkuX4
6RESqFawU5aKcNqipOGIYitK3rzR3g==
=5IFd
-----END PGP SIGNATURE-----

--fbj5kzio535yua6p--

