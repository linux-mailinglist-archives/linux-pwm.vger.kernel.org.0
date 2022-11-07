Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845D961FEF9
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 20:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiKGT6g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 14:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiKGT6f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 14:58:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D631903B
        for <linux-pwm@vger.kernel.org>; Mon,  7 Nov 2022 11:58:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8GI-0003Vc-Kv; Mon, 07 Nov 2022 20:58:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8GG-002uvq-HR; Mon, 07 Nov 2022 20:58:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8GG-00F2Sd-Oq; Mon, 07 Nov 2022 20:58:24 +0100
Date:   Mon, 7 Nov 2022 20:58:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: tegra: Convert to json-schema
Message-ID: <20221107195823.bitmyx6uyjdwgln2@pengutronix.de>
References: <20221103120137.1467905-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ipqj7xouaflyhqta"
Content-Disposition: inline
In-Reply-To: <20221103120137.1467905-1-thierry.reding@gmail.com>
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


--ipqj7xouaflyhqta
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 01:01:37PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Convert the Tegra PWFM bindings from the free-form text format to

I hope I don't miss anything, but I think you want s/PWFM/PWM/.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ipqj7xouaflyhqta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNpY1wACgkQwfwUeK3K
7Amutgf/dE+jw7sKcbbw6d03dy1UwqCQ8M6EsJFxVSo37tRtznR3TJhIwWVs9JOm
OBcnIRILU2hCFVChIY3W+Eb5/Dx/BD9ZVXL526EezOKTNohM4mrG72E2w05p/E5L
r8De1hGTyhSqKvMIeSDrRwPv9dytLpGIwb/VRc3Yju5ujClgTwFJI42W4A1ysDeU
gd5JNXVAWgzGDZXOoBBCfrhtHNZRXS9c9S0t+GjOiQPtrf90Hr0OgUZ4C69ibuBu
K6h7VilNew1I8nZ5PepOIokve7KN5m/a63Rg6arGxG5wpFQYUvCOxhXy4iHphbgm
0BFoiN4EqZVpdjBf96XiGiKJjpmiVw==
=02Tk
-----END PGP SIGNATURE-----

--ipqj7xouaflyhqta--
