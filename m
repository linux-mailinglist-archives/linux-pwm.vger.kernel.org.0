Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED061FF31
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 21:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKGUJv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 15:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiKGUJv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 15:09:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE2220EB
        for <linux-pwm@vger.kernel.org>; Mon,  7 Nov 2022 12:09:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8R1-0004nx-VZ; Mon, 07 Nov 2022 21:09:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8Qx-002uxN-3v; Mon, 07 Nov 2022 21:09:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8Qx-00F2UB-90; Mon, 07 Nov 2022 21:09:27 +0100
Date:   Mon, 7 Nov 2022 21:09:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: pwm: allwinner,sun4i-a10: Add
 F1C100s compatible
Message-ID: <20221107200925.ybrxyvlgn4bmth6g@pengutronix.de>
References: <20221107005433.11079-1-andre.przywara@arm.com>
 <20221107005433.11079-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctwhlbxxw6thwo6y"
Content-Disposition: inline
In-Reply-To: <20221107005433.11079-2-andre.przywara@arm.com>
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


--ctwhlbxxw6thwo6y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 12:54:24AM +0000, Andre Przywara wrote:
> The PWM controller in the Allwinner F1C100s series of SoCs is the same
> as in the A20 SoCs, so allow using that as the fallback name.
>=20
> Join the V3s compatible string in an enum on the way.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pw=
m.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 4cc3cc7c50be..66e400f2a3a4 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -25,7 +25,9 @@ properties:
>            - const: allwinner,sun8i-a83t-pwm
>            - const: allwinner,sun8i-h3-pwm
>        - items:
> -          - const: allwinner,sun8i-v3s-pwm
> +          - enum:
> +              - allwinner,suniv-f1c100s-pwm
> +              - allwinner,sun8i-v3s-pwm

LGTM

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ctwhlbxxw6thwo6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNpZfMACgkQwfwUeK3K
7AkanQf/TOE+zguKbxcD3MlFfApcbGDqejLVCz9lJedUELLCCUtJ8xiKVT8pcVSa
GaUKAuV5OSFYtM9tNxOQBmLnYdilKqxKqBuLGrl0GkgWfMrFRzEpcPy+E1EZz2CQ
YHDvR/AsjWPPDKfnL9chCO7lRTKqlv1lWuIukbYwvSeY0VM12MYsu6YpFKdMz1VO
YiMFhqw3l7mDgShb5VecAW7nGMsO5KGfGuteHvb3SkpK8yQmO5k+Ts+Se/7YKfzS
7nrCM0Ucuvba5iFv9a3V23fu4lTTP7MfkOGnjSthE2tRWkRTnWhwGMOh0N5vEnnT
IMxafQhBqpKVeCP8bm9ExGaXX3f88Q==
=mPTD
-----END PGP SIGNATURE-----

--ctwhlbxxw6thwo6y--
