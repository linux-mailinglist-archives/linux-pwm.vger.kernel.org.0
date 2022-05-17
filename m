Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489152A8E1
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351323AbiEQRHQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351327AbiEQRHP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 13:07:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C7C17E07
        for <linux-pwm@vger.kernel.org>; Tue, 17 May 2022 10:07:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr0f1-0003rg-Tz; Tue, 17 May 2022 19:07:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr0f1-002uza-W4; Tue, 17 May 2022 19:07:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr0ez-00ALhe-Tm; Tue, 17 May 2022 19:07:01 +0200
Date:   Tue, 17 May 2022 19:06:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable attribute
Message-ID: <20220517170658.u3dpe6gglsihh6n6@pengutronix.de>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
 <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
 <355e6efa-dc65-771e-fcc0-2ca774d382de@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mu6bleripgysaocq"
Content-Disposition: inline
In-Reply-To: <355e6efa-dc65-771e-fcc0-2ca774d382de@roeck-us.net>
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


--mu6bleripgysaocq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Bartlomiej Zolnierkiewicz from Cc:]

On Tue, May 17, 2022 at 09:38:56AM -0700, Guenter Roeck wrote:
> On 5/17/22 07:26, Alexander Stein wrote:
> > This adds the enable attribute which is used to differentiate if PWM du=
ty
> > means to switch off regulator and PWM or to keep them enabled but
> > at inactive PWM output level.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >   Documentation/hwmon/pwm-fan.rst | 10 ++++
> >   drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++----
> >   2 files changed, 95 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/Documentation/hwmon/pwm-fan.rst b/Documentation/hwmon/pwm-=
fan.rst
> > index 82fe96742fee..0083480068d1 100644
> > --- a/Documentation/hwmon/pwm-fan.rst
> > +++ b/Documentation/hwmon/pwm-fan.rst
> > @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
> >   The fan rotation speed returned via the optional 'fan1_input' is extr=
apolated
> >   from the sampled interrupts from the tachometer signal within 1 secon=
d.
> > +
> > +The driver provides the following sensor accesses in sysfs:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +fan1_input	ro	fan tachometer speed in RPM
> > +pwm1_enable	rw	keep enable mode, defines behaviour when pwm1=3D0
> > +			0=3Dswitch off regulator and disable PWM
> > +			1=3Dkeep regulator enabled and set PWM to inactive level
>=20
> Unless I am missing something, I think we have (at least) three
> conditions to handle:
>=20
> - regulator disabled (independent of pwm value)
> - regulator enabled, pwm output disabled if pwm=3D0
> - regulator enabled, pwm output enabled and set to 0 (or, if inverted,
>   to maximum) if pwm=3D0

What is your expectation for a disabled PWM?=20
https://lore.kernel.org/linux-pwm/20220517150555.404363-1-u.kleine-koenig@p=
engutronix.de
might be relevant. If you assume that a pwm might output the active
level after disabling, the case "regulator enabled, pwm output disabled
if pwm=3D0" sounds wrong.

Would "pwm1_disable_on_zero" be a better name than "pwm1_enable"? The
latter is completely unintuitive to me.

Maybe go for

 0 -> keep pwm and regulator on
 1 -> disable pwm, keep regulator on
 2 -> keep pwm on, disable regulator
 3 -> disable pwm and regulator

(so one bit for pwm and one for regulator), even if 1 is
wrong/unusual/dangerous?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mu6bleripgysaocq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKD1jAACgkQwfwUeK3K
7AkSEwf8DqZ2xPAnWchPDvdj0BYGSkNw4EqaWLgHkTVn9p4CGNaNtoNVHYZiTMQu
mCp4NXOIHfHKTUorGelO/ng/Pmxl1LBVu0G7XCZKmHXz7ez3f/SIVe284d5swh1X
ETnikzkbFfDwjArZuJs3+/laPtvEkNeqr1BcSEjtnx0IZpG362mvRWOg/NZxIa8y
l8vgVEnJmtoJA/xzFfUfvh8psAdJwpz5LV5oWp4RqTkm5sh1eTFVaBPs9b5vZCr7
mX5MWZvp9vLc13T2fgiK9G+4Nqi7n2nKzfwD76iTFW8Cai1MHIZb24Ibr5Tsdsoc
yCGbrqdzeVXDs/fS82pVmkO7iRPxqg==
=W5Y1
-----END PGP SIGNATURE-----

--mu6bleripgysaocq--
