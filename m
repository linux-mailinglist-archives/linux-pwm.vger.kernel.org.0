Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1B7E1EB5
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Nov 2023 11:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjKFKnQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Nov 2023 05:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKFKnP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Nov 2023 05:43:15 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9032994
        for <linux-pwm@vger.kernel.org>; Mon,  6 Nov 2023 02:43:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzx4T-0006mM-Gc; Mon, 06 Nov 2023 11:43:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzx4S-0070Mg-UN; Mon, 06 Nov 2023 11:43:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzx4S-00DYxW-L9; Mon, 06 Nov 2023 11:43:04 +0100
Date:   Mon, 6 Nov 2023 11:43:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: samsung: Fix a bit test in
 pwm_samsung_resume()
Message-ID: <20231106104304.cq6353tj5pfdffyc@pengutronix.de>
References: <e031db45-add0-4da7-97fa-dee95ee936ad@moroto.mountain>
 <20231025121103.ptck4z62wvndgdlr@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sf7jdeeib2wrdg7j"
Content-Disposition: inline
In-Reply-To: <20231025121103.ptck4z62wvndgdlr@pengutronix.de>
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


--sf7jdeeib2wrdg7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Oct 25, 2023 at 02:11:03PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Oct 25, 2023 at 02:57:34PM +0300, Dan Carpenter wrote:
> > The PWMF_REQUESTED enum is supposed to be used with test_bit() and not
> > used as in a bitwise AND.  In this specific code the flag will never be
> > set so the function is effectively a no-op.
> >=20
> > Fixes: e3fe982b2e4e ("pwm: samsung: Put per-channel data into driver da=
ta")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>=20
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> @Thierry: e3fe982b2e4e is currently in your for-next branch. So it would
> be good to get Dan's patch into your PR for 6.7-rc1.

I saw you updated your for-next branch but didn't add this patch yet.
Would be great to get this one in to not get a known-broken state into
6.7-rc1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sf7jdeeib2wrdg7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVIwzcACgkQj4D7WH0S
/k6HfggAuLzuNztYJ90zdJk4FBdCGz7VtSi2zRm4cN+QJ3PRBuR1akw07gRXBBLD
D08odKKsrPo33GScRHaBPUtFEbBcKyoE5xl0pHps7pgpS+WhCHsryDrrZ4uCEqBK
7aUWFwzLUKgv/MMuFTrbhHSkK6LwMRi1vbiGO4/QlMjty8vZadE1Tx+S5Qww4Oc2
f4jDt9f74a8OWDWdygHdai3W1Xn8c/N5CZ4kV4p5BjdcaG277WwTRreEVsQAleIV
+HSEmxxib6VvUxpf7Ha8r0rnIFgrzLHfB41XajJYWw7snmr4ZVteUDnUEsJswP0T
BaJ+o4P1knAaw0z66JqRb6t+eQ9TaQ==
=Xh6W
-----END PGP SIGNATURE-----

--sf7jdeeib2wrdg7j--
