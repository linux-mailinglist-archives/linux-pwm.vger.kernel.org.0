Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822D763A37F
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Nov 2022 09:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiK1Iup (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Nov 2022 03:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiK1Iuo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2022 03:50:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3313D04
        for <linux-pwm@vger.kernel.org>; Mon, 28 Nov 2022 00:50:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZqW-0001D3-5W; Mon, 28 Nov 2022 09:50:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZqU-000mS0-76; Mon, 28 Nov 2022 09:50:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZqU-000sRP-4A; Mon, 28 Nov 2022 09:50:34 +0100
Date:   Mon, 28 Nov 2022 09:50:34 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: tegra: Convert to json-schema
Message-ID: <20221128085034.gurlqns5kgjitcxo@pengutronix.de>
References: <20221117214248.2365983-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyfmrxm2pqndumzl"
Content-Disposition: inline
In-Reply-To: <20221117214248.2365983-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oyfmrxm2pqndumzl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 10:42:48PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Convert the Tegra PWFM bindings from the free-form text format to
> json-schema.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - drop Tegra210 example so that validation doesn't fail due to missing
>   pinmux json-schema conversion
> - combine Tegra20 and Tegra186 compatible strings
> - drop useless description of the single clock
> - remove clock-names property
> - remove unnecessary quotes
>=20
>  .../bindings/pwm/nvidia,tegra20-pwm.txt       | 78 ---------------
>  .../bindings/pwm/nvidia,tegra20-pwm.yaml      | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-=
pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-=
pwm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt=
 b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> deleted file mode 100644
> index 47f1abf20118..000000000000
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -Tegra SoC PWFM controller
> -
> -Required properties:
> -- compatible: Must be:
> -  - "nvidia,tegra20-pwm": for Tegra20
> -  - "nvidia,tegra30-pwm", "nvidia,tegra20-pwm": for Tegra30
> -  - "nvidia,tegra114-pwm", "nvidia,tegra20-pwm": for Tegra114
> -  - "nvidia,tegra124-pwm", "nvidia,tegra20-pwm": for Tegra124
> -  - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
> -  - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
> -  - "nvidia,tegra186-pwm": for Tegra186
> -  - "nvidia,tegra194-pwm": for Tegra194
> -  - "nvidia,tegra234-pwm", "nvidia,tegra194-pwm": for Tegra234
> -- reg: physical base address and length of the controller's registers
> -- #pwm-cells: should be 2. See pwm.yaml in this directory for a descript=
ion of
> -  the cells format.
> -- clocks: Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must include the following entries:
> -  - pwm
> -
> -Optional properties:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -In some of the interface like PWM based regulator device, it is required
> -to configure the pins differently in different states, especially in sus=
pend
> -state of the system. The configuration of pin is provided via the pinctrl
> -DT node as detailed in the pinctrl DT binding document
> -	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> -
> -The PWM node will have following optional properties.
> -pinctrl-names:	Pin state names. Must be "default" and "sleep".
> -pinctrl-0:	phandle for the default/active state of pin configurations.
> -pinctrl-1:	phandle for the sleep state of pin configurations.
> -
> -Example:
> -
> -	pwm: pwm@7000a000 {
> -		compatible =3D "nvidia,tegra20-pwm";
> -		reg =3D <0x7000a000 0x100>;
> -		#pwm-cells =3D <2>;
> -		clocks =3D <&tegra_car 17>;
> -		resets =3D <&tegra_car 17>;
> -		reset-names =3D "pwm";
> -	};
> -
> -
> -Example with the pin configuration for suspend and resume:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -Suppose pin PE7 (On Tegra210) interfaced with the regulator device and
> -it requires PWM output to be tristated when system enters suspend.
> -Following will be DT binding to achieve this:
> -
> -#include <dt-bindings/pinctrl/pinctrl-tegra.h>
> -
> -	pinmux@700008d4 {
> -		pwm_active_state: pwm_active_state {
> -                        pe7 {
> -                                nvidia,pins =3D "pe7";
> -                                nvidia,tristate =3D <TEGRA_PIN_DISABLE>;
> -			};
> -		};
> -
> -		pwm_sleep_state: pwm_sleep_state {
> -                        pe7 {
> -                                nvidia,pins =3D "pe7";
> -                                nvidia,tristate =3D <TEGRA_PIN_ENABLE>;
> -			};
> -		};
> -	};
> -
> -	pwm@7000a000 {
> -		/* Mandatory PWM properties */
> -		pinctrl-names =3D "default", "sleep";
> -		pinctrl-0 =3D <&pwm_active_state>;
> -		pinctrl-1 =3D <&pwm_sleep_state>;
> -	};
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yam=
l b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> new file mode 100644
> index 000000000000..739d3155dd32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/nvidia,tegra20-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra PWFM controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nvidia,tegra20-pwm
> +          - nvidia,tegra186-pwm
> +
> +      - items:
> +          - enum:
> +              - nvidia,tegra30-pwm
> +              - nvidia,tegra114-pwm
> +              - nvidia,tegra124-pwm
> +              - nvidia,tegra132-pwm
> +              - nvidia,tegra210-pwm
> +          - enum:
> +              - nvidia,tegra20-pwm
> +
> +      - items:
> +          - const: nvidia,tegra194-pwm
> +          - const: nvidia,tegra186-pwm
> +
> +      - items:
> +          - const: nvidia,tegra234-pwm
> +          - const: nvidia,tegra194-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: module reset
> +
> +  reset-names:
> +    items:
> +      - const: pwm
> +
> +  "#pwm-cells":
> +    const: 2

While the driver supports #pwm-cells =3D <3> it makes little sense to
allow it as it only supports one polarity. Still I wonder if we should
allow 3 here for consistency with other drivers/bindings.

But as 2 is fine, I don't care deeply and allowing 3 would be out of
scope for a conversion from txt to yaml:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oyfmrxm2pqndumzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEdlUACgkQwfwUeK3K
7AlgfQgAiMLZY+TwMRvKksahgqvWzti0r13Ko/K4vipsLv906G3FEL8whsQi04rz
MGnwSTqYFrbV13ebzpJhmYdNhA+sJ/65+fBgUyNndTb0iWutVlFWz7UtoL5FxsXz
BjHtSGbZThU9YmkMLdlyelsLb6IBatNP9DBnSnhceHULhMpaYdR/NnVdkLeHsZAT
qU/YV+3uhbuiLMjhysok1kvJj9EwVQUFBKe8tXSL/2rMH908qG/+SUyca1PqJD+C
KB+kCVJ4TAg2xtIn6fMeh91I8qvvQg2jd5hgazrlC7wmM4+9xsw/plZEF/hLDUeF
uA6GFiOrCun2mTDU4O4cSNtZt7Nptg==
=Vb3t
-----END PGP SIGNATURE-----

--oyfmrxm2pqndumzl--
