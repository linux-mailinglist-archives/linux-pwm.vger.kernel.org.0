Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7960410FDE
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Sep 2021 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhITHQH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbhITHQG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 03:16:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C13C061574
        for <linux-pwm@vger.kernel.org>; Mon, 20 Sep 2021 00:14:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mSDVb-00026U-OY; Mon, 20 Sep 2021 09:14:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mSDVY-000630-AX; Mon, 20 Sep 2021 09:14:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mSDVY-00039R-9L; Mon, 20 Sep 2021 09:14:32 +0200
Date:   Mon, 20 Sep 2021 09:14:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com,
        Dipen Patel <dipenp@nvidia.com>
Subject: Re: [RFC PATCH v1 07/20] gpio: Add output event generation method to
 GPIOLIB and PMC Driver
Message-ID: <20210920071432.cxjjlsjsfo4n2vgg@pengutronix.de>
References: <20210824164801.28896-1-lakshmi.sowjanya.d@intel.com>
 <20210824164801.28896-8-lakshmi.sowjanya.d@intel.com>
 <CACRpkdYJkPgaz-BvQ1X0PHRCCbn0hrMDabouDwHkn+pr9d-dSQ@mail.gmail.com>
 <20210917072755.d4ynxkp4scxrk6rq@pengutronix.de>
 <CACRpkdZmjWQ_mNw_JOZnkvvU15qS26gB3GL_9k=Vao3m=w_N9w@mail.gmail.com>
 <YUep0gtZkc6D3ukt@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaedf33eqad6fiyv"
Content-Disposition: inline
In-Reply-To: <YUep0gtZkc6D3ukt@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xaedf33eqad6fiyv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 11:21:22PM +0200, Clemens Gruber wrote:
> On Sun, Sep 19, 2021 at 09:38:58PM +0200, Linus Walleij wrote:
> > On Fri, Sep 17, 2021 at 9:27 AM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Thu, Sep 16, 2021 at 11:42:04PM +0200, Linus Walleij wrote:
> > > > On Tue, Aug 24, 2021 at 6:48 PM <lakshmi.sowjanya.d@intel.com> wrot=
e:
> > > >
> > > > > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > > > >
> > > > > Intel Timed I/O hardware supports output scheduled in hardware. E=
nable
> > > > > this functionality using GPIOlib
> > > > >
> > > > > Adds GPIOlib generate_output() hook into the driver. The driver is
> > > > > supplied with a timestamp in terms of realtime system clock (the =
same
> > > > > used for input timestamping). The driver must know how to transla=
te this
> > > > > into a timebase meaningful for the hardware.
> > > > >
> > > > > Adds userspace write() interface. Output can be selected using th=
e line
> > > > > event create ioctl. The write() interface takes a single timestamp
> > > > > event request parameter. An output edge rising or falling is gene=
rated
> > > > > for each event request.
> > > > >
> > > > > The user application supplies a trigger time in terms of the real=
time
> > > > > clock the driver converts this into the corresponding ART clock v=
alue
> > > > > that is used to 'arm' the output.
> > > > >
> > > > > Work around device quirk that doesn't allow the output to be expl=
icitly
> > > > > set. Instead, count the output edges and insert an additional edg=
e as
> > > > > needed to reset the output to zero.
> > > > >
> > > > > Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
> > > > > Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> > > > > Signed-off-by: Tamal Saha <tamal.saha@intel.com>
> > > > > Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > > > > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > > >
> > > > So this is some street organ machine that generates sequences
> > > > with determined timing between positive and negative edges
> > > > right?
> > > >
> > > > I can't see how this hardware is different from a PWM, or well
> > > > I do to some extent, you can control the period of several
> > > > subsequent waves, but that is really just an elaborate version
> > > > of PWM in my book.
> > >
> > > From looking in the patch I think this is more versatile than the PWM
> > > framework abstracts. I wonder if there is a usecase for the
> > > functionality that cannot be expressed using pwm_apply_state?!
> > >
> > > I remember we had approaches before that implemented repeating patter=
ns
> > > (something like: active for 5ms, inactive for 10 ms, active for 30 ms,
> > > inactive for 10 ms, repeat) and limiting the number of periods
> > > (something like: .duty_cycle =3D 5ms, .period =3D 20ms, after 5 perio=
ds go
> > > into inactive state). These were considered to be too special to be
> > > abstracted in drivers/pwm.
> > >
> > > > It seems to me that this part of the functionality belongs in the
> > > > PWM subsystem which already has interfaces for similar
> > > > things, and you should probably extend PWM to handle
> > > > random waveforms rather than trying to shoehorn this
> > > > into the GPIO subsystem.
> > >
> > > I agree that GPIO is a worse candidate than PWM to abstract that. But
> > > I'm not convinced (yet?) that it's a good idea to extend PWM
> > > accordingly.
> >=20
> > Yeah it is a bit unfortunate.
> >=20
> > I think we need to fully understand the intended usecase before
> > we can deal with this: exactly what was this hardware constructed
> > to handle? Sound? Robotic stepper motors? It must be something
> > and apparently there are users.
> >=20
> > Maybe even a new subsystem is needed, like a
> > drivers/gpio-patterns or drivers/stepper-motor or whatever this
> > is supposed to drive.
>=20
> This would be interesting. Maybe even more abstract, not just supporting
> GPIO patterns but also PWM patterns.
>=20
> E.g. Set gpiochip1 line 2 to 1, wait 5ms, set it to 0
> Or set pwmchip1 pwm 2 to 100%, wait 250ms, set it back to 50% duty cycle

