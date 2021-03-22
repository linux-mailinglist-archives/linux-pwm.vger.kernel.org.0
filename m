Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70B73445AA
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 14:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCVNZl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhCVNZL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 09:25:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B1C061756
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 06:25:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOKYN-0005Br-Co; Mon, 22 Mar 2021 14:25:07 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOKYM-0002kG-Uw; Mon, 22 Mar 2021 14:25:06 +0100
Date:   Mon, 22 Mar 2021 14:25:06 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210322132506.evsvoem4lk2nx6w7@pengutronix.de>
References: <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
 <YFhhGpiHDELxIo9V@orome.fritz.box>
 <CAHp75Ve2FFEMsAv8S18bUDFsH2UkiQ5UvgcRtZ=j30syQtEirw@mail.gmail.com>
 <20210322112254.5mjkajkq3wnhgnd5@pengutronix.de>
 <CAHp75VfedZyFF46koLOg13t_TzMbwj5zBYU2zBA52vRRtb202g@mail.gmail.com>
 <20210322114826.ahwhbqxjxfg3nmrf@pengutronix.de>
 <CAHp75Vc6YnHJdt0HhV9AZtpLHLapHZb08O5ygg++PX+u04m--A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ff2acv277zzzeci"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc6YnHJdt0HhV9AZtpLHLapHZb08O5ygg++PX+u04m--A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3ff2acv277zzzeci
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 22, 2021 at 02:15:08PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 22, 2021 at 1:48 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 22, 2021 at 01:40:57PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 22, 2021 at 1:22 PM Uwe Kleine-K=F6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > When the PWM driver is loaded and the PWM configuration is invalid,=
 it
> > > > was already invalid for the time between power up (or warm start) a=
nd
> > > > PWM driver load time. Then it doesn't really hurt to keep the PWM
> > > > in this invalid state for a little moment longer until the consumer=
 of
> > > > the PWM becomes active.
> > >
> > > But this won't work in the cases when we have a chip with a shared
> > > settings for period and/or duty cycle. You will never have a user come
> > > due to -EBUSY.
> >
> > That's wrong, the first consumer to enable the PWM (in software) is
> > supposed to be able to change the settings.
>=20
> If it's a critical PWM, how can you be allowed to do that?

You seem to have a tight concept of a critical PWM. I don't, so I have
problems following you. What is your picture about what is to be
allowed/denied for a critical PWM?

> And if so, what is the difference between resetting the device in this
> case?

The difference is that we have a consumer that knows what to do with the
PWM then.

> You may consider it as a change to the settings by the first
> consumer.

=2E. but without knowing if the first consumer is a backlight driver or a
motor control it's hard to know if disabling the PWM is OK. So I like
the concept of not doing anything until a process comes along that knows
better.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3ff2acv277zzzeci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYmq8ACgkQwfwUeK3K
7AnxVwf9G6ddwK5P11tM3MvmQpjvCxy755jpKSmb8bJT3NMpjH0ZsQ7cJb5whjVb
kvzpH+cvusvvWrpCYIB5/TJYn7oEbGT5HOndqemVivN2HDmBLxuviOY0YnsoeZkf
SBgow32iipiiv912uW49WCUAoMrcxC0IIv7509P9fLQ4bH7+KC5a8FLl2dYl9pm6
YgaeNgnEwwq/vcMOu+UzVAREq0ffVP/4kHiVRWezRRogwTPKy+0gK7C2Z8JTxt64
JfF7EnamA36aoIakgqbnOmlrbp5a/tGAAt7bd0pNv/0aMOLsx7p1GlqD8fRUvcWk
jyBA4prnQRdN5ZbasJfyKNxlCZLnYA==
=fMXA
-----END PGP SIGNATURE-----

--3ff2acv277zzzeci--
