Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E10F33739F
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Mar 2021 14:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhCKNTN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Mar 2021 08:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhCKNS5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Mar 2021 08:18:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3DDC061574
        for <linux-pwm@vger.kernel.org>; Thu, 11 Mar 2021 05:18:57 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKLDI-0008Jt-7H; Thu, 11 Mar 2021 14:18:52 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKLDE-0002l3-Lz; Thu, 11 Mar 2021 14:18:48 +0100
Date:   Thu, 11 Mar 2021 14:18:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v7 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
Message-ID: <20210311131845.x3zybis3x2liu2uk@pengutronix.de>
References: <20210118123244.13669-1-nsaenzjulienne@suse.de>
 <20210118123244.13669-12-nsaenzjulienne@suse.de>
 <20210310115041.s7tzvgdpksws6yss@pengutronix.de>
 <fc60ac5ab9760d791aa5e184258accf53e07ce1e.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhlssdtxmegt66au"
Content-Disposition: inline
In-Reply-To: <fc60ac5ab9760d791aa5e184258accf53e07ce1e.camel@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jhlssdtxmegt66au
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Thu, Mar 11, 2021 at 02:01:00PM +0100, Nicolas Saenz Julienne wrote:
> On Wed, 2021-03-10 at 12:50 +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jan 18, 2021 at 01:32:44PM +0100, Nicolas Saenz Julienne wrote:
>=20
> [...]
>=20
> > > +	/*
> > > +	 * This sets the default duty cycle after resetting the board, we
> > > +	 * updated it every time to mimic Raspberry Pi's downstream's driver
> > > +	 * behaviour.
> > > +	 */
> > > +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_DEF_=
DUTY_REG,
> > > +					   duty_cycle);
> > > +	if (ret) {
> > > +		dev_err(chip->dev, "Failed to set default duty cycle: %pe\n",
> > > +			ERR_PTR(ret));
> > > +		return ret;
> >=20
> > This only has an effect for the next reboot, right?
>=20
> It effects all reboots until it's further changed.
>=20
> > If so I wonder if it is a good idea in general. (Think: The current PWM
> > setting enables a motor that makes a self-driving car move at 100 km/h.
> > Consider the rpi crashes, do I want to car to pick up driving 100 km/h =
at
> > power up even before Linux is up again?)
>=20
> I get your point. But this isn't used as a general purpose PWM. For now t=
he
> interface is solely there to drive a PWM fan that's arguably harmless. Th=
is
> doesn't mean that the RPi foundation will not reuse the firmware interfac=
e for
> other means in the future. In such case we can always use a new DT compat=
ible
> and bypass this feature (the current DT string is
> 'raspberrypi,firmware-poe-pwm', which is specific to this use-case).
>=20
> My aim here is to be on par feature wise with RPi's downstream implementa=
tion.

Just because the downstream kernel does it should not be the (single)
reason to do that. My gut feeling is: For a motor restoring the PWM
config on reboot is bad and for a fan it doesn't really hurt if it
doesn't restart automatically. So I'd prefer to to drop this feature.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jhlssdtxmegt66au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBKGLIACgkQwfwUeK3K
7AmVtwf/VJTFZ6KfFb0/nBuZLz71q/mBcEZrZwWPlKFMsb9C2jLRRJpnJ/1+zUoM
Q41GHxf9j/O0tW/e7Hl8gR/ri8qMtJN6a4LOI31Icx7b4d3jFuiWVSIg+9UfhLwN
Oq6m1B3VzzUmL4LWK+9qsfHwKJi/1FozbnMFFDCs7tnN4b9OmmZn2JkGNInxK5FT
NQyA3wL9Pv+HyVliXk4948HvKO73dzj9yZCVfY3cb/XTb3HADs5+kwa3IT+l/g74
nFj5qaKNNR4+QUibzclk9PGoj63N2XsS6vDEsncDoV2QHtJumODIQat6920OyNqh
UvNUyCqUmLZntZ28GK0jzSeX+Kz3IA==
=DtDQ
-----END PGP SIGNATURE-----

--jhlssdtxmegt66au--