Note that adding support to drive PWMs in this "GPIO command sequence"
framework would not increase its expressiveness assuming this framework
has loop support. That's because the sequence "set pwmchip1 pwm 2 to
100% (with a period of X), wait 250ms, set it back to 50% duty cycle
with a period of Y" can be expressed using a GPIO as:

	set GPIO to active
	wait 250 ms + Y/2
	while True:
	    toggle GPIO
	    wait Y/2

That's because this framework could provide a PWM from a GPIO.

(Also note that the original command sequence has some problems. That's
because (depending on the PWM in use and X) doing

	pwm_apply_state(mypwm, &(struct pwm_state){ .period =3D X, .duty_cycle =3D=
 X, .enabled =3D 1 });

and then 250ms later

	pwm_apply_state(mypwm, &(struct pwm_state){ .period =3D Y, .duty_cycle =3D=
 Y / 2, .enabled =3D 1 });

might give you an initially active phase that is considerably longer
than 250 ms + Y/2 because the PWM cannot implement .period =3D X exactly
and completes the period that is currently running at time 250 ms.

> This subsystem could then implement the patterns with hrtimers and be
> usable with every GPIO or PWM device supported in Linux, and for
> special hardware like the Intel Timed I/O, it could configure it to
> output the pattern itself.
>=20
> One usecase besides stepper motors and Robotics would be solenoid
> valves: You often have different sequences for opening, closing and
> maintenance. E.g. for liquid valves, especially if the liquid is
> viscuous, you have to first use 100% duty cycle PWM for e.g. 250ms to
> get it open and then dial back to 50% to keep it open without
> overheating it.
>=20
> Of course this can be done in userspace.. but it may also be useful to
> have some kind of pattern generator in the kernel. What do you think?

Without hearing the usecases of the original idea my feeling is:
Implement it in userspace, than the sequences can even contain network
interaction and access to SPI eeproms.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xaedf33eqad6fiyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFINNUACgkQwfwUeK3K
7AlsBQf/Zs4LoJCKXSwbkuLjWCsmpP+lx/ihkiXzEvGtOmOwdc2mJMAG2gakJ0+w
SKtUl46Ee6q82/KeEPWqColHGMf+VIBmJ+3L9zYf7z24s5oFhlYOfZvXjbHIbTX9
eV+8PojbGCcW3Ps74AR/h6bla53bUTt1I+H0O1261b0PEz+oE9EiON0rhqXVEum1
vHEUg/CZlB4G/jtB+c3CEh/OPWs+K6t+yPfcBIVGUEkYd3u/D4AohSSvnwaREvIi
6KQ2gYYtvYIBlmPDUuSjvL4NrYLzN6R16WKs9ehjFF1r23ENNVftBKgCXai2eYz3
55urbAMOkRa6ZewLGXKTiUEXRUBMSw==
=4Se7
-----END PGP SIGNATURE-----

--xaedf33eqad6fiyv--
