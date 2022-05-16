Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7EB527DD7
	for <lists+linux-pwm@lfdr.de>; Mon, 16 May 2022 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiEPGwW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 May 2022 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbiEPGwN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 May 2022 02:52:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B97369D5
        for <linux-pwm@vger.kernel.org>; Sun, 15 May 2022 23:52:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqUa6-0006b7-7z; Mon, 16 May 2022 08:51:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqUa1-002cQR-Ov; Mon, 16 May 2022 08:51:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqUZz-00A274-Fr; Mon, 16 May 2022 08:51:43 +0200
Date:   Mon, 16 May 2022 08:51:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
Message-ID: <20220516065140.kdrcihx5ifyeuen2@pengutronix.de>
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jdgb46nmbhxo5jso"
Content-Disposition: inline
In-Reply-To: <20220510144259.9908-2-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jdgb46nmbhxo5jso
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 10, 2022 at 03:42:58PM +0100, Biju Das wrote:
> Add device tree bindings for the General PWM Timer (GPT).
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

assuming you will tackle my comments for patch 2/2 and will resend this
patch along with a new version, I discard the dt patch from the queue
(i.e. mark it as "not applicable" in patchwork).

Applying this one alone isn't that sensible.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jdgb46nmbhxo5jso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKB9HkACgkQwfwUeK3K
7AmFpgf/TBgddKqgHS84pomumDKEGtKHixbGIIm6U4YoOgLyCRz/znyAiTmWTGbC
X11m4x+UnHGGCh/cQuPtz6rKg1+acnG7v01UMgX/lw/JmmJHjRpv6vlAD3ZNw7/w
ENiUsw9Uzn02VAiuvQmBkFg7S4oayMV6kY4Q8RM++bOr2v/71PZj08LhAIXrPZzi
g6Yacc9rOur2DhSUvtX8gjeEuXF9L4K/jswbkDxzxRwqb6Gruxy0LFOheRgNrvbt
Ub/kYdanAA5HmS7YIr4eS/eTZkwxFoM+KIWu1GrYUNBsbKHOI98KtXlp4rEfstb/
2Qq/HfrLRbd2xTSLYM+pDK6N0y8R7w==
=JHgI
-----END PGP SIGNATURE-----

--jdgb46nmbhxo5jso--
