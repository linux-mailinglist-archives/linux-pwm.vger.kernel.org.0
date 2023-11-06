Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD8C7E28DD
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Nov 2023 16:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjKFPjj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Nov 2023 10:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjKFPjj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Nov 2023 10:39:39 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D730FA
        for <linux-pwm@vger.kernel.org>; Mon,  6 Nov 2023 07:39:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r01hI-0006JE-Bc; Mon, 06 Nov 2023 16:39:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r01hH-0074nU-Dn; Mon, 06 Nov 2023 16:39:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r01hH-00Dmog-4J; Mon, 06 Nov 2023 16:39:27 +0100
Date:   Mon, 6 Nov 2023 16:39:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: imx-pwm: Unify #pwm-cells for
 all compatibles
Message-ID: <20231106153926.dqvx56fegqpmw3k7@pengutronix.de>
References: <20231106151326.812099-1-alexander.stein@ew.tq-group.com>
 <20231106151326.812099-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4hmeir5x3txiqj45"
Content-Disposition: inline
In-Reply-To: <20231106151326.812099-2-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4hmeir5x3txiqj45
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 04:13:24PM +0100, Alexander Stein wrote:
> Use #pwm-cells for all i.MX variants. Only fsl,imx1-pwm does not support
> inverted PWM output. Keep it the same for consistency.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documen=
tation/devicetree/bindings/pwm/imx-pwm.yaml
> index c01dff3b7f843..a84a240a61dc1 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> @@ -14,12 +14,10 @@ allOf:
> =20
>  properties:
>    "#pwm-cells":
> -    description: |
> -      Should be 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.yaml
> -      in this directory for a description of the cells format.
> -    enum:
> -      - 2
> -      - 3
> +    description:
> +      The only third cell flag supported by this binding is
> +      PWM_POLARITY_INVERTED. fsl,imx1-pwm does not support this flags.
> +    const: 3

You dropped the | from the description line, but with my understanding
of yaml this should be fine.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4hmeir5x3txiqj45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVJCK4ACgkQj4D7WH0S
/k5AWgf/TNn/SASCnyF9eHuY6Z9NqLqPNW2jli5o4YbL4+x2kGgt9SnHBKKLr/6G
oXtNYH/N7E7t7L02lejEMeKfdRmh8w6xCGb3OcScOF5VzkTNXXqywimSB5dcAO1o
ldNpprYBVOoUBawXnnc4kLhwnAm3cDjzv1PFTcezvqvS7Rwu6oc4bJ1M1Pbi5wZw
M8w7Yzex41d+Vu6uEe9Kpeci0wMu2PoMBxvBKCqNDbXEfL9r7u5PIzYkXDhx7daw
BYei1ViDxWTRB1WzzNzYIEj7rTTDGXorP9GEY6Gd9C7XJKvYgmkwwraG6i2ROS19
b3u+YTRWULToG1MfelSbO55wOq+tDw==
=iLvq
-----END PGP SIGNATURE-----

--4hmeir5x3txiqj45--
