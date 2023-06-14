Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36DE72F4DB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jun 2023 08:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbjFNGbr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jun 2023 02:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbjFNGbG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jun 2023 02:31:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7CE10E3
        for <linux-pwm@vger.kernel.org>; Tue, 13 Jun 2023 23:30:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9K1Z-000538-PW; Wed, 14 Jun 2023 08:30:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9K1Y-007IEA-JX; Wed, 14 Jun 2023 08:30:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9K1X-00E7Wt-VI; Wed, 14 Jun 2023 08:30:31 +0200
Date:   Wed, 14 Jun 2023 08:30:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: ab8500: Fix error code in probe()
Message-ID: <20230614063031.xnqubkav3ej4fipu@pengutronix.de>
References: <ffc1e98d-0db4-4b8a-9e49-eb87ef844cbd@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xhvrojtvxwtepzik"
Content-Disposition: inline
In-Reply-To: <ffc1e98d-0db4-4b8a-9e49-eb87ef844cbd@kili.mountain>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xhvrojtvxwtepzik
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dan,

On Mon, May 22, 2023 at 02:07:42PM +0300, Dan Carpenter wrote:
> This code accidentally return positive EINVAL instead of negative
> -EINVAL.
>=20
> Fixes: eb41f334589d ("pwm: ab8500: Fix register offset calculation to not=
 depend on probe order")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xhvrojtvxwtepzik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSJXocACgkQj4D7WH0S
/k7aFQf+JJiCIVoazwQd13E22L0JneINkceZegeyTadrVnAA9PWDDl5Cg/cOD4Pe
gVyC/9jcsFi/SLaz88o3FcYxYRl6yaYdN92fLcFEutLkky7VseSX3PZvTgRQ8C5i
WwzULwDagtPMhq6zO7MNSjza8gypB2Qhamih0oPF3LL1rCbs0Fv0JTa5hEXKf1i/
n9cRsMWfLvoJfXzAyjYdUpD5KoXtnwumYilzKZQp0P57caMGHcg4L480+chgvPGl
2npMte3WbphRo/D1EBUdItKyA1Xd29+0WLE7QGcxQHT88e9ShNKsDPqEs/sLP8Mz
T1ZlKBrn4lCreLYvNHdbA3P6XZqbyg==
=HaEo
-----END PGP SIGNATURE-----

--xhvrojtvxwtepzik--
