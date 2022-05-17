Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2352A8B3
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351270AbiEQQ5o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241919AbiEQQ5n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 12:57:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED14F9F6
        for <linux-pwm@vger.kernel.org>; Tue, 17 May 2022 09:57:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr0Vn-00033S-OV; Tue, 17 May 2022 18:57:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr0Vn-002uaB-Kk; Tue, 17 May 2022 18:57:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr0Vl-00ALgK-Jq; Tue, 17 May 2022 18:57:29 +0200
Date:   Tue, 17 May 2022 18:57:26 +0200
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
Message-ID: <20220517165726.trxa7lpz6kluvrg3@pengutronix.de>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
 <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
 <20220517145331.7ffab4pyjwrh5lkg@pengutronix.de>
 <194f33ea-18fa-4cb3-56b4-5d423463fa82@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rnxr75prxwl3d74k"
Content-Disposition: inline
In-Reply-To: <194f33ea-18fa-4cb3-56b4-5d423463fa82@roeck-us.net>
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


--rnxr75prxwl3d74k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropping Bartlomiej Zolnierkiewicz from Cc as the address bounces]

On Tue, May 17, 2022 at 09:32:24AM -0700, Guenter Roeck wrote:
> On 5/17/22 07:53, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Tue, May 17, 2022 at 04:26:20PM +0200, Alexander Stein wrote:
> > > This adds the enable attribute which is used to differentiate if PWM =
duty
> > > means to switch off regulator and PWM or to keep them enabled but
> > > at inactive PWM output level.
> > >=20
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >   Documentation/hwmon/pwm-fan.rst | 10 ++++
> > >   drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++-=
---
> > >   2 files changed, 95 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/Documentation/hwmon/pwm-fan.rst b/Documentation/hwmon/pw=
m-fan.rst
> > > index 82fe96742fee..0083480068d1 100644
> > > --- a/Documentation/hwmon/pwm-fan.rst
> > > +++ b/Documentation/hwmon/pwm-fan.rst
> > > @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
> > >   The fan rotation speed returned via the optional 'fan1_input' is ex=
trapolated
> > >   from the sampled interrupts from the tachometer signal within 1 sec=
ond.
> > > +
> > > +The driver provides the following sensor accesses in sysfs:
> > > +
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > +fan1_input	ro	fan tachometer speed in RPM
> > > +pwm1_enable	rw	keep enable mode, defines behaviour when pwm1=3D0
> > > +			0=3Dswitch off regulator and disable PWM
> > > +			1=3Dkeep regulator enabled and set PWM to inactive level
> >=20
> > Is the pwm1_enable supposed to be set to 0 if that only does the right
> > thing if the PWM emits low after pwm_disable()? The question I raised in
> > v2 about "what is the meaning of disable?" hasn't evolved, has it?
> >=20
> > I still think it's unfortunate, that "pwm1_enable" has an effect on the
> > regulator.
> >=20
>=20
> Trying to understand. Are you saying that you are ok with affecting the
> regulator when setting pwm :=3D 0 (even though that doesn't really mean
> "disable pwm output"), but not with making the behavior explicit by
> using pwm1_enable ?

Not sure about being ok with affecting the regulator when setting
pwm :=3D 0. I don't know enough about pwm-fans to have a strong opinion
for that.

Some questions to refine the semantics and my opinion:

There are fans without a regulator? (I think: yes)

A fan with a regulator always stops if the regulator is off?
(Hmm, there might be problems with shared regulators that only go off
when all consumers are off? What about always-on regulators, these don't
go off on the last consumer calling disable, right?)

Having said that I think the sane behaviour is:

The intention of pwm :=3D 0 is to stop the fan. So disabling the regulator
(if available) sounds right.

I'm unsure what to reasonably expect from a disabled PWM. I think "stops
to oscillate" can be assumed. So I'd say: If a fan continues to rotate
when the PWM input is constantly active, don't call pwm_disable().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rnxr75prxwl3d74k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKD0/MACgkQwfwUeK3K
7AmSqAgAjxHzLry1LXcFyUBa+fBZ+n2gG6qWKODoa2r3dPnLWiiV0MR33pF+51Pv
ZZ82uOlUU/kFqo4muwHrVbLZqtfR9gzHuOX7P5tUoU3OxENXJbR/gv1t9nhBhKc/
bfVb3anxALEeVgqoOMEyTKXkMyK7HkYro8Bji86YghVdsybHkAf8FCg0i1QNkuxP
+RlD+4FNM08VaET5hCsHzOZbWOCqIG49ncrrEjcoZ/kSOenOGffEh+vpR/8CwEfa
NK/pxro2+b1SILEEgN7WDBlszO+Cg4hBJ6NxVrbvaUzBnbHnei6LrTvfBtNAUVDi
lnEpCLu+CSGhm6KF6uGcsaMlK7TbsA==
=DZHc
-----END PGP SIGNATURE-----

--rnxr75prxwl3d74k--
