Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58F23E832
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHGHpx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 03:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgHGHpw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2020 03:45:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD32C061574
        for <linux-pwm@vger.kernel.org>; Fri,  7 Aug 2020 00:45:51 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3x4V-0001Pr-7L; Fri, 07 Aug 2020 09:45:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3x4R-000615-Vj; Fri, 07 Aug 2020 09:45:44 +0200
Date:   Fri, 7 Aug 2020 09:45:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200807074543.pfbwlhtegl3oc4zp@pengutronix.de>
References: <20200803093559.12289-1-michael@walle.cc>
 <20200803093559.12289-7-michael@walle.cc>
 <20200806084000.k3aj5nmqdodmb35v@pengutronix.de>
 <e288ca6cfee819223395712e04159dd9@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6vfvapgawy5623je"
Content-Disposition: inline
In-Reply-To: <e288ca6cfee819223395712e04159dd9@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6vfvapgawy5623je
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 09:28:31AM +0200, Michael Walle wrote:
> Hi Uwe, Hi Lee,
>=20
> Am 2020-08-06 10:40, schrieb Uwe Kleine-K=F6nig:
> > On Mon, Aug 03, 2020 at 11:35:52AM +0200, Michael Walle wrote:
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 7dbcf6973d33..a0d50d70c3b9 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -428,6 +428,16 @@ config PWM_SIFIVE
> > >  	  To compile this driver as a module, choose M here: the module
> > >  	  will be called pwm-sifive.
> > >=20
> > > +config PWM_SL28CPLD
> > > +	tristate "Kontron sl28cpld PWM support"
> > > +	select MFD_SIMPLE_MFD_I2C
> >=20
> > Is it sensible to present this option to everyone? Maybe
> >=20
> > 	depends on SOME_SYMBOL_ONLY_TRUE_ON_SL28CPLD || COMPILE_TEST
>=20
> Because there is now no real MFD driver anymore, there is also
> no symbol for that. The closest would be ARCH_ARM64 but I don't
> think that is a good idea.
>=20
> Lee, what do you think about adding a symbol to the MFD, which
> selects MFD_SIMPLE_MFD_I2C but doesn't enable any C modules?
>=20
> I.e.
> config MFD_SL28CPLD
>     tristate "Kontron sl28cpld"
>     select MFD_SIMPLE_MFD_I2C
>     help
>       Say yes here to add support for the Kontron sl28cpld board
>       management controller.
>=20
> Then all the other device driver could depend on the MFD_SL28CPLD
> symbol.
>=20
> [..]
>=20
> > > +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
> > > +				   struct pwm_device *pwm,
> > > +				   struct pwm_state *state)
> > > +{
> > > +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> > > +	unsigned int reg;
> > > +	int prescaler;
> > > +
> > > +	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CTRL, &reg);
> > > +
> > > +	state->enabled =3D reg & SL28CPLD_PWM_CTRL_ENABLE;
> > > +
> > > +	prescaler =3D FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
> > > +	state->period =3D SL28CPLD_PWM_PERIOD(prescaler);
> > > +
> > > +	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CYCLE, &reg);
> > > +	state->duty_cycle =3D SL28CPLD_PWM_TO_DUTY_CYCLE(reg);
> >=20
> > Should reg be masked to SL28CPLD_PWM_CYCLE_MAX, or is it guaranteed that
> > the upper bits are zero?
>=20
> Mh, the hardware guarantees that bit7 is zero. So masking with
> SL28CPLD_PWM_CYCLE_MAX won't buy us much. But what I could think
> could go wrong is this: someone set the prescaler to !=3D 0 and the
> duty cycle to a value greater than the max value for this particular
> prescaler mode. For the above calculations this would result in a
> duty_cycle greater than the period, if I'm not mistaken.
>=20
> The behavior of the hardware is undefined in that case (at the moment
> it will be always on, I guess). So this isn't a valid setting.
> Nevertheless it might happen. So what about the following:
>=20
> state->duty_cycle =3D min(state->duty_cycle, state->period);

If you care about this: This can also happen (at least shortly) in
sl28cpld_pwm_apply() as you write SL28CPLD_PWM_CTRL before
SL28CPLD_PWM_CYCLE there.

I wonder if we want to sanitize the values returned from driver's
=2Eget_state in the core; or scream loud (maybe only if PWM_DEBUG is on).

Something like:

	if (state->enabled && state->duty_cycle > state->period) {
		if (IS_ENABLED(CONFIG_PWM_DEBUG))
			dev_warn(chip->dev, ".get_state() returned invalid setting.\n");

		state->duty_cycle =3D state->period;
	}

Do we want to catch state->period =3D 0, too? Do we interpret this as
disabled?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6vfvapgawy5623je
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8tBqQACgkQwfwUeK3K
7AkxWAgAoG+PqaPjPFtzNF9JWYONbF6XKaC5Ptr0ArDt6eAhMk/J7dN5fPbk53SY
BwI2bQI42oVwcpBcRWuwfW3cRIVw+71KyOcPH5JYyX5BGEKqPOVGpWeHWcE2VCpz
wgvROpNxKRAJSkiUCaqPEEGVUyYrYrfYIBVNapbq9BOafMXoyISCClOWpNqMkm77
NH8PRsmlkdbZRXV6r+u7bw859VNc32IAFdITfYJa7iAXe+w8GiS8Ow1iFmdE6pXT
v8/RLQsKka7TsakHZ4FgzI4V9nRjaHBlLuY724cyYlScVKHuX3rQiQ6LoU/vTaPD
DOycv3Dc1STgW4hmNt9AQcCLCJlL+A==
=dkcM
-----END PGP SIGNATURE-----

--6vfvapgawy5623je--
