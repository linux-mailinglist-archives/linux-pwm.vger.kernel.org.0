Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAFE37957B
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhEJR2W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhEJR2T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 13:28:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76DC061574
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 10:27:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9gS-0002jf-3l; Mon, 10 May 2021 19:27:08 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9gQ-00063v-JJ; Mon, 10 May 2021 19:27:06 +0200
Date:   Mon, 10 May 2021 19:27:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pwm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 RESEND 1/6] clk: generalize devm_clk_get() a bit
Message-ID: <20210510172706.lfafdkfevya7ycqq@pengutronix.de>
References: <20210510061724.940447-1-u.kleine-koenig@pengutronix.de>
 <20210510061724.940447-2-u.kleine-koenig@pengutronix.de>
 <20210510180205.000004dd@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="la5yu5g5mopezfed"
Content-Disposition: inline
In-Reply-To: <20210510180205.000004dd@Huawei.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--la5yu5g5mopezfed
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 06:02:05PM +0100, Jonathan Cameron wrote:
> On Mon, 10 May 2021 08:17:19 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Allow to add an exit hook to devm managed clocks. Also use
> > clk_get_optional() in devm_clk_get_optional instead of open coding it.
> > The generalisation will be used in the next commit to add some more
> > devm_clk helpers.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> If feels marginally odd to register cleanup that we know won't do anything
> for the optional case, but it works as far as I can tell and it would be
> a little fiddly to special case it.

It took a moment for me to understand your concern. Yes, I register a
cleanup even if (*init) happens to be clk_get_optional() and it returned
NULL. It's not hard to optimize that:

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index b54f7f0f2a35..2420d6ae7b33 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -38,14 +38,17 @@ static struct clk *__devm_clk_get(struct device *dev, c=
onst char *id,
 		goto err_clk_get;
 	}
=20
-	if (init) {
-		ret =3D init(clk);
-		if (ret)
-			goto err_clk_init;
+	/* short-cut the case where clk_get_optional returned NULL */
+	if (clk) {
+		if (init) {
+			ret =3D init(clk);
+			if (ret)
+				goto err_clk_init;
+		}
+		state->exit =3D exit;
 	}
=20
 	state->clk =3D clk;
-	state->exit =3D exit;
=20
 	devres_add(dev, state);

But I'd value simplicity over micro-optimizing and keep the code as is.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--la5yu5g5mopezfed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCZbOcACgkQwfwUeK3K
7AmXIQf/c3HuQfNTch4Xl+/TfVW1wBEkH4bhu2025v3mpSfZGRNTmKlBBMjvoJaQ
ZaaoVaze/k9HY4AZPbYTsofDgDsRK2qFUDeKG4QF+kSxQ1YRsi3nDqwApmEtzbS2
ANIm9kR97cOBMb3fxo7FZpCifLB/4fWyScYFksgu8INDv8qK+/U5NZvBgUzVZ29o
K7va7sm/jadYgihQ/f4aJnNhCsGxMNxIP3SrMZM04AsY9J+smEdwYX/na6Px54Sj
RqIK1fK7Ewiq2Be7fPuARD4JVRXWrxbpQ4wY8bkG5ZtqnxPz/dTQRcCYZDwSBozv
v3RANwxRr6pdDrO/ECcd3myx7Mc33Q==
=oeyl
-----END PGP SIGNATURE-----

--la5yu5g5mopezfed--
