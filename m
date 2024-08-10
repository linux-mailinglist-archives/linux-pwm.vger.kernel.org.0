Return-Path: <linux-pwm+bounces-2999-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF794DDBC
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 19:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64501F212F3
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6413A1BA;
	Sat, 10 Aug 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxKSp7on"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074638394;
	Sat, 10 Aug 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723310338; cv=none; b=dscoG3nmaPGKziPS2fUB9Wtmz+fGsCdkGyx6KnPQUMdQPPMMbBSmxYajIlVhW8zEegUTS5n3SXMM9p412+TTXsgnn1AhZ5zBtFzx+QF9jpcQ0HL9Al8JBB3oSZY4hm4I+RfR9pD5N/OkvzmXkB8BTV5f/+WT22tijjkaHdmA2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723310338; c=relaxed/simple;
	bh=ag/bsceGPVeuQ7s4EtclHx9Ksxdoj0dbuKHPiUMwhbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHzUJIW/4ewDOzoxJFO8iGBgMJB1mq/QugsBNG/X2cnxKTrC4Xs0XsptujjYSpfljTyvs233h03XPurWg+9H7fuSotdj+Y8/n2lrOzC7twHIbeOx4O+F8OxDlrK00Ysj4OulXyLo0FDrwCxVTIuWgrHACuJsS+Ty0YCWUX29Bh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxKSp7on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B679DC32781;
	Sat, 10 Aug 2024 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723310337;
	bh=ag/bsceGPVeuQ7s4EtclHx9Ksxdoj0dbuKHPiUMwhbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxKSp7ono43bxCxg30AERUxf9vZQGocrzIzIkShblckbic6/4wC9exVhA0CD1ahZ5
	 /TbOYsD3qiiAFw2XuvX0wNE9iMYkCAoOGYZDvVTy/LyFSIVN+yFjFN2c9zdTKkRyjk
	 6Z9TMROvc2uu2H15FKoXdWPTlHkH5t1vruPWhnL0yww0puM2S3ss3w0/eSwmH+OobF
	 UTz3SEEzRUUBwFMtXpW8MZAeK6//7kZmLoHr+18f7/AsMxVlH0SAJw9iy5id2Wb/fB
	 iMb4z8MGK+2bIrnWYUVSqjWFhafZr1+lwShd+FSIENwUWvij+pw5xUvgFiGlBD74yu
	 ExA624YL+6i7A==
Date: Sat, 10 Aug 2024 19:18:52 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pwm@vger.kernel.org, ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com, krzk+dt@kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Document Airoha EN7581 PWM
Message-ID: <Zreg_OGH5ndPbTYT@lore-rh-laptop>
References: <cover.1723264979.git.lorenzo@kernel.org>
 <6a95b1d7fb90045a51a0cf51b9fafff26790904b.1723264979.git.lorenzo@kernel.org>
 <4c63b64b-b6f2-4e72-95c5-5555681f6d10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VU60BAksC1EKInjK"
Content-Disposition: inline
In-Reply-To: <4c63b64b-b6f2-4e72-95c5-5555681f6d10@kernel.org>


--VU60BAksC1EKInjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 10, Krzysztof Kozlowski wrote:
> On 10/08/2024 06:48, Lorenzo Bianconi wrote:
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm@1fbf0224 {
> > +        compatible =3D "airoha,en7581-pwm";
> > +        reg =3D <0x1fbf0224 0x10>,
> > +              <0x1fbf0238 0x28>,
> > +              <0x1fbf0298 0x8>;
>=20
> These look almost continuous, so I wonder what's in between? E.g.
> between 0x1fbf0224+10=3D0x1fbf0234 and 0x1fbf0238?

register 0x1fbf0234 will be used by pinctrl driver (I will post it soon) for
pwm muxing. The issue here is clock, pinctrl, gpio, pwm and (future) serdes
registers are all interleaved in a non-regular fashion in the following
IO space:

- <0x1fa20000 - 0x1fa20384>=20
- <0x1fb00000 - 0x1fb0096c>
- <0x1fbf0200 - 0x1fbf02bc>

So in order to avoid conflicts we need a sparse mapping.

Regards,
Lorenzo

>=20
> Rest looks good.
>=20
> Best regards,
> Krzysztof
>=20

--VU60BAksC1EKInjK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZreg+QAKCRA6cBh0uS2t
rLA0AP9km4sKCFpLwY5e5Xri0IeNQy7pqAcJXJZmICwTkJHA6AEApRkR1ZsyHcla
jesK3yuVFEn7YeMIs816PW1aGwOL6Qk=
=gbix
-----END PGP SIGNATURE-----

--VU60BAksC1EKInjK--

