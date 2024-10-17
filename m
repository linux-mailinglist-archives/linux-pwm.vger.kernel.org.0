Return-Path: <linux-pwm+bounces-3693-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF29A24F7
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4DC1F2164C
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731761DE4D4;
	Thu, 17 Oct 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozDrKY+x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A21DE3DA;
	Thu, 17 Oct 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175289; cv=none; b=p1GhdCaxGEK9cUtbUTPLFjcq25rQ6Ssd4fwiiS6XKqWE1nMhpdkfQFyxe/Ysi0B3i+zT6YCG7Ue9xL/87qDT+8XnF4kjcmQNfKnryYMzPV26hAndEv8Lfevh0w81s9U6WGTM3sgRbF+PUZeOTWuYyqHBXk8Ol9WIL1/6XVa+3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175289; c=relaxed/simple;
	bh=cG1ujo3dHNKa9WqVdQiAckTISmwm/fCx/SWHY+8ljuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhPrhTLaGYpqqBvryFKYFwWv+/u+ilVKhfoGjsaYnm0ltthCmH9Wc5jFO9EJAub1baUpMHygdHa/MdPzIyJrf3chSheaT4ijxvOBBC5i6M9T/Ozja/tvZiGCrjXJTk7sVb6SYQxlNHQwC5582q0Trq9YJll4/fzSip56glRgYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozDrKY+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E54DC4CEC7;
	Thu, 17 Oct 2024 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175288;
	bh=cG1ujo3dHNKa9WqVdQiAckTISmwm/fCx/SWHY+8ljuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozDrKY+xx8pM3y0YaTW/FDyLDweOtlQ19ddNuFDlkNz1Cl5bNZWmVXDpdCOs7ji4l
	 iXdT2PD4s0LoC+ptlSSi+qblh2Bz6k0cfhaKYsMkk5HHNJcN76yZSAP5Rtzl/ormwl
	 cPFPs+Mff5tgW3bbx1HyHM+4hNEvPTrsp8EThQzhhba/2HwNzMSSLvp3i1tkV5cen8
	 xyC7iAN7IM7VeOJ9GJipIMzggmx15Si3H+hnYrD1476SMa4P6iBXBtxGH/CHKO/8Xw
	 vtblIOnKuCZK8BwvDm2IUv47V5HIPjhEjEEiK8XBrSCCireYX/DbJkjsKU1h2nzudP
	 i6WQBcP1iJ9Cg==
Date: Thu, 17 Oct 2024 16:28:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Message-ID: <ZxEe9gGd1qW4ksEo@lore-desk>
References: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
 <20241016-en7581-pinctrl-v7-3-4ff611f263a7@kernel.org>
 <834bfc12-4ce7-4ce1-a0c7-5bc8be3587b7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uoePblPqdHNb3UAq"
Content-Disposition: inline
In-Reply-To: <834bfc12-4ce7-4ce1-a0c7-5bc8be3587b7@collabora.com>


--uoePblPqdHNb3UAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Il 16/10/24 12:07, Lorenzo Bianconi ha scritto:
> > Introduce device-tree binding documentation for Airoha EN7581 pwm
> > controller.
> >=20
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 34 +++++++++++++=
+++++++++
> >   1 file changed, 34 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.ya=
ml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f36387572a9781636aeacdb=
cc8947017c7ca75a0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/airoha,en7581-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha EN7581 PWM Controller
> > +
> > +maintainers:
> > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,en7581-pwm
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +required:
> > +  - compatible
> > +  - "#pwm-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm {
> > +      compatible =3D "airoha,en7581-pwm";
> > +
> > +      #pwm-cells =3D <3>;
> > +    };
> >=20
>=20
> There are undocumented properties that the driver tries to parse. Please =
fix.
>=20
> Regards,
> Angelo

ack, I will fix them.

Regards,
Lorenzo

--uoePblPqdHNb3UAq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZxEe9gAKCRA6cBh0uS2t
rDpoAQC2ELyAKCz2bRRpe2BaRF6RYKIf0qfZ6xsbD9FbUklpFAD/Yy963j4FOSpU
JxqA9L3uYDf/UeDg2nJTj3ZUokwBQQg=
=HeFD
-----END PGP SIGNATURE-----

--uoePblPqdHNb3UAq--

