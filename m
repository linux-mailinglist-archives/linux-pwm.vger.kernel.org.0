Return-Path: <linux-pwm+bounces-2297-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205708D3F9D
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988ABB258C0
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AD1C8FA2;
	Wed, 29 May 2024 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPUM00Fk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884071C68AD;
	Wed, 29 May 2024 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014555; cv=none; b=opfgirDdFqmzwE5Y3IVvpMdaolMIEpx2gsBJKipXTibbD9IlN+sZxM5sgZMXakof8cn+V7wlDCuOpPbKLfo2e1uOCO4rbI8mPy9o+QFYpzo35gAKnQ8bL/OgLX6VLKHaYcBC3xzI91upLSeYQopPD/kxS/+/0rI6Gp367wACZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014555; c=relaxed/simple;
	bh=bdvVeEVPK461LvQoL0Gl/m+YSw/+CssWr9H4KgsuvA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aidZ6ALnITlhNHuO5tipmD9T8PfyPVW2Xn3XFoy7rNs+23NqwHJpjbHJx3lLzsf3mkj7q1t+orf1TjW+1caiM5OcF1f9z1iufEz/cCiHy6JrJl6pVkDmcT03evtwzb/twICTMjVwNKgTNSLrTD2gfiNn5O72Hh8nPeXv8O0mmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPUM00Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7BAC113CC;
	Wed, 29 May 2024 20:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717014555;
	bh=bdvVeEVPK461LvQoL0Gl/m+YSw/+CssWr9H4KgsuvA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPUM00FkJ/TULR+mHP0tt0IcRNr1PORWmuB8IKtM5LIM7DG7EKVHswRCTVPKDUEr+
	 I2/9KA/RQ9urjHX6JN6j38/tBCDnIRCG6UFif19KdP9C5Dm0uXlVL5R8lit/bNXoOr
	 EO6kougyilSocurHUzl8oN14MnNR+TGX0+L6d2uzAq1izImF0m325N5OcNVqGsJkbL
	 2WAcn1Mk+wjvayWclot3LN6kBTVA5ToE5k4loXguMeZC5j4q2s51KISNOPFI+AcoXL
	 C05mRenSVSRKR9n+54Y6sYg33EIYqNMmQPuJYBt2k+yH1v17/chfCAf36fK8vSiJXb
	 DeZbhrnrH5T6w==
Date: Wed, 29 May 2024 21:29:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Farouk Bouabid <farouk.bouabid@cherry.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: pwm: add dt-bindings for mule
 pwm-over-i2c controller
Message-ID: <20240529-capably-overgrown-755bb11ece69@spud>
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
 <20240529-buzzer_support-v1-1-fd3eb0a24442@cherry.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UNdcncQsPyjcgVaG"
Content-Disposition: inline
In-Reply-To: <20240529-buzzer_support-v1-1-fd3eb0a24442@cherry.de>


--UNdcncQsPyjcgVaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:10:30PM +0200, Farouk Bouabid wrote:
> Mule is a device that controls a PWM output signal based on I2C commands.
>=20
> Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
> ---
>  .../devicetree/bindings/pwm/tsd,pwm-mule.yaml      | 46 ++++++++++++++++=
++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/tsd,pwm-mule.yaml b/Do=
cumentation/devicetree/bindings/pwm/tsd,pwm-mule.yaml
> new file mode 100644
> index 000000000000..71a940a2a644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/tsd,pwm-mule.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/tsd,pwm-mule.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mule PWM-over-I2C controller
> +
> +description: |

This | is not needed.

> +  A device that outputs a PWM signal based on I2C commands.
> +
> +maintainers:
> +  - Farouk Bouabid <farouk.bouabid@cherry.de>
> +  - Quentin Schulz <quentin.schulz@cherry.de>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: tsd,pwm-mule
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2

No clocks or supplies?
I tried to google for some documentation for this device, but only found
archives of this mail thread..

Thanks,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      pwm@18 {
> +        compatible =3D "tsd,pwm-mule";
> +        reg =3D <0x18>;
> +        #pwm-cells =3D <2>;
> +      };
> +    };
>=20
> --=20
> 2.34.1
>=20

--UNdcncQsPyjcgVaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZleQFgAKCRB4tDGHoIJi
0mjxAQD/8WDiJ1amjUFRXI/qQT0XYuHXTu9diC7XmiTGBdToeQEAhqs7zm1GIVey
J5MvAcYGiVtOazmNblHpUk4zB4lF+w0=
=Km/B
-----END PGP SIGNATURE-----

--UNdcncQsPyjcgVaG--

