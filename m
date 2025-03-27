Return-Path: <linux-pwm+bounces-5292-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0837A72BB7
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695C5178F96
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 08:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39B2080CE;
	Thu, 27 Mar 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOnUw5Ci"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB32080CB;
	Thu, 27 Mar 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064973; cv=none; b=BU7UAyVZnC3WWMUUCE+rj4yNTSnpKIXJJZ6df197aAL3fEc1RuiG15htEuygdsalRL0/xeiHV2zU+1dEsfvxbQsypWRAGENckIq7WwKBJy+JvEH8qOG/qVJYRsmPqzI1/g5eQQPUn0uKduZxcqA7FZcDijXbZb4Xrze3TIgXhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064973; c=relaxed/simple;
	bh=YD48CO4FsnwCglT67h5qBvSC1Oj4vkTc/ynkSqfBkbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIDc5Zk+16CmWU+AGyW7MBuzy9TjpBB71iSM2KsLpV6+6zb1TTBEixvlHGH7zInhg/P2FQmPIpVPkoCgXfgchw3mvZNIuNFAZKJJggSPAKN3miFmoBkkrxn99HYpXEqnaEOKbWyNQ8LXfBjMbzszEE3yORtRpsJjFFse912Bk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOnUw5Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F1FC4CEDD;
	Thu, 27 Mar 2025 08:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743064972;
	bh=YD48CO4FsnwCglT67h5qBvSC1Oj4vkTc/ynkSqfBkbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOnUw5CiiGx9MW6mTLS3QpYBwCi1ecL7NIZ54rPiNogF5wqbYofbS7ZsUmJuRxOEK
	 VmjINAOiHZG5fr2UqaSFPFa0RR7aoWNBY3rd6ldXeDEwC+r6h8zCfOBjuI1A7p8E1q
	 HFPn5tXVTytEjQ+XcTNZ8fxwCSkLnnVis6YszVKWXfuNWunvmnzxF5pnASBCr3NHIR
	 Z6JeGIbiyq05a9lLiEV9gTwA7OszwjPB4CXTD/6QsVB674OCI73mGO/M00/RC9/vhi
	 CfJuG9imQVqlDaHgG9M8gB/2mzm1d9SekbfhqlLWkHgNnzAWHhs9VecB0F5JLILSNV
	 U5ExS4PeES/YQ==
Date: Thu, 27 Mar 2025 09:42:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <t3zbutuclculgqchj2byhjqbebdyrs3sslt65faph5tljppljk@lr5pbdovyuxv>
References: <20250213094018.134081-1-privatesub2@gmail.com>
 <20250213094018.134081-2-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="chw7rzoep466ms63"
Content-Disposition: inline
In-Reply-To: <20250213094018.134081-2-privatesub2@gmail.com>


--chw7rzoep466ms63
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
MIME-Version: 1.0

Hello,

On Thu, Feb 13, 2025 at 12:40:12PM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> controller witch is different from the previous pwm-sun4i.
>=20
> The D1 and T113 are identical in terms of peripherals,
> they differ only in the architecture of the CPU core, and
> even share the majority of their DT. Because of that,
> using the same compatible makes sense.
> The R329 is a different SoC though, and should have
> a different compatible string added, especially as there
> is a difference in the number of channels.
>=20
> D1 and T113s SoCs have one PWM controller with 8 channels.
> R329 SoC has two PWM controllers in both power domains, one of
> them has 9 channels (CPUX one) and the other has 6 (CPUS one).
>=20
> Add a device tree binding for them.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

nitpick: Put your S-o-b last.

> +  allwinner,npwms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The number of PWM channels configured for this instance
> +    enum: [6, 9]

Maybe mention the default that is assumed if this property isn't
provided? Reading the commit log makes me wonder if the default is 8. If
so I suggest to also allow that value explicitly.

Best regards
Uwe

--chw7rzoep466ms63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmflD4YACgkQj4D7WH0S
/k4zPwf/YgFEiTFLIAzGN93hGhAtrlBkY9Wk7sGF/1me7yiQulyYfZVNVE6VYT+d
ePJ4J6WFE+mBBUN7AUaq2L3TqRbq0Fe5fRURdVxpk+RHdtcMhn5FKUTpUWSfB9eM
v1qDWxVJfZEFhhs5w6pdVeOP3EUjqNxD6oKqTXROCLJQIe4WA/TtPOMK3oJccVCv
nSnAtTGktNW1RdDOZH6iltBKmY01oZJO1AkRjE7sOcWkjDVk6f68cgig337GWs7p
b/2z0uKOyAlDQZFi8TaMA323lLDgPyoKAbNx+xdcLdlCKNMXUADk+3vF5caqPwQL
9InY8wuNgSZh208F1a8d2YBqGxJlhA==
=gz3O
-----END PGP SIGNATURE-----

--chw7rzoep466ms63--

