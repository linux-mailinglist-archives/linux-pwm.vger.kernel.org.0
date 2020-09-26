Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F027999C
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Sep 2020 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIZNW3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 26 Sep 2020 09:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZNW3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Sep 2020 09:22:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29387C0613CE
        for <linux-pwm@vger.kernel.org>; Sat, 26 Sep 2020 06:22:29 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMA9b-00080u-MV; Sat, 26 Sep 2020 15:22:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMA9a-0001Nn-5W; Sat, 26 Sep 2020 15:22:18 +0200
Date:   Sat, 26 Sep 2020 15:22:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: imx: document i.MX compatibles
Message-ID: <20200926132217.xr3rhv7o2o2yc2l7@pengutronix.de>
References: <20200925212609.23093-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4a2n2kmrp36wo5e7"
Content-Disposition: inline
In-Reply-To: <20200925212609.23093-1-krzk@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4a2n2kmrp36wo5e7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 11:26:09PM +0200, Krzysztof Kozlowski wrote:
> Document all ARMv5, ARMv6 and ARMv7 i.MX compatibles to fix dtbs_check
> warnings like:
>=20
>   arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml: pwm@2080000: compatib=
le:0:
>     'fsl,imx6q-pwm' is not one of ['fsl,imx8mm-pwm', 'fsl,imx8mn-pwm', 'f=
sl,imx8mp-pwm', 'fsl,imx8mq-pwm']
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documen=
tation/devicetree/bindings/pwm/imx-pwm.yaml
> index 473863eb67e5..379d693889f6 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> @@ -25,6 +25,17 @@ properties:
>            - fsl,imx27-pwm
>        - items:
>            - enum:
> +              - fsl,imx25-pwm

The driver actually used fsl,imx27-pwm to bind ...

Also since v5.1-rc1~38^2~17 the driver is split into pwm-imx27 and
pwm-imx1. So maybe this file should be renamed to fsl,imx27-pwm.yaml?
(And we need a volunteer to write fsl,imx1-pwm.yaml.)

> +              - fsl,imx31-pwm
> +              - fsl,imx50-pwm
> +              - fsl,imx51-pwm
> +              - fsl,imx53-pwm
> +              - fsl,imx6q-pwm
> +              - fsl,imx6sl-pwm
> +              - fsl,imx6sll-pwm
> +              - fsl,imx6sx-pwm
> +              - fsl,imx6ul-pwm
> +              - fsl,imx7d-pwm
>                - fsl,imx8mm-pwm
>                - fsl,imx8mn-pwm
>                - fsl,imx8mp-pwm

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4a2n2kmrp36wo5e7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9vQIcACgkQwfwUeK3K
7AmO/wf/SwA4EMbizbFMc/g26B6oURR0BpgMwryIR4tWauBOl5S62H4L/FGubOoq
PZgrsS1cWnl5TeOHEamu8rPq4XQ6NIsKTN731nu9LGPp5M63A8RCzxcwIjBQZYEd
XhGss6SgAi9pOmGJWBA4aBRdNRVUlo9BzpNPAyFbQUW52IWe7pQnn5rW3BNNb0kN
m+qszVDXiY938BLSuCXELJ7yCoKep7Pxn/OAu0lcSOp3u8Yv9WaiNWRM06pBUsFg
dTD1gCZI6VUDw/pplf6uF4Krb0vSNc9fWgq2IxGpCTO0S0t3YpiEhWujoj7Td7JM
miH2yzSVov7zMiJsJYaLHjGhf4qmlw==
=hOg4
-----END PGP SIGNATURE-----

--4a2n2kmrp36wo5e7--
