Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F475A7C9
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jul 2023 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjGTHaF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jul 2023 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGTHaE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2023 03:30:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A042681
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 00:30:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMO6q-0000YU-LC; Thu, 20 Jul 2023 09:30:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMO6p-000mYZ-RE; Thu, 20 Jul 2023 09:29:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMO6p-006IWK-0G; Thu, 20 Jul 2023 09:29:59 +0200
Date:   Thu, 20 Jul 2023 09:29:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/10] pwm: atmel-hlcdc: Use consistent variable naming
Message-ID: <20230720072958.r54d23cefbrytw7r@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-3-u.kleine-koenig@pengutronix.de>
 <ZLjZ_lllJ1PT3O5H@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nyhuzpljh2euysuc"
Content-Disposition: inline
In-Reply-To: <ZLjZ_lllJ1PT3O5H@orome>
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


--nyhuzpljh2euysuc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 08:53:50AM +0200, Thierry Reding wrote:
> On Fri, Jul 14, 2023 at 10:56:15PM +0200, Uwe Kleine-K=F6nig wrote:
> > In pwm drivers the variable name "chip" is usually only used for struct
> > pwm_chip pointers. This driver however used "chip" for its driver data
> > and pwm_chip pointers are named "chip", too, when there is no driver
> > data around and "c" otherwise. Instead use "ddata" for driver data and
> > always "chip" for pwm_chips.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-atmel-hlcdc.c | 64 +++++++++++++++++------------------
> >  1 file changed, 32 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcd=
c.c
> > index 96a709a9d49a..9b0165d61c49 100644
> > --- a/drivers/pwm/pwm-atmel-hlcdc.c
> > +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> > @@ -38,11 +38,11 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcd=
c_pwm(struct pwm_chip *chip)
> >  	return container_of(chip, struct atmel_hlcdc_pwm, chip);
> >  }
> > =20
> > -static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device=
 *pwm,
> > +static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> >  				 const struct pwm_state *state)
> >  {
> > -	struct atmel_hlcdc_pwm *chip =3D to_atmel_hlcdc_pwm(c);
> > -	struct atmel_hlcdc *hlcdc =3D chip->hlcdc;
> > +	struct atmel_hlcdc_pwm *ddata =3D to_atmel_hlcdc_pwm(chip);
>=20
> Can we not just use something like "data", "priv" or "atmel"? "ddata" is
> horrific and looks like a typo.

I like "ddata" which isn't so uncommon (pwm-atmel-hlcdc and pwm-sifive
use it and git grep '\<ddata\>' suggests it's common in other parts of
the kernel, too.)
It's the same naming scheme as "pdata". If you feel strong here, do you
like "drvdata" better? Among your suggestions my favourite is "priv".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nyhuzpljh2euysuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS44nYACgkQj4D7WH0S
/k65swf+PLbiBGLhuJxGlEqCN24bBR//G29XkUvjWFyR+6hndQuidOJ2Z6D9O/cS
yX318qTz21VjCccePHn9l72g+zOagM2k+Uk9Sb3CVoRHn7v5OWVGDZD+jDW+JLNW
hkhMduEqZCAuAu2e5Mv+uYXNo1iRz7Y1GEWgsFS84Nzi9yobX/477hnAgkSMoKuG
01ogM72EkMHIDneHY9wQ2RNyweJlXOFrIlB+KGRRdZ7X+oGtJ5PDOCORTkeoO/b/
QBLb5x7zlGedjLEYGGy8QBFYMVdQOX9NbPah0PIPcdiT15JCXGudrul9LGBIaKPf
aTDwd/oTXhLn+9lPuSTsyCv1bhJV1Q==
=Rd0Q
-----END PGP SIGNATURE-----

--nyhuzpljh2euysuc--
