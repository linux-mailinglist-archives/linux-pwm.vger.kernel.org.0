Return-Path: <linux-pwm+bounces-6919-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DCB16F13
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C213AE2F7
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C41C68A6;
	Thu, 31 Jul 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLC7+6ij"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC51E51D;
	Thu, 31 Jul 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956036; cv=none; b=taRFpT2hHwxR38+gNOxxaC6V3cRIyN9IkbPXq/JpfnvvXU8T3lkFKfnp0kXcCGjVRutA3cZbXLAs6xFvlDSd/eRCRzbi/FWEjXg/MPjBGGoMsiYMrFlGqcjBZT0Pud+BXsvNcRR4nFkwkY35+RBQWKTvA34p/e4No6LLFfMVins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956036; c=relaxed/simple;
	bh=nIIy3EtagONm9o7fIocsy3fvnqj5DKyDI9AvQpz+YsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUZE+qaC0IXxPo8Qbo6tWTYbK/GsZymMlWDSToPzIaObboKbRGdBWJS2lLORzN/xJgiXkhvaB2NpsiG+kH6u65VLVwTIXBEFfifb63+EmVQcjxuElsVXyq/Jwj3b5QTDCGlmSFps+IpY4dgutiX1FCtz0KN/EvRdDUnlVuYtHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLC7+6ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C17C4CEEF;
	Thu, 31 Jul 2025 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753956036;
	bh=nIIy3EtagONm9o7fIocsy3fvnqj5DKyDI9AvQpz+YsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLC7+6ijyBPGKVEMVLfwY+Uw6w5la+YyHP/0svxYWWgTFagJusQ8YCt5h4K9Qtm0W
	 fbrDqzIHcEFwXtz/8R1k+qnVGmHJN5o8B7/o2YJiD3ybv9+NhnnPJrBUd2iuVkpUa8
	 YYYqqfimZw0V4cfMDJIpaQjmGJiF4wX1cAEABFHg8Z8oTrFq9Q54sseSj4nJXfyJHX
	 EYltQcNTEyRH/UM9T21J0eGc3M9obqQuaUxWHB4BPHCl0GPUHmT76oqYxuQ03M1kEz
	 qe1lxG2BGYaCC71S+ehz0G2qPrCwVtDYWeuiROsBXwFkBUc87nrnR91ESTs81SFsj6
	 858ooeFMMIHTQ==
Date: Thu, 31 Jul 2025 12:00:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <6d2cq657lkwrzntlwwyc5drgkh4vsetkppugrhjedpp7hlvdh5@lqwe34oyuuvb>
References: <20250427142500.151925-1-privatesub2@gmail.com>
 <20250427142500.151925-2-privatesub2@gmail.com>
 <20250512235619.30cff739@minigeek.lan>
 <20250619094407c4c849f3@mail.local>
 <20250619131044.20b45d8d@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xadqunur2iav4gmf"
Content-Disposition: inline
In-Reply-To: <20250619131044.20b45d8d@donnerap.manchester.arm.com>


--xadqunur2iav4gmf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
MIME-Version: 1.0

Hello Andre,

