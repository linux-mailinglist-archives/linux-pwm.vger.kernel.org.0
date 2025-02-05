Return-Path: <linux-pwm+bounces-4775-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A06A2897D
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 12:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E36188975C
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5422F169;
	Wed,  5 Feb 2025 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOlzdv72"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E522C33C;
	Wed,  5 Feb 2025 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755515; cv=none; b=U3H0eQBwCVtAHJaVRMFPiVRxNlZavvutU0ru8+xHKZrA0WtUiomIT3fJ9ZOZV4hF7BCSWId4NexaPAoHcXyfsAFkdux9pAzqPbXc1hNe435PF7uvvgY1indpiX+GPAF1Sfejonnh34KidAAx7oNIzPAF0m+V90ChBCFX5iMc3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755515; c=relaxed/simple;
	bh=x8+1s0Ah3mFSTwPv6B2rss8bo5kzc6RZeN8bjPk3g6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf1B9tXeOzIqPa5tFTSiNNqmW9YcrSemRIUnjn6Ic6QK3X7Dd2RPAG+Hr1KcB/C2d9JP1Bc+zIH3ac5gmqu6kzymiRXC5j8Aj4I57PlydACZwFyvk41yXArpMXhc6O1oHF26dGwdyiwIDjeaFfft7Muldm+IgVxvrvtKeSyAo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOlzdv72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B339CC4CED1;
	Wed,  5 Feb 2025 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738755515;
	bh=x8+1s0Ah3mFSTwPv6B2rss8bo5kzc6RZeN8bjPk3g6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOlzdv725i1D5UTnyvUxNAlhPHvMEeWJ4i8ejxVMQ/NsY4tY4sBX+fY17ZEdP3vXK
	 giFFk1OlAP0vZE+09TNJZGGgJfRkXoIe0jX6viCZnE+BEYvMb1G7jsTksVT42cToGp
	 wNIJ14LFTuKJDiGsfn0jP7PWcRfceR/zs2TlXd7iDo/uI0LDl2BWwWL6h4+CMQsKRg
	 sptHimavIOraPnwwoXER63zxwE6n/MjuR2yqkxwUKEPntQG2sRRX2XVSDFeJVg3cdM
	 Ef5YQzdNeS4nkZPTP8kIgtP9IA4xzf70WNFMzctt4Ja+ichoIZj6wb/Vsco7NbFa9i
	 JuCgEVBnGGtSQ==
Date: Wed, 5 Feb 2025 12:38:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
Message-ID: <ejdh76c4r44gxsdi7gwed65ste3wuunki2jgavc3wsfri5yaex@jccsywdfadgp>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
 <20250205095547.536083-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qd3k6jnvok4jbmcm"
Content-Disposition: inline
In-Reply-To: <20250205095547.536083-3-herve.codina@bootlin.com>


--qd3k6jnvok4jbmcm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
MIME-Version: 1.0

Hello,

I really like this mechanism. Assuming the dt guys are happy yet, I
intend to merge it. Just some detail question below.

On Wed, Feb 05, 2025 at 10:55:43AM +0100, Herve Codina wrote:
> Nexus node support in PWM allows the following description:
> 	soc {
> 		soc_pwm1: pwm-controller1 {
> 			#pwm-cells =3D <3>;
> 		};
>=20
> 		soc_pwm2: pwm-controller2 {
> 			#pwm-cells =3D <3>;
> 		};
> 	};
>=20
> 	connector: connector {
> 		#pwm-cells =3D <3>;
> 		pwm-map =3D <0 0 0 &soc_pwm1 1 0 0>,
> 			  <1 0 0 &soc_pwm2 4 0 0>,
> 			  <2 0 0 &soc_pwm1 3 0 0>;
> 		pwm-map-mask =3D <0xffffffff 0x0 0x0>;
> 		pwm-map-pass-thru =3D <0x0 0xffffffff 0xffffffff>;
> 	};
>=20
> 	expansion_device {
> 		pwms =3D <&connector 1 57000 0>;
> 	};

Does this also work if &soc_pwm2 has #pwm-cells =3D <2>? Would I need just

	pwm-map =3D <0 0 0 &soc_pwm1 1 0 0>,
		  <1 0 0 &soc_pwm2 4 0>,
		  <2 0 0 &soc_pwm1 3 0 0>;

then and

	pwms =3D <&connector 1 57000 0>;

would then have the same effect as

	pwms =3D <&soc_pwm2 4 57000>

and the 0 is dropped then? Could I adapt the mapping that the effect is

	pwms =3D <&soc_pwm2 57000 0>

instead?

This smells a bit ugly and I wonder if this gives a motivation to extend
the binding for PWMs that use #pwm-cells =3D <2> (or less) to also accept
the default 3-cell binding.

Best regards
Uwe

--qd3k6jnvok4jbmcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmejTbYACgkQj4D7WH0S
/k5vyAf9FOgn+HGiXgkWzG2MSqoyD7G+Ta7HNABQ0lpkYOS5LXVy/HpvpjuQ0eeX
UE3mHJjwu5etDarD3ZrrDoiuUleIgV4L8ua9ITv+L+UeLkOl0FoQ/1/+mVulfROP
Wt1Cwul1CTLVKAF3QGuNgXhBDomBnLv7Kku7U/VHk66RPCPi81OwH1K+dDwmKE+u
n+lG7x8yh5cG+uqrnBrGd8tqqRsWlaOfwZO8zL+cz7b82eW1fqVwYTtve+hmAcvo
R9etj4qSchawmbIP5reKmoOSLzu/DbYq4Qq2oyflSJ2p3urfmnZ7QD6xzRHY0+7d
emvxiLg64T0GSrwNajfWbX6dCz7iXw==
=d/w7
-----END PGP SIGNATURE-----

--qd3k6jnvok4jbmcm--

