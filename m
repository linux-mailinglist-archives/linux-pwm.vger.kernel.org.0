Return-Path: <linux-pwm+bounces-5321-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F505A7A12F
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 12:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547343B5EE4
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C10224A065;
	Thu,  3 Apr 2025 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckurg04x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF29248862;
	Thu,  3 Apr 2025 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676899; cv=none; b=uH/Qey2ENYkYDTch1ohVUyEr5zl1RhfeI0VzVdxtAIoVm0C7DV3qSKmuvAMfwv2r4k6MSapkTxAoSEudLur0cT5W9VPKXlTrcZ3iVqjxoevmgJbbSNqirw6wiSE10guB+pv36ewb2Xot2WZSbbUZzZQK8Qt0Dzbze+poqFrn0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676899; c=relaxed/simple;
	bh=ARN7XYpJRXpPUgyngwnAGIRk8k4S5YsMIgbo9WqpgfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYYG87jfda7GfuyZ9Pta10U0cooexfWLqTWzS/oprSxgBvCJCbbWqWnKpP/eicuX4BbeZBeT45qrQj/O0wSxyLo4kOrn/kEkBF/veXvDHUci7VRi/+Ig+gvVpaoZXwIvwnfQMoaEU0xf/PFc61uRWBn2LVL4PUX8hH9SvvWkOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckurg04x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E034C4CEE3;
	Thu,  3 Apr 2025 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743676898;
	bh=ARN7XYpJRXpPUgyngwnAGIRk8k4S5YsMIgbo9WqpgfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckurg04xFgrLpfddbO8QPSoQYfrfzaJcxIUOBontZFAP6RGupO0YJBUx/d+JJcEIy
	 tc1l9Ppp0XmyNnrrbWoGS4+zpsZM95IPZRptSZjHfA+NGCH75ugxh7WWn5DJg/8udh
	 TcOL/6vLc0NAWHobSEHkDRMNSQJphTrR0eZ41R2SCeP7kBmItxK4YkWb0fmNFfOqV3
	 ugcOyTVT3RwbUeW9O//xcOz0bpP4He1DxlKFJcR6raDepdmpOfhPjcQSUJoQV/oqEA
	 UEa9zCfszRIHTu693zOmLW70OVnVQiwLHCg24OXDb8C9zG80R+3Q0NWpYbGzeMR/wp
	 wVAONWe4keXmw==
Date: Thu, 3 Apr 2025 12:41:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vz@mleia.com, 
	piotr.wojtaszczyk@timesys.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
Message-ID: <76ovkshf4dr6egh72uiigsugdqsin6zwy3skksldhhh2goer6x@gsp3qkhqdtev>
References: <20250312122750.6391-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eprp56w3poiehbc2"
Content-Disposition: inline
In-Reply-To: <20250312122750.6391-1-purvayeshi550@gmail.com>


--eprp56w3poiehbc2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
MIME-Version: 1.0

Hello,

On Wed, Mar 12, 2025 at 05:57:50PM +0530, Purva Yeshi wrote:
> Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
> YAML schema (`nxp,lpc3220-pwm.yaml`).
>=20
> Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.
>=20
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>

I suggest the following commit log:

    dt-bindings: pwm: Convert lpc32xx-pwm.txt to yaml format

    Convert the existing plain text binding documentation for
    nxp,lpc3220-pwm devices to a YAML schema.

    The value #pwm-cells wasn't specified before, set it to 3 to match the
    usual value for PWMs.

> diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b=
/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> new file mode 100644
> index 000000000..432a5e9d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/nxp,lpc3220-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LPC32XX PWM controller
> +
> +maintainers:
> +  - Vladimir Zapolskiy <vz@mleia.com>
> +  - Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: nxp,lpc3220-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3

The PWMs defined in arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi also have a
clocks property and in the driver it's not optional. Can you please add
it (here, in the list of required properties and the commit log)?

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pwm@4005c000 {
> +        compatible =3D "nxp,lpc3220-pwm";
> +        reg =3D <0x4005c000 0x4>;
> +        #pwm-cells =3D <3>;
> +    };

Best regards
Uwe

--eprp56w3poiehbc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfuZd0ACgkQj4D7WH0S
/k6jEwgAuuRJwfaakekR1Dqz//WqYnO+LEZGbZQSLnf9kWKg3A6eJQvWxfblNhGK
BrrDx9siqqccakNGayyBWd9dQG4NVgIUeoB+QtdYwzvhVaAnyVN4Nr5b4Wda/Go4
d7vsQMK5ge8KwAghxML75LcllDxXs0aDeiexAmKJmEa2folRYG5O2FfAGp/AhzBi
s39SvbuaWbdLkd7d5NzKStU2BoxUMTu/dk9stu1QIK12150syUUPLpJtyeXWP8tk
Hmss1Y5ayRyVpgwN8rHHM6N8UOZHmFdf0EahDHesj5gcPrfSH1jTUzds8VlhCjSv
ECAEuNX2TFAi+9eqc7/tUoPSFkgO1w==
=0WCU
-----END PGP SIGNATURE-----

--eprp56w3poiehbc2--

