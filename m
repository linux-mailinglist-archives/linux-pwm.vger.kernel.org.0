Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416F42D7401
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 11:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbgLKKfn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 05:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388971AbgLKKfj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2020 05:35:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05963C0613CF
        for <linux-pwm@vger.kernel.org>; Fri, 11 Dec 2020 02:34:59 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knflI-00062R-6r; Fri, 11 Dec 2020 11:34:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knflH-0003Py-3Z; Fri, 11 Dec 2020 11:34:55 +0100
Date:   Fri, 11 Dec 2020 11:34:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <20201211103454.tqcfzy3ayn2gz7k4@pengutronix.de>
References: <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo>
 <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo>
 <20201210203926.ouzrq3ff5k6zhlvt@pengutronix.de>
 <X9Mu8zrJjFTe6fJq@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l2dlprvcn2mrcqzr"
Content-Disposition: inline
In-Reply-To: <X9Mu8zrJjFTe6fJq@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--l2dlprvcn2mrcqzr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Dec 11, 2020 at 09:33:55AM +0100, Thierry Reding wrote:
> On Thu, Dec 10, 2020 at 09:39:26PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Dec 10, 2020 at 06:10:45PM +0100, Thierry Reding wrote:
> > > Like I said, that's not what I was saying. I was merely saying that if
> > > there aren't any use-cases that current users rely on that would be
> > > broken by using this simpler implementation, then I'm okay with it, e=
ven
> > > if it's less flexible than a more complicated implementation. It shou=
ld
> > > be possible to determine what the current users are by inspecting dev=
ice
> > > trees present in the kernel. Anything outside the kernel isn't someth=
ing
> > > we need to consider, as usual.
> >=20
> > If "users in mainline" is the criteria that's a word.
>=20
> I didn't say "users in mainline", I said "use-cases". What I don't want
> to happen is for this change under discussion to break any existing use-
> cases of any existing users in the kernel. I said that we can determine
> what the existing users are by looking at which device trees use the
> compatible strings that the driver matches on.
>=20
> > So you agree we remove the following drivers?:
> >=20
> >  - pwm-hibvt.c
> >    Last driver specific change in Feb 2019, no mainline user
> >  - pwm-sprd.c
> >    Last driver specific change in Aug 2019, no mainline user
>=20
> No, that's an extrapolation of what I was saying above. Drivers with no
> apparent users are a separate topic, so don't conflate it with the issue
> at hand.

I cannot follow (and I think that's the problem between us and why those
conflicts happen between us). For me it's a logic consequence of
"Anything outside the kernel isn't something we need to consider, as
usual." that drivers that are untouched for some period and have no
mainline users can/should go away. (Is "extrapolation" as strong as
"implication", or has it subjective interpretation added? My dictionary
isn't accurate enough for that question.) But it seems there is
something with my logic or you not saying exactly what you actually
mean. (Did I miss any option? If yes it might be covered by a problem in
my logic.)

Having said that, even in the question at hand (i.e. what is the better
compromise for mapping the inter-channel hardware limitations to
software policy in the pac9685 driver) the idea "let's inspecting device
trees present in the kernel" doesn't work, because for this driver there
are none, too. (It might be used by a mainline machine via ACPI, but
this is even less possible to consider for our judgements than a device
tree with such a device and no user but the sysfs PWM interface.)

> While it's certainly unfortunate that these don't seem to be used, I see
> no reason why we should remove them. They don't create much of a
> maintenance burden, so I'm fine with keeping them in the hopes that
> users may still show up at some point.

The problem I have with them is that I expect your voice of dissent when
I find the time to improve the rounding behaviour of these drivers.
My ultimate goal is to make the PWM framework a system where consumers
can rely on a consistent behaviour of the API and a way to actually
order what they need and get it. I'm not entirely sure we agree that
we're not there yet.

> > Most PWMs are added to cpu.dtsi files with status =3D "disabled", I won=
der
> > if it makes sense to check the machine.dts files if some of the PMWs are
> > completely unused. Do you consider status =3D "okay" a use that we have=
 to
> > retain even if the node has no phandle?
>=20
> A PWM controller may be in use via sysfs even if it has no phandle.

Yeah, I expected you will say that. (And I agree.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l2dlprvcn2mrcqzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/TS0sACgkQwfwUeK3K
7Ali8gf/Tnv62+6avDdh/1OSBXb4uU6N4giVgTORDd5Ueamuznw5f9JlyaVOqjee
yelQRPkK58KF1KTurfD6uAcBfwbfZs+VCFnCP3PAbJP/w4ZqfBdIbmHKSnkqEYB0
6hMzlGS9bKNppHWUHzjx05+SyJ+VmF1IP6vUsXYfpHj5QCj8kiTGv2yeZ6MgbFfl
n3Qj47+CimLMUYutrDtUKVk8tJIKfn1Trb21V0uu3ozIE9xU7e1tOVDYw5u/Sii0
a/CbP7c5X4Ll9kBvrqFh9b4il7YUac7Ui5QuaZbuPuWV+AtZ4xVj8XksT0/H/6mO
5Fj2SnWWzPdOmD+7SZqJXrcMXe3PCQ==
=LgIB
-----END PGP SIGNATURE-----

--l2dlprvcn2mrcqzr--
