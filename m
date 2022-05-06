Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8751D5B9
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390951AbiEFK1F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 06:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390957AbiEFK1D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 06:27:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9665DBFD
        for <linux-pwm@vger.kernel.org>; Fri,  6 May 2022 03:23:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmv73-0007du-Hy; Fri, 06 May 2022 12:23:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmv72-000gbE-Dd; Fri, 06 May 2022 12:23:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmv6z-007w0c-W8; Fri, 06 May 2022 12:23:02 +0200
Date:   Fri, 6 May 2022 12:23:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan: dynamically
 switch regulator
Message-ID: <20220506102301.my2tsn7kfldwqtll@pengutronix.de>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
 <2112012.Mh6RI2rZIc@steina-w>
 <20220506082001.hybxzaic5wza7irh@pengutronix.de>
 <2371611.jE0xQCEvom@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="znao3oovx5xyeszy"
Content-Disposition: inline
In-Reply-To: <2371611.jE0xQCEvom@steina-w>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--znao3oovx5xyeszy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 06, 2022 at 10:35:21AM +0200, Alexander Stein wrote:
> Am Freitag, 6. Mai 2022, 10:20:01 CEST schrieb Uwe Kleine-K=F6nig:
> > * PGP Signed by an unknown key
> >=20
> > Hello,
> >=20
> > On Fri, May 06, 2022 at 09:15:55AM +0200, Alexander Stein wrote:
> > > Am Freitag, 6. Mai 2022, 00:00:37 CEST schrieb Guenter Roeck:
> > > > On Wed, May 04, 2022 at 02:45:51PM +0200, Alexander Stein wrote:
> > > > > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > > > >=20
> > > > > A pwm value equal to zero is meant to switch off the pwm
> > > > > hence also switching off the fan. Currently the optional
> > > > > regulator is always on. When using this driver on boards
> > > > > with an inverted pwm signal polarity this can cause running
> > > > > the fan at maximum speed when setting pwm to zero.
> > > >=20
> > > > The appropriate solution in this case would be to tell the
> > > > software that the pwm is inverted. Turning off the regulator
> > > > in that situation is a bad idea since setting the pwm value to
> > > > 1 would set it to almost full speed. That does not really make
> > > > sense.
> > >=20
> > > The pwm-fan driver is already configured for inverted PWM (ommited so=
me
> > > properties for shortness):
> > > fan0: pwm-fan {
> > >=20
> > > 	compatible =3D "pwm-fan";
> > > 	fan-supply =3D <&reg_pwm_fan>;
> > > 	pwms =3D <&pwm3 0 40000 PWM_POLARITY_INVERTED>;
> > > 	cooling-levels =3D <0 32 64 128 196 240>;
> > >=20
> > > [...]
> > > };
> > >=20
> > > The problem here is that the pwm-fan driver currently enables the
> > > regulator
> > > unconditionally, but the PWM only when the fan is enabled, refer to
> > > __set_pwm(). This results in a fan at full speed when pwm-fan is idle=
, as
> > > pwm state is not enabled.
> >=20
> > Which PWM driver are you using?
>=20
> It's pwm-imx27 on a imx8mp based board.

This is one of the known offenders.

> > There is an implicit assumption in some PWM consumers that a disabled
> > PWM emits the inactive level. However not all PWMs do this. Is this such
> > a case?
>=20
> Oh, I was not aware of that assumption. As far I can tell, this assumptio=
n=20
> might actually be violated in pwm-imx27.

The pwm-imx27 driver is a known offender.

IMHO the problem is that there is no properly documented definition what
"disabled" means for a PWM. I had some discussions about that in the
past with Thierry, but with no agreement. Either we have do define that
the output of a PWM is undefined when it's disabled (then the pwm-fan
needs fixing) or the output must be the inactive level (then the
pwm-imx27 must be fixed to not unset the EN bit when configured for an
inverted polarity). In my eyes the first is the sensible thing to do.

See
https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf43@pengutron=
ix.de/
for one of the previous discussions.

> If state->enabled=3D=3Dfalse then the EN Bit in PWMCR is not set which mo=
st=20
> probably renders the output polarity in POUTC as inactive.

It drives the output to 0 which in the inverted polarity case is a 100%
relative duty.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--znao3oovx5xyeszy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ09wIACgkQwfwUeK3K
7AklQAf9G9/q+Qqw4yd7jox1BrvwI0RjcpgJMKHE79/LQtK02nE8V3sr+pad5B3I
6qeKmKNObePIOk4MITFU2DUnoDm6NR8UnrtWzexyVjSWORXwU6Ob8pIHHvvL4SwQ
eF/QBoY8z4PDvnfuhmCZBa/nUQMIJy01xpof6JEiiyQhDK2bZ2CGbNDbJxXt/hgf
fXSVATtB3GIyZdpAaD1n4DjLXKqkCwMOc0GS7me8aO7EM/hb3Iwcbz/9CNG8QFV4
qwZ7qepjn9+F+CLhS3obZeqZM50y7MNzfKJkTXPTAaIQuag7SS+SXQtwba7SPxsW
IQBC2pe6WRrS0FdnR80cAPEQKuTuaw==
=x7wA
-----END PGP SIGNATURE-----

--znao3oovx5xyeszy--
