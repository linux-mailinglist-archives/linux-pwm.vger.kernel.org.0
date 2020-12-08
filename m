Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36F72D3224
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbgLHS1X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 13:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730912AbgLHS1W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 13:27:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F85CC061749
        for <linux-pwm@vger.kernel.org>; Tue,  8 Dec 2020 10:26:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmhh9-0000oz-2G; Tue, 08 Dec 2020 19:26:39 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmhh7-0002tc-W8; Tue, 08 Dec 2020 19:26:37 +0100
Date:   Tue, 8 Dec 2020 19:26:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="avonyzkanb7ojyc5"
Content-Disposition: inline
In-Reply-To: <X8+waLH58pOaMI06@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--avonyzkanb7ojyc5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry, hello Sven,

On Tue, Dec 08, 2020 at 05:57:12PM +0100, Thierry Reding wrote:
> On Tue, Dec 08, 2020 at 09:44:42AM -0500, Sven Van Asbroeck wrote:
> > On Tue, Dec 8, 2020 at 4:10 AM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > If this is already in the old code, this probably warrants a separate
> > > fix, and yes, I consider this a severe bug. (Consider one channel
> > > driving a motor and reconfiguring an LED modifies the motor's speed.)
> > >
> >=20
> > I think you are 100% correct, this would be a severe bug. I have only u=
sed
> > this chip to drive LEDs, where the actual period is not that important.=
 But
> > for motor control, it's a different story.
> >=20
> > Basically you are suggesting: the period (prescaler) can only be change=
d iff
> > its use-count is 1.
> >=20
> > This however brings up a whole load of additional questions: consider t=
he case
> > where the chip outputs are also used in gpio mode. the gpio functionali=
ty
> > only sets "full on" and "full off" bits. On a scope, a gpio output will=
 look
> > identical, no matter the value of the period. So when a gpio output is =
in use,
> > does it increment the prescaler use-count ?
> >=20
> > Example:
> > 1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1=
/200Hz)
> > 2. output 2: set led mode (full-on bit set)
> > 3. output 1: change period(enabled=3Dtrue, duty_cycle=3D50%, period=3D1=
/100Hz)
> >=20
> > Do we have to make (3) fail? I would say no: although output 2 is in us=
e,
> > it's not actually using the prescaler. Changing prescale won't modify
> > output 2 in any way.
> >=20
> > Which brings us to an even trickier question: what happens if a pwm out=
put
> > is set to 0% or 100% duty cycle? In that case, it'll behave like a gpio=
 output.
> > So when it's enabled, it does not use the prescaler.
> > But! what happens if we now set that output to a different duty cycle?
> >=20
> > Example:
> > 1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  period=3D=
1/200Hz)
> > 2. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, period=3D=
1/400Hz)
> >   fail? no, because it's not actually using the period (it's full on)
> > 3. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, period=3D=
1/200Hz)
> >   fail? no, because it's not actually using the period (it's full on)
> > 4. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  period=3D=
1/400Hz)
> >   fail? no, because only output 1 is using the prescaler
> > 5. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1=
/400Hz)
> >   fail? no, because output 2 is not changing the prescaler
> > 6. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1=
/200Hz)
> >   fail? yes, because output 2 is changing prescaler and it's already in=
 use
> >=20
> > IMHO all this can get very complicated and tricky.
>=20
> Is this really that complicated?

I think it is.

> I sounds to me like the only thing that you need is to have some sort
> of usage count for the prescaler. Whenever you want to use the
> prescaler you check that usage count. If it is zero, then you can just
> set it to whatever you need. If it isn't zero, that means somebody
> else is already using it and you can't change it, which means you have
> to check if you're trying to request the value that's already set. If
> so, you can succeed, but otherwise you'll have to fail.

With this abstraction Sven's questions are changed to:

Does a PWM that runs at 0% or 100% use the prescaler?

If yes, you limit the possibilities of the brother channels. And if not,
it will not be possible to go to a 50% relative duty cycle while
retaining the period. Both sounds not optimal.
=20
> > We can of course make this much simpler by assumung that gpio or on/off=
 pwms
> > are actually using the prescaler. But then we'd be limiting this chip's
> > functionality.
>=20
> Yeah, this is obviously much simpler, but the cost is a bit high, in my
> opinion. I'm fine with this alternative if there aren't any use-cases
> where multiple outputs are actually used.

This metric is wishy-washy; of course you can construct a use-case. I'd
still go for this simpler option and assume the prescaler used if the
PWM runs at 0% or 100%, but not when it is a GPIO.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--avonyzkanb7ojyc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/PxVoACgkQwfwUeK3K
7Am/cwf/ZSCm6bpnxNagx6aLIeuhlIam8ei+OU14kq7TF8mpq5RmWirhUyA5om5M
DUhc/rkOTqeH0sFadCvYOxGhDvtzgFGuxjTWInYhFBnZR9wlMdU4wPKDVxg8UM0r
zAs2UaVGyr/mKqPgrKNEpkwyVxfIeZ/cWzR1l5OtZHrQgekXcJVUVWk8EbdL/n47
4JU5qM1kSXRQz/8LS9MLQF1bn0X2cUW0Yz7MZJsb4cOLoTiIUqWc+DLZjz1gY+U1
/BtVbXazHIssAkMxmUcmXrhMmFWIHc2kn6oSmRzACC/M1tcgGaFd3UoiQewLS2fI
mVqHCdU8JjCGFtJ35uV/oZAzlaOmuQ==
=MBaP
-----END PGP SIGNATURE-----

--avonyzkanb7ojyc5--
