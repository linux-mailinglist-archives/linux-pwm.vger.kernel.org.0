Return-Path: <linux-pwm+bounces-1112-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17B83F86D
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27BB1C21385
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 17:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4D28DD7;
	Sun, 28 Jan 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT+1p1dz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB328E03;
	Sun, 28 Jan 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461714; cv=none; b=ts5zjSVtb/TQ1n8Ys6fxtbDWrYax1XcXlkm4OmY/TuYTWkBx8092cIrA3Hr2RuD2wGuTCB5sZfNsijjQ6eF87eBwLVRBULqYL92fwUPlHhi2PIG89qB+NMsam3atROjiWsOR2kznqPXDtVzC8AGlNzHgx6zOlo5rKwRgRTU4gCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461714; c=relaxed/simple;
	bh=Rk93StFwB5WhjkPfTooaFx9T8P8/WFK5FZOrXNFl/xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl7JU0+E1ABF1ooyLqCUGp0IerjAxjDN/nMROEin8W/x8qbXD9TqAkYKctYQUz6+PkqFshzL9MtZqRdVFhtpLLVpKVrkkGIw6cbxtPvlmEQ0GAorAElygie+fDIANBnWh52PokeD0RO1UgAdrrYtmGLinosK8wv5OLnFnutHSM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT+1p1dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A124C433F1;
	Sun, 28 Jan 2024 17:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706461713;
	bh=Rk93StFwB5WhjkPfTooaFx9T8P8/WFK5FZOrXNFl/xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mT+1p1dzp3Fmp3rTTPLEJRryULqTcl+7omdJMtuWKOe1TATGVEzA5+hk1X2q+pYSn
	 1c/cQ0LrK6VIPZV6FkryNERvrSL3oUJD50LXp0TBNhYz7Fi94u5TmEY9dulvkcekfa
	 TE6zBg51ah2GZWMXp2NHP5tKY13x4uComkZZkPklYl3/f5VBpu/7HvM9/Y6iAQM7b9
	 DBQNwmMNAObWSqCEfHIRNNCfLTix7bG9qB0KZZSiIPvDXKOfDHVoaNg6X/kP+dL7W6
	 sVYNMQBmRdaLFQdgKmimnpLnchl+4zFpWoihdCE4wxsvlu33aMICS/FaoOFOQNvtxr
	 MDz1ZuUFpEiYA==
Date: Sun, 28 Jan 2024 17:08:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Nicola Di Lieto <nicola.dilieto@gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20240128-unlearned-routine-201fd02bd2c0@spud>
References: <20240128163630.104725-1-wahrenst@gmx.net>
 <20240128163630.104725-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c9CUbGV6iAZ/BEV3"
Content-Disposition: inline
In-Reply-To: <20240128163630.104725-2-wahrenst@gmx.net>


--c9CUbGV6iAZ/BEV3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 05:36:29PM +0100, Stefan Wahren wrote:
> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
>=20
> Add bindings for the pwm-gpio driver.

drop "driver" from here and instead explain in terms of what the
hardware is doing. I think that's just as simple as saying that it is a
binding for a gpio used as a pwm.

>=20
> Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  .../devicetree/bindings/pwm/pwm-gpio.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml b/Docume=
ntation/devicetree/bindings/pwm/pwm-gpio.yaml
> new file mode 100644
> index 000000000000..4932484563f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic software PWM for modulating GPIOs
> +
> +maintainers:
> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +properties:
> +  "#pwm-cells":
> +    description: |
> +      It should be 3. See pwm.yaml in this directory for a
> +      description of the cells format.

Instead of this description (which I know isn't unique to this binding)
I think you should have a ref: to pwm.yaml.

> +    const: 3
> +
> +  compatible:
> +    const: pwm-gpio
> +
> +  gpios:
> +    description:
> +      GPIO to be modulated
> +    maxItems: 1
> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pwm0 {

Which may then lead to a complaint about the formatting of your node
name.

Cheers,
Conor.

> +        #pwm-cells =3D <3>;
> +        compatible =3D "pwm-gpio";
> +        gpios =3D <&gpio 1 GPIO_ACTIVE_HIGH>;
> +    };
> --
> 2.34.1
>=20

--c9CUbGV6iAZ/BEV3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbaKDAAKCRB4tDGHoIJi
0iqtAQC8JWlaw8Us9ODHHe0kWVLk7nbGPl1i2GkQWjAgcw8vmAEAoSlmdCHc6s7g
jdbdeIuUPAR6Pv0jxHjzXYJD/jVNRAw=
=Ml3p
-----END PGP SIGNATURE-----

--c9CUbGV6iAZ/BEV3--

