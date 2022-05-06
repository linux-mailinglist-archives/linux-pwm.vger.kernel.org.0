Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C051D346
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbiEFIZl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390166AbiEFIY1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 04:24:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF06831C
        for <linux-pwm@vger.kernel.org>; Fri,  6 May 2022 01:20:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmtC4-0005eK-6q; Fri, 06 May 2022 10:20:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmtBz-000fcd-Pj; Fri, 06 May 2022 10:20:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmtBx-007uuY-MQ; Fri, 06 May 2022 10:20:01 +0200
Date:   Fri, 6 May 2022 10:20:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan: dynamically switch
 regulator
Message-ID: <20220506082001.hybxzaic5wza7irh@pengutronix.de>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
 <20220505220037.GF1988936@roeck-us.net>
 <2112012.Mh6RI2rZIc@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xj45peqflexojgp"
Content-Disposition: inline
In-Reply-To: <2112012.Mh6RI2rZIc@steina-w>
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


--4xj45peqflexojgp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, May 06, 2022 at 09:15:55AM +0200, Alexander Stein wrote:
> Am Freitag, 6. Mai 2022, 00:00:37 CEST schrieb Guenter Roeck:
> > On Wed, May 04, 2022 at 02:45:51PM +0200, Alexander Stein wrote:
> > > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > >=20
> > > A pwm value equal to zero is meant to switch off the pwm
> > > hence also switching off the fan. Currently the optional
> > > regulator is always on. When using this driver on boards
> > > with an inverted pwm signal polarity this can cause running
> > > the fan at maximum speed when setting pwm to zero.
> >=20
> > The appropriate solution in this case would be to tell the
> > software that the pwm is inverted. Turning off the regulator
> > in that situation is a bad idea since setting the pwm value to
> > 1 would set it to almost full speed. That does not really make
> > sense.
>=20
> The pwm-fan driver is already configured for inverted PWM (ommited some=
=20
> properties for shortness):
> fan0: pwm-fan {
> 	compatible =3D "pwm-fan";
> 	fan-supply =3D <&reg_pwm_fan>;
> 	pwms =3D <&pwm3 0 40000 PWM_POLARITY_INVERTED>;
> 	cooling-levels =3D <0 32 64 128 196 240>;
> [...]
> };
>=20
> The problem here is that the pwm-fan driver currently enables the regulat=
or=20
> unconditionally, but the PWM only when the fan is enabled, refer to=20
> __set_pwm(). This results in a fan at full speed when pwm-fan is idle, as=
 pwm=20
> state is not enabled.

Which PWM driver are you using?

There is an implicit assumption in some PWM consumers that a disabled
PWM emits the inactive level. However not all PWMs do this. Is this such
a case?=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4xj45peqflexojgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ02iwACgkQwfwUeK3K
7AnEdAf/bh4peqXpFzNxl2/EmIGsDvNR9EkQKDaJk992crSC/J9TJXT92F2AR9cz
CRIhhuxUNGefIci4jCswFSmua8GgWcIWZF4sVKuvCGBLYwKt748ODwnijo77Ty2M
jyah4etonSqJ3/z6kFZdbjF6R+MZaoLfe3/vBwLf51wQHSXb6uRPOiMMAaM0GZNo
kTvsJJ/QejqiJyVlqEm/Ch/7OJj4b+cJiKUBTWLN93wU4xA34XX72NIV6jH27d5/
V9Pzaogl7Jcs/zHL+CftdwHS20oYnzsAiidUR7tfeOIqHcd5Lmd55b8Po7UycCNh
ql1XlVrX9bp3NPDb8ugqcgOj6TLk5w==
=5YXv
-----END PGP SIGNATURE-----

--4xj45peqflexojgp--
