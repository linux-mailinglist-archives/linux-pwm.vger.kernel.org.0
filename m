Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752C362274E
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Nov 2022 10:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKIJl2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Nov 2022 04:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKIJlR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Nov 2022 04:41:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A9B1F9DD
        for <linux-pwm@vger.kernel.org>; Wed,  9 Nov 2022 01:41:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1osha3-0007X8-V5; Wed, 09 Nov 2022 10:41:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osha2-003DyK-1x; Wed, 09 Nov 2022 10:41:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osha2-00FOBJ-Bn; Wed, 09 Nov 2022 10:41:10 +0100
Date:   Wed, 9 Nov 2022 10:41:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: renesas,tpu: Add r8a779g0 support
Message-ID: <20221109094110.5btcckv7t76acidq@pengutronix.de>
References: <f5ad691051f69f2dbfcb5c5a722960bd9cd41b06.1665156364.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4vbctexf7nhbsgzr"
Content-Disposition: inline
In-Reply-To: <f5ad691051f69f2dbfcb5c5a722960bd9cd41b06.1665156364.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4vbctexf7nhbsgzr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 07, 2022 at 05:26:37PM +0200, Geert Uytterhoeven wrote:
> Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
> R-Car V4H (R8A779G0) SoC.
>=20
> Based on a patch in the BSP by CongDang.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Same question as for the renesas,pwm-rcar patch: Who will pick this up?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4vbctexf7nhbsgzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNrdbMACgkQwfwUeK3K
7AkNYAf9Grvg0zcs3zy3RJ5sn51EhFGrAIKkZWbhhElOZZ4yNf1H85szMVZMe0vT
ovuUAGtI2Ol84pSKEoDeIyGxfyObfj2d+vGK1ZTtdgXJtD0CxWc4J+UhBfvx5RIu
iGAAWR6ir3ae0VnZv1hP58knUInl/UNLXOHTsxs0/OyVwGcsDfD/baVrX2SFxPab
jgyYER1h0+tmC2PxiECN0hoNug/CznQS+FYxNP0DRTXYBhnvgZrXkgwE7FHP2v8m
4RLzF7sSivC9zLrXYzHa3GZXumDpqZZskNkNvf38HXY8BkX/i2Wdf9N//ZsNlvWo
Y1bwa4gTLNh+hfZ5yYWR12FEqLU5Og==
=I7kE
-----END PGP SIGNATURE-----

--4vbctexf7nhbsgzr--
