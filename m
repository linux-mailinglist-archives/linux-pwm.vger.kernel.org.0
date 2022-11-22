Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7866763481A
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Nov 2022 21:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiKVU0z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Nov 2022 15:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiKVU0l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Nov 2022 15:26:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F45BD6F
        for <linux-pwm@vger.kernel.org>; Tue, 22 Nov 2022 12:26:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxZqg-0007mI-Mb; Tue, 22 Nov 2022 21:26:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxZqe-005v29-6E; Tue, 22 Nov 2022 21:26:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxZqe-000s99-Gn; Tue, 22 Nov 2022 21:26:28 +0100
Date:   Tue, 22 Nov 2022 21:26:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Allow decimal format in
 addition to hex format
Message-ID: <20221122202624.zsudqa2azpdw22gx@pengutronix.de>
References: <20221122123225.59106-1-tony@atomide.com>
 <20221122133825.d67q4q6k3wkncucj@pengutronix.de>
 <Y3zRpgY1cXCKsJCu@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="flij3xzkn4w2n4q5"
Content-Disposition: inline
In-Reply-To: <Y3zRpgY1cXCKsJCu@atomide.com>
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


--flij3xzkn4w2n4q5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Tony,

On Tue, Nov 22, 2022 at 03:41:58PM +0200, Tony Lindgren wrote:
> * Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [221122 13:28]:
> > On Tue, Nov 22, 2022 at 02:32:24PM +0200, Tony Lindgren wrote:
> > > Let's allow node numbering in decimal format too.
> > >=20
> > > Simple human-readable increments/IDs are usually decimal, hex is only=
 for
> > > addresses as noted by Krzysztof Kozlowski <krzysztof.kozlowski@linaro=
=2Eorg>.
> > >=20
> > > Let's use an improved match suggested by Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> and improved a bit by Uwe Kleine-K=
=F6nig
> > > <u.kleine-koenig@pengutronix.de>.
> > >=20
> > > Cc: linux-pwm@vger.kernel.org
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Which tree should this merged through? The obvious candidates are pwm,
> > dt and omap.
>=20
> The dt folks usually queue the binding patches separately.

fine, so I marked your series in the PWM patchwork as "handled-elsewhere".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--flij3xzkn4w2n4q5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN9MG0ACgkQwfwUeK3K
7AmjBAgAkc70OZy1zQfFXnIQH4R9fKwJmpAJJuhUAWdB9RvUERDB3VU0iFvQAZyJ
j4WoDWfKt3lnPknZSIvpogOOaxHGiCKXB1dfupTuCp20Cf7iu1T6Goz9Hv4NnPfm
JfPAttsCYUSeBOBLsW94INRn90CWSXOr7IqLIi1eoi8JaNIqR/qHmxiE6OZOQBMB
eXczP75rgiZqAww+jsy/bG4fjtfEMhCyAJ63/4sxiAvJh8M/RkA0RsDmmGquIAsa
1RwXrGilZRRFkECS5mSki0TEsZQ2930gadQPmNzwRE9QXtGE6lEvB3IFdDNpNa1Y
1rXaBtUibezAPqGa23I3WMWgFLWy5g==
=Far5
-----END PGP SIGNATURE-----

--flij3xzkn4w2n4q5--
