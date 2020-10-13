Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8337B28CE32
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgJMMSQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 08:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgJMMSQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2020 08:18:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C38C0613D0
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 05:18:16 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSJFf-000448-Ju; Tue, 13 Oct 2020 14:17:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSJFe-0007iN-NI; Tue, 13 Oct 2020 14:17:58 +0200
Date:   Tue, 13 Oct 2020 14:17:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: Add Raspberry Pi Firmware based PWM bus
Message-ID: <20201013121758.gl6ni4b47ei2bhdf@pengutronix.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
 <20201009153031.986-4-nsaenzjulienne@suse.de>
 <20201012070626.fzjhp3tkmgglqnm4@pengutronix.de>
 <7899e490543723c97ffad6f42942907f8db6b9b4.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xntkxwoajyvakbba"
Content-Disposition: inline
In-Reply-To: <7899e490543723c97ffad6f42942907f8db6b9b4.camel@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xntkxwoajyvakbba
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Tue, Oct 13, 2020 at 01:20:00PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2020-10-12 at 09:06 +0200, Uwe Kleine-K=F6nig wrote:
> > > +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FI=
RMWARE)
> >=20
> > This is more complicated than necessary.
> >=20
> > 	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> >=20
> > is logically equivalent.
>=20
> It's not exactly the same, see patch 7ed915059c300 ("gpio: raspberrypi-ex=
t: fix
> firmware dependency ") which explains why this pattern is needed.

Hmm, this is strange, but if Arnd doesn't know a better solution, then
be it so. Is this idiom usual enough to not justify a comment?

> > What happens if duty_cycle happens to be bigger than RPI_PWM_MAX_DUTY?
> >=20
> > I think the right thing to do here is:
> >=20
> > 	if (state->period < RPI_PWM_PERIOD_NS ||
>=20
> Why not using state->period !=3D RPI_PWM_PERIOD_NS here?

=46rom the consumer's point of view having to hit the only correct period
is hard. So the usual convention is to provide the biggest period not
bigger than the requested one. (The idea for the future is to provide a
pwm_round_state() function which allows to find out the effect of
pwm_apply_state() with the same arguments. This then allows to
efficiently find the best setting for the consumer.)

> > Huh, why do you have to do this twice, just with different error
> > messages? I assume you want to set RPI_PWM_DEF_DUTY_REG? What is the
> > effect of writing this property?
>=20
> Obviously, I failed to change the register name.
>=20
> This is supposed to set the default duty cycle after resetting the board.=
 I
> added it so as to keep compatibility with the downstream version of this.
>=20
> I'll add a comment to explain this.

fine.

> > > +	int ret;
> > > +
> > > +	firmware_node =3D of_get_parent(dev->of_node);
> > > +	if (!firmware_node) {
> > > +		dev_err(dev, "Missing firmware node\n");
> > > +		return -ENOENT;
> > > +	}
> > > +
> > > +	firmware =3D rpi_firmware_get(firmware_node);
> > > +	of_node_put(firmware_node);
> > > +	if (!firmware)
> > > +		return -EPROBE_DEFER;
> >=20
> > I don't see a mechanism that prevents the driver providing the firmware
> > going away while the PWM is still in use.
>=20
> There isn't an explicit one. But since you depend on a symbol from the fi=
rmware
> driver you won't be able to remove the kernel module before removing the =
PMW
> one.

this prevents the that the module is unloaded, but not that the driver
is unbound.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xntkxwoajyvakbba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+FmvMACgkQwfwUeK3K
7Alr6QgAoSvGO1utwKB8imjfhuiIKqO6D57vwFc/bGxPmKrIYCfqkAMhITgHDlGX
lwyzgxZhJ19q6k/DpQ+H7L6LuQv0X1uKjSyiJtjBSxIVySGOhfdBmKq0rPpfduXa
0wIj5ioSxBotq1KPo1lGbx2NNi8+V5s0Sf1LQjduMaOLKZtwj1z63AJMnsA6thzb
mTa40+dNb2TPtpIZBpBJS3G5H82l/iccRvBWCLXipOS8TEHG5dDEmjwRwJK6Zkfl
2G1vLDe1hxn2VWkTwtkIAPfa+yF3q5RwJW85MBIN0sh6GK9MkV0rJ5tJ9D3q0ID5
WdUQqTE27kuilbmMhsIsTMLJIT7qjg==
=+cRP
-----END PGP SIGNATURE-----

--xntkxwoajyvakbba--
