Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6D7E1E76
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Nov 2023 11:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFKgi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Nov 2023 05:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKgh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Nov 2023 05:36:37 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C799
        for <linux-pwm@vger.kernel.org>; Mon,  6 Nov 2023 02:36:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzwxy-0005ra-VO; Mon, 06 Nov 2023 11:36:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzwxx-0070Lj-Mc; Mon, 06 Nov 2023 11:36:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzwxx-00DYex-Cr; Mon, 06 Nov 2023 11:36:21 +0100
Date:   Mon, 6 Nov 2023 11:36:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: imx-pwm: Add constraints for
 #pwm-cells
Message-ID: <20231106103621.2fh6fkpdafpz4toa@pengutronix.de>
References: <20231106095205.231210-1-alexander.stein@ew.tq-group.com>
 <20231106095205.231210-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3daivm6c3q647yfo"
Content-Disposition: inline
In-Reply-To: <20231106095205.231210-2-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3daivm6c3q647yfo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Philippe Schenker from Cc as his email bounced in the past]

On Mon, Nov 06, 2023 at 10:52:03AM +0100, Alexander Stein wrote:
> Only fsl,imx1-pwm comptabile devices use #pwm-cells =3D <2>. Newer SoCs
> supportinverted PWM output, thus #pwm-cells needs to be set to 3.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../devicetree/bindings/pwm/imx-pwm.yaml      | 20 ++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documen=
tation/devicetree/bindings/pwm/imx-pwm.yaml
> index c01dff3b7f843..59a981c0f39ab 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> @@ -9,9 +9,6 @@ title: Freescale i.MX PWM controller
>  maintainers:
>    - Philipp Zabel <p.zabel@pengutronix.de>
> =20
> -allOf:
> -  - $ref: pwm.yaml#
> -
>  properties:
>    "#pwm-cells":
>      description: |
> @@ -74,6 +71,23 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx1-pwm
> +    then:
> +      properties:
> +        "#pwm-cells":
> +          enum: [2]

Given that arch/arm/boot/dts/nxp/imx/imx1.dtsi has:

	pwm: pwm@208000 {
		#pwm-cells =3D <3>;
		compatible =3D "fsl,imx1-pwm";
		...

this looks wrong.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3daivm6c3q647yfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVIwaQACgkQj4D7WH0S
/k42kwgAmgplLPzL3HKumoOORIuvrIZ4VIPJ2ggVleg7gjhF9LP05nC6vQSe+mGg
NUSkkBnDGiZfznHGRooLpucl1FVQlE2/MbC4/JYEj9y6NzN5f2aLBo6oPqGRO+3Q
GPdk4fScADLeYgYCmtEFpz92fH/+89DnqUPV4os8GXOROCms7/EqSj8q+P6g9d8Z
tsZUa9jyECLs2Yz73ToxEqnI6/zJABpLlW0mlkJdJjpWnaM2gr1YsYTQjRokBWM2
5M4QNmgD4DRuD3Srr9OhWW34pWtLJwKiXoVVnjxUgeiJIb1VCUVZVkDYKLE9d4N7
6ZmV3+VipY8ZFD5aFb2gAlQRASfe4g==
=uhGp
-----END PGP SIGNATURE-----

--3daivm6c3q647yfo--
