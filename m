Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE32640CB0
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Dec 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiLBR53 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Dec 2022 12:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiLBR5V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Dec 2022 12:57:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDBFE61DF
        for <linux-pwm@vger.kernel.org>; Fri,  2 Dec 2022 09:57:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1AHk-0003dK-AZ; Fri, 02 Dec 2022 18:57:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1AHh-001qqf-Ln; Fri, 02 Dec 2022 18:57:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1AHg-0025zX-W2; Fri, 02 Dec 2022 18:57:13 +0100
Date:   Fri, 2 Dec 2022 18:57:12 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] pwm: stm32-lp: Use regmap_clear_bits and
 regmap_set_bits where applicable
Message-ID: <20221202175712.tz6uwalr6d46r2ad@pengutronix.de>
References: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
 <20221115111347.3705732-5-u.kleine-koenig@pengutronix.de>
 <b474ef48-f77b-807b-ce12-f5a200459933@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dnx7n762zixpg7wt"
Content-Disposition: inline
In-Reply-To: <b474ef48-f77b-807b-ce12-f5a200459933@foss.st.com>
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


--dnx7n762zixpg7wt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 11:23:14AM +0100, Fabrice Gasnier wrote:
> On 11/15/22 12:13, Uwe Kleine-K=F6nig wrote:
> > Found using coccinelle and the following semantic patch:
> >=20
> > @@
> > expression map, reg, bits;
> > @@
> >=20
> > - regmap_update_bits(map, reg, bits, bits)
> > + regmap_set_bits(map, reg, bits)
> >=20
> > @@
> > expression map, reg, bits;
> > @@
> >=20
> > - regmap_update_bits(map, reg, bits, 0)
> > + regmap_clear_bits(map, reg, bits)
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-stm32-lp.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> > index 3115abb3f52a..212bdc7d51ee 100644
> > --- a/drivers/pwm/pwm-stm32-lp.c
> > +++ b/drivers/pwm/pwm-stm32-lp.c
> > @@ -140,9 +140,8 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > =20
> >  	if (reenable) {
> >  		/* Start LP timer in continuous mode */
> > -		ret =3D regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
> > -					 STM32_LPTIM_CNTSTRT,
> > -					 STM32_LPTIM_CNTSTRT);
> > +		ret =3D regmap_set_bits(priv->regmap, STM32_LPTIM_CR,
> > +				      STM32_LPTIM_CNTSTRT);
>=20
> Hi Uwe,
>=20
> One minor suggestion here: could fit into a single line.

That would make the line 89 chars long (counting tag as usual as 8). Up
to now there is no line longer than 78 chars. So I'd not join the two
lines.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dnx7n762zixpg7wt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOKPHUACgkQwfwUeK3K
7AkThQf/azjMPUOcji5c6MwxyjUEpcAH+50ie5NEeDZGr3m9Cr/AMBErl9F15Yyu
yfmo4A/szg/Yn71jvCgRBY45yWImxAGPV4zW9UMK9vdh3skZuvqstmk8GRRDTtV3
0bHKIpvAuk1D7TqrA4sPVc05RkizDpDX0+CN97fDoZkFhBWSKCsz8bFRaBy1/6BH
UbydfZnnnza7qlem4O8Ux3iZqHBqETJfz1GHVOA8oP5akCYhHAH5CEimdXrDlHXM
netetHku4Sy64xsdICXmGb75Ey4/J+nbs7LoIwP7fXV2YnkuwYi+w0uR3Gs3kYuz
VoIVur7FA41pAqJznPx20g89ufZb+w==
=gDKC
-----END PGP SIGNATURE-----

--dnx7n762zixpg7wt--
