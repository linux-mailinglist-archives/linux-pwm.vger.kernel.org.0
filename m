Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF72F770E
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 11:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbhAOKyp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Jan 2021 05:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbhAOKym (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Jan 2021 05:54:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36422C061757
        for <linux-pwm@vger.kernel.org>; Fri, 15 Jan 2021 02:54:02 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0Mjl-0004qr-2U; Fri, 15 Jan 2021 11:53:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0MjG-0005DQ-Sc; Fri, 15 Jan 2021 11:53:18 +0100
Date:   Fri, 15 Jan 2021 11:53:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-gpio@vger.kernel.org,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 5/5] gpio: mvebu: document zero pwm duty cycle
 limitation
Message-ID: <20210115105318.n2vov4gw6ohv4rxp@pengutronix.de>
References: <cover.1610628807.git.baruch@tkos.co.il>
 <7c18dd67d3bf3e3ed9a8efa2edd33e8f29f09a7a.1610628807.git.baruch@tkos.co.il>
 <20210114202545.7wnc5ikeffc45xk5@pengutronix.de>
 <20210114222802.GY1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5umzkznxwn4gsq5"
Content-Disposition: inline
In-Reply-To: <20210114222802.GY1551@shell.armlinux.org.uk>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--w5umzkznxwn4gsq5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 10:28:02PM +0000, Russell King - ARM Linux admin wr=
ote:
> On Thu, Jan 14, 2021 at 09:25:45PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Baruch,
> >=20
> > On Thu, Jan 14, 2021 at 08:57:37PM +0200, Baruch Siach wrote:
> > > Add a comment on why the code never sets on/off registers to zero.
> > >=20
> > > Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Analyzed-by: Russell King <linux@armlinux.org.uk>
> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > ---
> > >  drivers/gpio/gpio-mvebu.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > > index 6b017854ce61..09780944bef9 100644
> > > --- a/drivers/gpio/gpio-mvebu.c
> > > +++ b/drivers/gpio/gpio-mvebu.c
> > > @@ -706,6 +706,10 @@ static int mvebu_pwm_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >  	do_div(val, NSEC_PER_SEC);
> > >  	if (val > UINT_MAX)
> > >  		return -EINVAL;
> > > +	/*
> > > +	 * Zero on/off values don't work as expected. Experimentation shows
> > > +	 * that zero value is treated as 2^32. This behavior is not documen=
ted.
> > > +	 */
> >=20
> > This is too easy. The right thing to do is to adapt .apply and
> > .get_state to use this new information.
>=20
> What exactly do you expect the changes to be?

What I expect is:

 - let .apply() write 0 if the intention is to configure 2^32 clock
   steps for the on or off register; and symmetrically
 - let .get_state report 2^32 * NSEC_PER_SEC / clk_rate if the register
   value is 0.
=20
> Bear in mind that the hardware is not capable of atomically updating
> e.g. the duty cycle without affecting the period, because any change
> in duty cycle needs the "on" and "off" durations to be separately
> programmed, and there's a chance that the hardware could start using
> either value mid-update.
>=20
> Also, disabling "blink" mode to achieve a steady output (for 0% or 100%
> duty cycle) would require further investigation to find out how the
> hardware behaves at the moment where blink mode is disabled: does the
> output retain its current state (does the bit in the output register
> toggle with the blink) or does it revert to the value in the output
> register that was programmed before blink mode was enabled.

I have some plans here about what is the right behaviour, but this needs
some preparatory work that I didn't do yet. I'll come back to this
eventually.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w5umzkznxwn4gsq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmABdBsACgkQwfwUeK3K
7AmSbQf/b6xusBmeJVR8LHLl4M8AVis579GcNw//cubD6SzItF6Vz9ziSM9zs2hG
vWEf6U3UzCn/27oHJTPD6/xBqVV85rE+qUkRv7zZ2zps+foAIQkZlRYa+nkj3WT9
dUVKSwuDRZ+8W0yqbBsqzbwxqdscM+CicuIsIWtOC1lN8e/0aSwkmVYQpHMpUeRn
jTI+GgKxjiHyy1S4ahuAAcXcZgPVwrqPdJ+vRQdFX/RsOiTAQBCuWoAhRWq6lZB8
y51xCo3AhtTYLzooES4emK33NYRtSbISNiUFDk3UlpKhUioGoo3cPtmY+atrgV3/
x+WeYEG8t6xmCC+rJxa8LpQi4s+rcw==
=6hbj
-----END PGP SIGNATURE-----

--w5umzkznxwn4gsq5--
