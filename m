Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D292D55FD
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 10:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLJJCJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 04:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLJJCI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 04:02:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5AC0613CF
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 01:01:27 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knHpF-0000qm-E3; Thu, 10 Dec 2020 10:01:25 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knHpE-00078H-D5; Thu, 10 Dec 2020 10:01:24 +0100
Date:   Thu, 10 Dec 2020 10:01:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jvnay2irizxwzhrs"
Content-Disposition: inline
In-Reply-To: <X9EDGHySNYb7CxcW@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jvnay2irizxwzhrs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Dec 09, 2020 at 06:02:16PM +0100, Thierry Reding wrote:
> On Tue, Dec 08, 2020 at 07:26:37PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Thierry, hello Sven,
> >=20
> > On Tue, Dec 08, 2020 at 05:57:12PM +0100, Thierry Reding wrote:
> > > On Tue, Dec 08, 2020 at 09:44:42AM -0500, Sven Van Asbroeck wrote:
> > > > Which brings us to an even trickier question: what happens if a pwm=
 output
> > > > is set to 0% or 100% duty cycle? In that case, it'll behave like a =
gpio output.
> > > > So when it's enabled, it does not use the prescaler.
> > > > But! what happens if we now set that output to a different duty cyc=
le?
> > > >=20
> > > > Example:
> > > > 1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  perio=
d=3D1/200Hz)
> > > > 2. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, perio=
d=3D1/400Hz)
> > > >   fail? no, because it's not actually using the period (it's full o=
n)
> > > > 3. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, perio=
d=3D1/200Hz)
> > > >   fail? no, because it's not actually using the period (it's full o=
n)
> > > > 4. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  perio=
d=3D1/400Hz)
> > > >   fail? no, because only output 1 is using the prescaler
> > > > 5. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=
=3D1/400Hz)
> > > >   fail? no, because output 2 is not changing the prescaler
> > > > 6. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=
=3D1/200Hz)
> > > >   fail? yes, because output 2 is changing prescaler and it's alread=
y in use
> > > >=20
> > > > IMHO all this can get very complicated and tricky.
> > >=20
> > > Is this really that complicated?
> >=20
> > I think it is.
>=20
> Care to specify what exactly is complicated about it? You're just saying
> that you don't like the restrictions that this implements, but there's
> really nothing we can do about that because the hardware just doesn't
> give you that flexibility.

The complicated thing is to chose how to map the hardware imposed
limitations to the consumers of the two (or more?) channels. And the
problem is there is no golden way that is objectively better than all
others.

> > > I sounds to me like the only thing that you need is to have some sort
> > > of usage count for the prescaler. Whenever you want to use the
> > > prescaler you check that usage count. If it is zero, then you can just
> > > set it to whatever you need. If it isn't zero, that means somebody
> > > else is already using it and you can't change it, which means you have
> > > to check if you're trying to request the value that's already set. If
> > > so, you can succeed, but otherwise you'll have to fail.
> >=20
> > With this abstraction Sven's questions are changed to:
> >=20
> > Does a PWM that runs at 0% or 100% use the prescaler?
> >=20
> > If yes, you limit the possibilities of the brother channels. And if not,
> > it will not be possible to go to a 50% relative duty cycle while
> > retaining the period. Both sounds not optimal.
>=20
> Again, this is a restriction imposed by the hardware design and there's
> nothing in software that we can do about that. The only thing I proposed
> was a simple way to detect the circumstances and make sure we can deal
> with it.

The point I want to make is, that with the usage counter you suggested
you just shifted the problem and didn't solve it. I agree we need a
usage counter, but you still have to think about how you want to answer
the original questions by Sven. Depending on that you have to
consider a channel running at 0% or 100% a user, or not.  (Or the other
way round: You select a policy if you consider 0% and 100% a use and
implicitly answer the questions with it.)

> And that's obviously subject to the kind of policy we want to implement.
> I don't think it's necessarily a bad thing to give people the most
> flexibility. If they know that one PWM channel is only ever going to be
> full-on/full-off, then they can still use that other channel in whatever
> way they want. If, on the other hand, we assume that the prescaler is
> always going to be used we limit the flexibility even if we don't
> necessarily have to.

I think we agree here, just with different words. The only thing I doubt
is: You wrote: "If they know $X, then they can still use that other
channel in whatever way they want." Who is "they"? How can they know
that $X is valid for someone else, or anyone else? Or is it enough that
"they" know this about their own use? Now Clemens wants to improve the
driver, does he need to consider "them" in the mainline driver
implementation? If Clemens chooses one way or the other, will there be
someone who then will produce a use case contradicting the implemented
policy? How will you (or who will then) decide which use-case is more
important?

> Obviously if you want to use both channels at partial duty-cycles there
> isn't much you can do and you really have to make sure they both run at
> the same frequency/period. But that's usually something that you can
> deal with by just choosing a period that works for both.
>
> And if that's not possible, well, then you better just use a different
> PWM controller to begin with, because you just can't make it work.

Yes.

> > > > We can of course make this much simpler by assumung that gpio or on=
/off pwms
> > > > are actually using the prescaler. But then we'd be limiting this ch=
ip's
> > > > functionality.
> > >=20
> > > Yeah, this is obviously much simpler, but the cost is a bit high, in =
my
> > > opinion. I'm fine with this alternative if there aren't any use-cases
> > > where multiple outputs are actually used.
> >=20
> > This metric is wishy-washy; of course you can construct a use-case. I'd
> > still go for this simpler option and assume the prescaler used if the
> > PWM runs at 0% or 100%, but not when it is a GPIO.
>=20
> I don't understand what you're saying here. On one hand you seem to
> object to what I was saying, but then you agree with it?
>=20
> And I'm not asking anyone to make up any artificial use-case. What I'm
> saying is that if there aren't any existing use-cases that would break
> if we assume a pre-scaler is used for full-on/full-off, then I'm okay
> with making that assumption and simplifying the driver. If there were
> use-cases, then that assumption would break existing users and that's
> not something I'm willing to accept.
>=20
> Anything wrong with that metric in your opinion?

The part I called wishy-washy is: "[....] if there aren't any use-cases
where [...]". Who should decide what are (relevant) use-cases? We
already agreed above that we talk about a hardware that doesn't allow us
to consider it consisting of 2 independent channels and so we somehow
have to limit their capabilities exposed by the PWM API. And whatever
compromise we make, it's not hard to find a more or less realistic use
case where the compromise hurts. So my interpretation of your words are:
"I'm fine with this alternative if $somethingimpossible" which is not
helpful.

So yes, there is something wrong with your metric because it's IMHO
impossible for a driver author to actually use it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jvnay2irizxwzhrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/R4+EACgkQwfwUeK3K
7An6XQf/Q6W4v75Dba37mA2OYGJRHkRZOawo1huxfYDShUbciDr5+6vcOgaFUgUs
HJ1TSkAVmgxpGKGwlgTMghrY8AlQ7d9HS79HNbZhhY7YtUtCHW6zWHfcGitGhaUO
80HjcF6v6I0YU7OFoSBXxP5DEatYWC3XzcPxk2r0hNKVlFpHHjdUQ3+UetUHtg86
WzM+vKS7lSSK6ZMcyB+u8IvoEuGenZce1s+z82Wtjf4EE7zz0PEC/a0RPKQWeE55
NXMztsglbULv2TdmFaZ2gl25XSTtq7o3xu7l8h3HRcLjuW/ayqaNZIaMFpxVKC/R
1FQR4q01cOt0AB9Mx3B3WmMj79TFHA==
=oaKN
-----END PGP SIGNATURE-----

--jvnay2irizxwzhrs--
