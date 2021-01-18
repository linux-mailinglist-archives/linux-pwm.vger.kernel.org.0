Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A3B2F9AC4
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Jan 2021 08:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbhARHpU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Jan 2021 02:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbhARHpS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jan 2021 02:45:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018DAC061757
        for <linux-pwm@vger.kernel.org>; Sun, 17 Jan 2021 23:44:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1PDG-0007pM-BJ; Mon, 18 Jan 2021 08:44:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1PDF-0004CK-Mg; Mon, 18 Jan 2021 08:44:33 +0100
Date:   Mon, 18 Jan 2021 08:44:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
Message-ID: <20210118074433.fzdyfpd7xxrfynbt@pengutronix.de>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
 <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de>
 <20210117135803.gt2zgta5pv7o6t6t@einstein.dilieto.eu>
 <20210117184556.7huqlkxykjwionok@pengutronix.de>
 <20210117210618.ptnypp4zgk4lfuab@einstein.dilieto.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bw6bmqeu4wz2fqj6"
Content-Disposition: inline
In-Reply-To: <20210117210618.ptnypp4zgk4lfuab@einstein.dilieto.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bw6bmqeu4wz2fqj6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicola,

On Sun, Jan 17, 2021 at 10:06:18PM +0100, Nicola Di Lieto wrote:
> On Sun, Jan 17, 2021 at 07:45:56PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > > +	pwm_gpio->output =3D pwm_gpio->state ^ pwm_gpio->cur.invert;
> >=20
> > So far I understood also only comment. What wasn't obvious immediately
> > is the state member.
>=20
> Would it become clear enough by adding: "state is the logical PWM output;
> the actual PIN output level is inverted by XORing with cur.invert when the
> latter is true" ?

This was at least good enough for me to understand it now.

So iff state is true, the PWM is in the active phase of the current
period. Maybe "currently_active" is a better name for this variable?

Then the code could (with some comments added and a few more variables
renamed) could look as follows:

	if (ddata->currently_active) {
		/* Enter the inactive part of the current period. */
		ddata->currently_active =3D false;
		next_transistion =3D ddata->cur.toff_ns;
	} else {
		/*
		 * Start a new period. First check if there is a new
		 * configuration setting pending in ddata->new.
		 */
		ddata->currently_active =3D true;

		if (spin_trylock(&ddata->lock)) {
			ddata->cur =3D ddata->new;
			spin_unlock(&ddata->lock);
		}
		next_transition =3D ddata->cur.ton_ns;
	}
	...

which IMHO is easier to understand.

I think there are still two problems with this approach:

 - The locking is hard to follow, .enabled is accessed using atomic
   accessors, .new is protected by the spinlock and the other members
   are not accessed concurrently, right?
   If pwm_apply(..., {.enabled =3D false}) and pwm_apply(.., {.enabled =3D
   true}) are called in quick sequence (e.g. faster than the first call
   triggers the work queue) there is trouble ahead, isn't there?

 - If .duty_cycle is equal to 0 (or .period) the output should be
   constant. I think this isn't what will happen.

> > > Would it be ok to cancel the timer first and then "return
> > > pwmchip_remove(...)"?
> >=20
> > No. The PWM must stay functional until pwmchip_remove() returns.
> >=20
>=20
> Could you please clarify what I should do when pwmchip_remove returns
> non-zero? In my original implementation
> - if pwmchip_remove returns a non-zero error code, I return it to the
> caller and do not cancel the timer.
> - if pwmchip_remove returns zero, I cancel the timer and return zero to  =
the
> caller

IMHO it's a bug that pwmchip_remove() can return an error code. I think
the best you can do currently is:

	ret =3D pwmchip_remove(...)
	WARN_ON(ret);

	hrtimer_cancel(..);

	return 0;

because whatever you do is wrong. To sort this out needs some thought
and work in the framework and so is unrelated to this patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bw6bmqeu4wz2fqj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAFPF4ACgkQwfwUeK3K
7AlLnAf9G1EK9AIg46lWQP7nqCqeeYRHv0WufpKO7/EQuBWV9s8z3ZTGLykYTkk8
3hC5RtuuejUrMVwGNdV4B4t5iTB56rdyMnk1PISIJhopmFz5naNhFKmNh7RHCzwF
hbwAiI0veY0+C31L6XvqAel0qb7T8Co8+IGoDmurMw2DDxo9NsGjfR0ZJuqG/ji/
vFUKYXEf1F+Q7TjjyTDwAFINBsN4JdWSeKKuVU6eklIodve0M0qAbZx+jyqFhPYd
L6ryZ40DxAl2NuyCVjJqkCvkU67XUEuqyEFhKQtFlxI1mVhaCRywcKuPVGO9ahp0
eNq+Yt0sAPGx1oyz6H+bwUwXZ6+xew==
=jOxa
-----END PGP SIGNATURE-----

--bw6bmqeu4wz2fqj6--
