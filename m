Return-Path: <linux-pwm+bounces-244-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5EA7FD971
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 15:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78262282149
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000EB3033E;
	Wed, 29 Nov 2023 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKvcWnyw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3432C82;
	Wed, 29 Nov 2023 14:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8878EC433C8;
	Wed, 29 Nov 2023 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701268388;
	bh=nCUBip91VJPgVyaRslm47tg3WMaKjh0DptQ7V1+aaG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKvcWnywP2uOCwGWoh/fP1tY3br+768+t7iK5/AZ4GIT9leS8LhJRzql7QKALNfgu
	 RpMq1oALiCXCTkejzxvkSrRJQOXq0zFSK4VPIaje+KdTwntmUubIdIAUb/nRPVyo0p
	 8QPYGbx3Q5TSc5ADZ2ylf2mOuQ3hP5EeFXfdpAhA+U/fQlrZ4RYWTt1J+DUrdXGBjT
	 w5OwbXD+MRpy5MgC4KnKWrnbkW1p8+XXefb+Jc+qpKSB5yO5dFUAyDWV7tw2Jj/Gym
	 +uQOWJuzDC9xhl8mCQEMU4yyTZSKba4BLEC86SIpz2m2yjOv1UtByqawi80aBojCUa
	 tOM1QGWgSP2Cw==
Date: Wed, 29 Nov 2023 14:33:03 +0000
From: Conor Dooley <conor@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v8 1/4] dt-bindings: pwm: Add bindings for OpenCores PWM
 Controller
Message-ID: <20231129-chaplain-unseeing-e433ec830946@spud>
References: <20231129092732.43387-1-william.qiu@starfivetech.com>
 <20231129092732.43387-2-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sVewkJ1jWgEyqNJ1"
Content-Disposition: inline
In-Reply-To: <20231129092732.43387-2-william.qiu@starfivetech.com>


--sVewkJ1jWgEyqNJ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 05:27:29PM +0800, William Qiu wrote:
> Add bindings for OpenCores PWM Controller.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/pwm/opencores,pwm.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/opencores,pwm.yaml
> new file mode 100644
> index 000000000000..133f2cd417f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/opencores,pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OpenCores PWM controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description:
> +  OpenCores PTC ip core contains a PWM controller. When operating in PWM=
 mode,

nit: "The OpenCores PTC IP core"

> +  the PTC core generates binary signal with user-programmable low and hi=
gh
> +  periods. All PTC counters and registers are 32-bit.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - starfive,jh7100-pwm
> +              - starfive,jh7110-pwm
> +          - const: opencores,pwm-v1

properties:
  compatible:
    items:
      - enum:
          - starfive,jh7100-pwm
          - starfive,jh7110-pwm
      - const: opencores,pwm-v1

Please use this form here instead.

Otherwise, this looks good to me now.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm@12490000 {
> +        compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
> +        reg =3D <0x12490000 0x10000>;
> +        clocks =3D <&clkgen 181>;
> +        resets =3D <&rstgen 109>;
> +        #pwm-cells =3D <3>;
> +    };
> --=20
> 2.34.1
>=20
>=20

--sVewkJ1jWgEyqNJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdLnwAKCRB4tDGHoIJi
0vPNAP4lxb47TExjCroRAbRfe1Mqkn9kvWfUqdQghEp5AktsygD/V4IHEgg4y71a
Q6fQO+IQS9o36EIZJ2aOmiys/FLW0gw=
=TUhN
-----END PGP SIGNATURE-----

--sVewkJ1jWgEyqNJ1--

