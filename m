Return-Path: <linux-pwm+bounces-4780-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F62DA29669
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 17:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4313C3A9EF7
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1E1DE2A9;
	Wed,  5 Feb 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCi0elgY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AE1DDC28;
	Wed,  5 Feb 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772973; cv=none; b=j2Okc4JO470QWieaYPu6bFFZvj8bfmCvWTPejM2Ka/VR/mQlrnWwTJMj7WjRjExO/Viu2VD+JXvmbFoaq/SQIs8zhOXvF2f415YW3Q/frSs2rZS7vDFDHowbyErAJV/0Bl/KjmPTp0zAsN3YML67KKTJ6EL8ib/ffX4DzNutu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772973; c=relaxed/simple;
	bh=d0uZKmyfPtM1dxbl4GJ+Vu5RdmQBS52EMFV3irgcQYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzRJ14e5QlQN1L1I3tABzGUuAGQUnYTmcoQ7F3lb+MCkWgfaDE5IqQWzftiqaqayIlT7Go4F+WLaNm1niTudMce9ho/UpNYQ5tQLmmQ9KlnYeR7jUEvSLONjrD7aCEnkxaRDqqPQHYPeFdQZt+kXr8ttEp7cvCO+X94lIty60Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCi0elgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E759C4CED1;
	Wed,  5 Feb 2025 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738772972;
	bh=d0uZKmyfPtM1dxbl4GJ+Vu5RdmQBS52EMFV3irgcQYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCi0elgYle0tH9injXPplB/uayOG/myK3mKLZ2q1Zj8BoH+JmAGLhxk5VSsSHLIdf
	 bN1YUcrt0RLW34e6z/qPB/Imj13wNSwO5ZxgZeJhSGhpaqZ9n12+zUAKrVR9QP4qfr
	 edMBapiqqKDCIl0JuOnZHRzzOXAk2tj2eKD87swe8PhEa4zHrrNk2Q9s6m4jAVM34C
	 qAqpKQedbvp+AtCO4cjbwcQ/voa9E9ibwRTV088SxPSAKe3UKaDnFXq35VMEitABnz
	 IKxzggXdF5TzCEjF0ZQL0cnlXdl1su3dUoLyvtkxWbdv0cHLteQjAKh6GPHzZ+8pmw
	 gpoDtZpZi7Nvw==
Date: Wed, 5 Feb 2025 17:29:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
Message-ID: <6js6k6xz3vuqshq2pfwqifby4t5q54ftztxxw2rau4j23xx2y5@u5xubi6v3uil>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
 <20250205095547.536083-3-herve.codina@bootlin.com>
 <ejdh76c4r44gxsdi7gwed65ste3wuunki2jgavc3wsfri5yaex@jccsywdfadgp>
 <20250205143737.1315baba@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56vutjr4wmd3jj6f"
Content-Disposition: inline
In-Reply-To: <20250205143737.1315baba@bootlin.com>


--56vutjr4wmd3jj6f
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
MIME-Version: 1.0

Hello Herv=E9,

On Wed, Feb 05, 2025 at 02:37:37PM +0100, Herve Codina wrote:
> On Wed, 5 Feb 2025 12:38:32 +0100
> Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote:
> > Does this also work if &soc_pwm2 has #pwm-cells =3D <2>? Would I need j=
ust
> >=20
> > 	pwm-map =3D <0 0 0 &soc_pwm1 1 0 0>,
> > 		  <1 0 0 &soc_pwm2 4 0>,
> > 		  <2 0 0 &soc_pwm1 3 0 0>;
>=20
> Yes, exactly.
>=20
> >=20
> > then and
> >=20
> > 	pwms =3D <&connector 1 57000 0>;
> >=20
> > would then have the same effect as
> >=20
> > 	pwms =3D <&soc_pwm2 4 57000>
>=20
> Yes, the last 0 (or any other values) in pwms =3D <&connector 1 57000 0> =
is
> simply dropped in the translation (#pwm-cells =3D 3 in connector nexus to
> #pwm-cells =3D 2 in soc_pwm1 node).
>=20
> In more generic terms, it works in translation from #pwm-cells =3D N to
> #pwm-cells =3D M by simply dropping the last N-M values.
>=20
> Also note that even if values are dropped, you need to have them set when
> you point the nexus node because #pwm-cells =3D 3 is set in the connector
> node and need to be fixed and usable for all the entries in the
> pwm-map table.

Makes sense.

> > and the 0 is dropped then? Could I adapt the mapping that the effect is
> >=20
> > 	pwms =3D <&soc_pwm2 57000 0>
>=20
> In this one, I think you miss the PWM number
>=20
> If I read correctly this line you ask for the PWM 57000 from the soc_pwm2
> controller. This doesn't make sense :)

Some pwm chip devices with only a single output line use this. The first
paramter is the default period (which is passed in the 2nd parameter
normally) and the 2nd paramter are flags (normally the 3rd parameter).
Back then the rationale was that for such hardware, the line index is
zero always anyhow, and so could better be skipped.

Compare of_pwm_xlate_with_flags() to of_pwm_single_xlate(). pwm-pxa is
the single offender using the latter. Thinking about that, it's easy
enough to fix without breaking compatibility. I'll tackle that.

So for a PWM on pxa `<&soc_pwm2 57000 0>` works fine.

Best regards
Uwe

--56vutjr4wmd3jj6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmejkecACgkQj4D7WH0S
/k4fTwgAsEzABfbbBa/jWtTTBq123MvJs2pfyldUvykMIIugEjnMYwtBMtdIw8kS
0PS9lDalHKCedoLAFZb6F0jlP/NXskM1g1QtFDd4Jj5UKsAoGZE9McUIDnKQ2d3x
OP+EMwS8xxgiEaDxh5JAwyohByfLBVIsmlv8XSO1E6deyTQkdNFdt7j835eF6KmO
hPVP6ifgcjbSTINdz+KP53TbLc4sfIRpjZoG7jJ6ITv8HmRfpaZ2czQUvuVJtpcV
1Uq4E5xlVIwqtIcxSPEayIjABm6hJjOdixKdoPi1/FjWh+/bAiZaqjAMo5oIpzxC
TroXi9PjpYswyRcM0pJrBbDqn3f9ZA==
=kiW0
-----END PGP SIGNATURE-----

--56vutjr4wmd3jj6f--

