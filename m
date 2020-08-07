Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7855223EB6F
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHGKYz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgHGKYz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2020 06:24:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F9C061574
        for <linux-pwm@vger.kernel.org>; Fri,  7 Aug 2020 03:24:54 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3zYO-0001jw-TK; Fri, 07 Aug 2020 12:24:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3zYI-0003e8-3P; Fri, 07 Aug 2020 12:24:42 +0200
Date:   Fri, 7 Aug 2020 12:24:41 +0200
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
Message-ID: <20200807102441.qcshhsc36nzj7bpn@pengutronix.de>
References: <20200803093559.12289-1-michael@walle.cc>
 <20200803093559.12289-7-michael@walle.cc>
 <20200806084000.k3aj5nmqdodmb35v@pengutronix.de>
 <e288ca6cfee819223395712e04159dd9@walle.cc>
 <20200807074543.pfbwlhtegl3oc4zp@pengutronix.de>
 <92116be9aa56250becc4019c6c7a1538@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ui3bvps5z2hxjh32"
Content-Disposition: inline
In-Reply-To: <92116be9aa56250becc4019c6c7a1538@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ui3bvps5z2hxjh32
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, Aug 07, 2020 at 09:55:19AM +0200, Michael Walle wrote:
> Am 2020-08-07 09:45, schrieb Uwe Kleine-K=F6nig:
> > On Fri, Aug 07, 2020 at 09:28:31AM +0200, Michael Walle wrote:
> > > Am 2020-08-06 10:40, schrieb Uwe Kleine-K=F6nig:
> > > > On Mon, Aug 03, 2020 at 11:35:52AM +0200, Michael Walle wrote:
> > > > > +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
> > > > > +				   struct pwm_device *pwm,
> > > > > +				   struct pwm_state *state)
> > > > > +{
> > > > > +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> > > > > +	unsigned int reg;
> > > > > +	int prescaler;
> > > > > +
> > > > > +	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CTRL, &reg);
> > > > > +
> > > > > +	state->enabled =3D reg & SL28CPLD_PWM_CTRL_ENABLE;
> > > > > +
> > > > > +	prescaler =3D FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
> > > > > +	state->period =3D SL28CPLD_PWM_PERIOD(prescaler);
> > > > > +
> > > > > +	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CYCLE, &reg);
> > > > > +	state->duty_cycle =3D SL28CPLD_PWM_TO_DUTY_CYCLE(reg);
> > > >
> > > > Should reg be masked to SL28CPLD_PWM_CYCLE_MAX, or is it guaranteed=
 that
> > > > the upper bits are zero?
> > >=20
> > > Mh, the hardware guarantees that bit7 is zero. So masking with
> > > SL28CPLD_PWM_CYCLE_MAX won't buy us much. But what I could think
> > > could go wrong is this: someone set the prescaler to !=3D 0 and the
> > > duty cycle to a value greater than the max value for this particular
> > > prescaler mode. For the above calculations this would result in a
> > > duty_cycle greater than the period, if I'm not mistaken.
> > >=20
> > > The behavior of the hardware is undefined in that case (at the moment
> > > it will be always on, I guess). So this isn't a valid setting.
> > > Nevertheless it might happen. So what about the following:
> > >=20
> > > state->duty_cycle =3D min(state->duty_cycle, state->period);
> >=20
> > If you care about this: This can also happen (at least shortly) in
> > sl28cpld_pwm_apply() as you write SL28CPLD_PWM_CTRL before
> > SL28CPLD_PWM_CYCLE there.
>=20
> It could also happen if it was the other way around, couldn't it?
> Changing modes might glitch.

If you want to prevent this, you have to order the writes depending on
prescaler increasing or decreasing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ui3bvps5z2hxjh32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8tK+YACgkQwfwUeK3K
7Am+ZAf/fEspbQK7oTVzKrTHBQXxu0AjknqY6yLOlTFthBSsQqbzGwekDnDjQG21
Emw2dyTCQW7YHQaYx8l1HilDsVFiazBpJ6yG49upduH83s15tgAB4Guv2uTbrzim
uMsqxPDtiCrjGdTw4MNt37OoKh0A2O+IAd1yuSrgDpQqWiDM0uNs+MMNZm8OQAST
ZkVhwCFr28b9QNzUodg6d2QK5T5DWEgt6BFkPpn5SFUc/mMMQs2/3LcaBOh2Gd9/
FqKla8k4Akpniv4OcC93n0QfOap22V69gLflWJLN2YB3Gn+BvZLqMvhAgF6cy/Ho
jEP7yLYqhcfx644/uGqeHpOHNDm8Eg==
=jSvw
-----END PGP SIGNATURE-----

--ui3bvps5z2hxjh32--
