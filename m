Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5151DA84
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442192AbiEFOdJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442195AbiEFOdI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 10:33:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DFE69294
        for <linux-pwm@vger.kernel.org>; Fri,  6 May 2022 07:29:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmyxI-0001fA-UR; Fri, 06 May 2022 16:29:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmyxI-000iwz-AM; Fri, 06 May 2022 16:29:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmyxG-007yDK-08; Fri, 06 May 2022 16:29:14 +0200
Date:   Fri, 6 May 2022 16:29:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan:
 dynamically switch regulator
Message-ID: <20220506142913.vbddyvkmhuvfd5o5@pengutronix.de>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
 <2371611.jE0xQCEvom@steina-w>
 <20220506102301.my2tsn7kfldwqtll@pengutronix.de>
 <3417990.V25eIC5XRa@steina-w>
 <20220506141244.GA2990519@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bdrve5lys2yuerjf"
Content-Disposition: inline
In-Reply-To: <20220506141244.GA2990519@roeck-us.net>
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


--bdrve5lys2yuerjf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Dropped Bartlomiej Zolnierkiewicz from Cc:; my mailer daemon claims the
email address doens't exist.]

Hello Guenter,

On Fri, May 06, 2022 at 07:12:44AM -0700, Guenter Roeck wrote:
> On Fri, May 06, 2022 at 02:23:11PM +0200, Alexander Stein wrote:
> > Am Freitag, 6. Mai 2022, 12:23:01 CEST schrieb Uwe Kleine-K=F6nig:
> > > See
> > > https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf43@pen=
gutronix.de/
> > > for one of the previous discussions.
> >=20
> > Thanks for the link. I took a look into it. I'm on your side here, IMHO=
=20
> > pwm_disable() implies that the PWM perphery is disabled, including any =
clocks=20
> > or powerdomain. This is what pwm-imx27 actually does. This might lead t=
o a,=20
> > probably platform dependent, (undefined?) state of the PWM output pin.
> > This implies it is not possible to disable the PWM periphery for invert=
ed=20
> > signals, if the disabled state is not the inactive level. You know all =
about=20
> > it already.
> > Then again from pwm-fan side I want be able to disable the FAN, turning=
 of=20
> > regulator and PWM, so powersaving is possible. That's what this patch i=
s=20
> > about. This is similar also what pwm_bl is doing.
> > Independent of the exact semantics, it makes sense to disable the regul=
ator in=20
> > pwm-fan as well when the fan shall be disabled.
>=20
> There are fans which never stop if pwm=3D=3D0, such as some CPU fans. I d=
on't

I assume with pwm=3D=3D0 you actually mean duty_cycle =3D=3D 0?

> think it is a good idea to force those off by turning off their power. The
> problem in the driver is that it treats pwm=3D=3D0 as "disable pwm", not =
as
> "set pwm output to 0", Part of the probem may be that the ABI doesn't have
> a good representation for "disable pwm output", which is what is really
> wanted/needed here.

Disable pwm output =3D=3D set pwm output to High-Z? Not all PWMs are able to
provide that.

> I think the best solution would be to implement and
> use pwmX_enable, and define in the driver documentation that pwm1_enable=
=3D0
> reflects "disable pwm" and pwm1_enable=3D1 reflects "emable manual pwm
> control:. At the same time, stop associating "pwm=3D=3D0" with "disable p=
wm",
> but just set the pwm output value to 0.

Are you talking about the PWM framework here, or only the pwm-fan
driver?

I'd expect there are better names than pwm1_enable for the intended
semantic.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bdrve5lys2yuerjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ1MLYACgkQwfwUeK3K
7AmmSAf9FO45ivkd1xLRkZ6c38qMHZSGYObdEmaViG11zaoDBirjlpg9SJFTiwaF
ivXPjIyJmK+3gahY58iIJH+eIkNISGfKK8HXm2baaOMJsnvCjxeG/VIACduyoavf
FrNR4sVASqQjL8wj/aTX7ugKx/XHz62KNc1Kb6rErggf7mAWY4yeGMD2Y3O/W+cj
AuXf7mThKsGlo6AE4VHK0dvpingu1St6v3hSzcXbHMdepGGUgcg9uEeJ7SG313nw
WIiMWHnB25hGE0w5Sfywj5ry5FJxLyl+nkpQVP11aiuepYPbQdlfwidYVCtVCUL/
Gf1/Nnqf1oz4+ZgiK0zfM98wBZC+jg==
=igYo
-----END PGP SIGNATURE-----

--bdrve5lys2yuerjf--
