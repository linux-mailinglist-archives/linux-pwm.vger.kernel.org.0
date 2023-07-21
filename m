Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7324A75D0FC
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jul 2023 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGUR6Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jul 2023 13:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGUR6X (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jul 2023 13:58:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D253588
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jul 2023 10:58:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMuOI-0004q2-F7; Fri, 21 Jul 2023 19:58:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMuOH-0017RA-DW; Fri, 21 Jul 2023 19:58:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMuOG-006hgs-HH; Fri, 21 Jul 2023 19:58:08 +0200
Date:   Fri, 21 Jul 2023 19:58:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/10] pwm: atmel-hlcdc: Use consistent variable naming
Message-ID: <20230721175804.ent7umly5jjdyy4t@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-3-u.kleine-koenig@pengutronix.de>
 <ZLjZ_lllJ1PT3O5H@orome>
 <20230720072958.r54d23cefbrytw7r@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bb3gkgkuzy5py7vq"
Content-Disposition: inline
In-Reply-To: <20230720072958.r54d23cefbrytw7r@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bb3gkgkuzy5py7vq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Jul 20, 2023 at 09:29:58AM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Jul 20, 2023 at 08:53:50AM +0200, Thierry Reding wrote:
> > On Fri, Jul 14, 2023 at 10:56:15PM +0200, Uwe Kleine-K=F6nig wrote:
> > > [...]
> > > -	struct atmel_hlcdc_pwm *chip =3D to_atmel_hlcdc_pwm(c);
> > > -	struct atmel_hlcdc *hlcdc =3D chip->hlcdc;
> > > +	struct atmel_hlcdc_pwm *ddata =3D to_atmel_hlcdc_pwm(chip);
> >=20
> > Can we not just use something like "data", "priv" or "atmel"? "ddata" is
> > horrific and looks like a typo.
>=20
> I like "ddata" which isn't so uncommon (pwm-atmel-hlcdc and pwm-sifive
> use it

I have to correct this. pwm-atmel-hlcdc only used it after this patch of
course. But there is pwm-sti which uses it and the two stm32 drivers use
if for driver data of the pwm's parent device.

> and git grep '\<ddata\>' suggests it's common in other parts of
> the kernel, too.)
> It's the same naming scheme as "pdata". If you feel strong here, do you
> like "drvdata" better? Among your suggestions my favourite is "priv".

I noticed you applied my patch and replaced "ddata" by "atmel" without
mentioning that in the commit log or this thread.

After my reply above, that's pretty steep.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bb3gkgkuzy5py7vq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS6xywACgkQj4D7WH0S
/k6HOwf9EHV2opiYgy+lvBXmGIpTvhGQtGtgIYiHRLgSNQOn6qJsfDkEcRhaeC5Q
u5gc/qwHcxpboAprCXIPhzmDLbyeXfY4ODI+HuyM00R9wM6rPwovFhn4KgePsX6v
BvaV/dkKydQu8+bEoiKkHiMrIaPKHI2jKuoafSJZfxHrXWjpEHGNnOoTE2eepV6t
eS3XA6AP5Q9Waz3Uw6ugWKNrCccB7MUxu5l9zjeMe9pU2P4KP/mXwiFR/414OKhi
ym6sPIXa8crFmCPot/WyRvR26mQdDgK8jgcnadTfv4JcDbAranttoaq9E1TpGyt+
dqUgZmdKq0RWdB8znKlSPS+0xrBHBw==
=LgY0
-----END PGP SIGNATURE-----

--bb3gkgkuzy5py7vq--