On Thu, Jun 19, 2025 at 01:10:44PM +0100, Andre Przywara wrote:
> On Thu, 19 Jun 2025 11:44:07 +0200
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
>=20
> Hi Alexandre,
>=20
> > On 12/05/2025 23:56:19+0100, Andre Przywara wrote:
> > > On Sun, 27 Apr 2025 17:24:53 +0300
> > > Aleksandr Shubin <privatesub2@gmail.com> wrote:
> > >=20
> > > Hi,
> > >  =20
> > > > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > > > controller witch is different from the previous pwm-sun4i.
> > > >=20
> > > > The D1 and T113 are identical in terms of peripherals,
> > > > they differ only in the architecture of the CPU core, and
> > > > even share the majority of their DT. Because of that,
> > > > using the same compatible makes sense.
> > > > The R329 is a different SoC though, and should have
> > > > a different compatible string added, especially as there
> > > > is a difference in the number of channels.
> > > >=20
> > > > D1 and T113s SoCs have one PWM controller with 8 channels.
> > > > R329 SoC has two PWM controllers in both power domains, one of
> > > > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> > > >=20
> > > > Add a device tree binding for them.
> > > >=20
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > > > ---
> > > >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 84 +++++++++++++++=
++++
> > > >  1 file changed, 84 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner=
,sun20i-pwm.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i=
-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > > > new file mode 100644
> > > > index 000000000000..4b25e94a8e46
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.ya=
ml
> > > > @@ -0,0 +1,84 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Allwinner D1, T113-S3 and R329 PWM
> > > > +
> > > > +maintainers:
> > > > +  - Aleksandr Shubin <privatesub2@gmail.com>
> > > > +  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - const: allwinner,sun20i-d1-pwm
> > > > +      - items:
> > > > +          - const: allwinner,sun50i-r329-pwm
> > > > +          - const: allwinner,sun20i-d1-pwm
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  "#pwm-cells":
> > > > +    const: 3
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Bus clock
> > > > +      - description: 24 MHz oscillator
> > > > +      - description: APB clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: bus
> > > > +      - const: hosc
> > > > +      - const: apb
> > > > +
> > > > +  resets:
> > > > +    maxItems: 1
> > > > +
> > > > +  allwinner,npwms:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: The number of PWM channels configured for this in=
stance
> > > > +    enum: [6, 8, 9] =20
> > >=20
> > > Do we really need to be so restrictive here? The IP has an
> > > "architectural" limit of 16 channels (due to the MMIO register layout
> > > and status/control bits usage in some registers), so can't we just le=
ave
> > > this value to be anything between 1 and 16 here? If people configure
> > > this wrongly, it's their fault, I'd say? Without confining this furth=
er
> > > based on the respective compatible strings this enum is less useful
> > > anyway, I think. The Allwinner A523 uses the same IP, and supports all
> > > 16 channels, the V853 implements 12, that's what I quickly found
> > > already, and there might be more examples in the future, so I'd rather
> > > open this up.
> > >  =20
> >=20
> > Do we really need this property? I feel like the number of PWM channels=
 should be
> > something the driver could infer from the compatible string as we are g=
oing to
> > have one compatible string per SoC anyway.
>=20
> Well yes, this would work, but I feel like it creates unnecessary churn to
> touch the driver every time some new SoC with the same IP pops up, and
> where just the number of channels is different - see above for a list of
> SoCs we already know about, and there are more in the pipe. It also means
> stable kernels would already work.

Having a property that specifies the number of PWM outputs is fine for
me.

There is some prior art for that: mxs-pwm.yaml has fsl,pwm-number;
pwm-st.txt has st,pwm-num-chan with that semantic.

Given that this is a fundamental concept of a pwm chip, I'd say giving
that a generic name without vendor prefix is justified. I suggest to go
for

	npwms =3D <..>;

which matches ngpios that is specified for gpio chips.

Best regards
Uwe

--xadqunur2iav4gmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiLPr4ACgkQj4D7WH0S
/k6qWwf/UfJJoL8d1i9SVPk/Syl4ySb6I9d8VOpLaDSJfkSpXLfkxhBEvlXyOXAn
FzlTMz893YPQTTpTeuEmFMebZhM62aQoFwRTw8NecOLepM3Y/3ia5Q+wS/goyNf3
NKMXMcqIeyF2BiQc1PvBTInND72IGsRqzuScnGVZtoAgz8IOEgigclMY5cc4mbGX
CsbLwoTC9F9MXYHQp2j+2VpL3qf89ug6zXdXq+j4YSRYaBj9LuPCFhTN921V6MfP
18OK7KI7rfJpJUuVPcpnmM0nH7Z9hTXM3kQFdiSwGd6QexuESuw3KBCdfDwuRpoI
4nSRBPbwtqh1Eq7AwAuqT07vbY/DRQ==
=JDZ2
-----END PGP SIGNATURE-----

--xadqunur2iav4gmf--

