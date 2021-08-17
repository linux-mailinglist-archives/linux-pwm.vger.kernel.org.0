Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE03EF141
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhHQSEt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhHQSEs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 14:04:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704FC061764
        for <linux-pwm@vger.kernel.org>; Tue, 17 Aug 2021 11:04:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mG3RZ-00057n-P1; Tue, 17 Aug 2021 20:04:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mG3RX-0006BY-V6; Tue, 17 Aug 2021 20:04:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mG3RX-0000pC-U5; Tue, 17 Aug 2021 20:04:07 +0200
Date:   Tue, 17 Aug 2021 20:04:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210817180407.ru4prwu344dxpynu@pengutronix.de>
References: <20210719221322.3723009-1-sean.anderson@seco.com>
 <20210719221322.3723009-3-sean.anderson@seco.com>
 <20210814204710.retjwn5fycwtrypp@pengutronix.de>
 <e8d39f18-3aa9-e617-6439-2c0b071f62b3@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6sd75wqw5pt3megh"
Content-Disposition: inline
In-Reply-To: <e8d39f18-3aa9-e617-6439-2c0b071f62b3@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6sd75wqw5pt3megh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 16, 2021 at 07:51:17PM -0400, Sean Anderson wrote:
>=20
>=20
> On 8/14/21 4:47 PM, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Sean,
> >=20
> > sorry for having you let waiting so long. Now here some more feedback:
> >=20
> > On Mon, Jul 19, 2021 at 06:13:22PM -0400, Sean Anderson wrote:
> > > +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device=
 *unused,
> > > +			    const struct pwm_state *state)
> > > +{
> > > +	bool enabled;
> > > +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> > > +	u32 tlr0, tlr1, tcsr0, tcsr1;
> > > +	u64 period_cycles, duty_cycles;
> > > +	unsigned long rate;
> > > +
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * To be representable by TLR, cycles must be between 2 and
> > > +	 * priv->max + 2. To enforce this we can reduce the duty
> > > +	 * cycle, but we may not increase it.
> > > +	 */
> > > +	rate =3D clk_get_rate(priv->clk);
> > > +	period_cycles =3D mul_u64_u32_div(state->period, rate, NSEC_PER_SEC=
);
> >=20
> > cool, I didn't know mul_u64_u32_div.
>=20
> I didn't either. Alas, many useful functions like these have no
> documentation...
>=20
> >=20
> > Hmm, we still have a problem here if
> >=20
> > 	state->period * rate > 1000000000 * U64_MAX.
>=20
> Note that this can only occur with rate > 1GHz (and period =3D U64_MAX).
> The highest fmax in the datasheet is 300 MHz (on a very expensive FPGA).
>=20
> Maybe it is more prudent to do
>=20
> 	period =3D min(state->period, ULONG_MAX * NSEC_PER_SEC)

Together with a check for rate being <=3D 300 MHz to be safe that's fine.

> I think a period of 136 years is adequate :) This comparison also has
> the advantage of being against const values.

*nod*

> > > +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> > > +				 struct pwm_device *unused,
> > > +				 struct pwm_state *state)
> > > +{
> > > +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> > > +	u32 tlr0, tlr1, tcsr0, tcsr1;
> > > +
> > > +	regmap_read(priv->map, TLR0, &tlr0);
> > > +	regmap_read(priv->map, TLR1, &tlr1);
> > > +	regmap_read(priv->map, TCSR0, &tcsr0);
> > > +	regmap_read(priv->map, TCSR1, &tcsr1);
> > > +	state->period =3D xilinx_timer_get_period(priv, tlr0, tcsr0);
> >=20
> > xilinx_timer_get_period rounds down, this is however wrong for
> > .get_state().
>=20
> Why is this wrong? I thought get_state should return values which would
> not be rounded if passed to apply_state.

Consider a PWM that yields a period of =CF=80 * $regval ns when a certain
register is programmed with the value $regval.

Consider the HW is programmed with regval =3D 317. The exact period is
995.8848711879644. If now .get_state() rounds down and returns 995 ns and
you feed that value back into .apply the new regval (assuming round down
in .apply(), too) this yields regval =3D 316. If however .get_state()
rounds up and returns 996, putting this value back into .apply() you get
the desired 317.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6sd75wqw5pt3megh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEb+hQACgkQwfwUeK3K
7AnI6wf+KmtvtJ/bo+wlOQtLD/Ow1TwFpxzoAQBBKSFnW9EfiMZBwFYGrq/g+q82
zfUB26VZiuUOZwmtPHjzWPOXJc/gZKHiAv6fLkoGERkZCWY4gDaDJOpzeecONgNp
59AtIZjRuV0jO+apwZLJqLhXEAleIILze5BUO20Mm1DSR7B+PkKJ97R8UfLGROUc
unF34ncqtLLSR03Uj5M8Ru9aj4AQtpN400bkDcK4Uc1MpzkNAffnIL4QDHCA4scV
8pk2EJeEk9Zu2c4sHOl7/8C19nl9bEVyL61BBKYCHHbthcCvL/uSLILe8mATqJsA
WISWK2i5AAL3fykygoxrj/IZC16CXQ==
=lrWV
-----END PGP SIGNATURE-----

--6sd75wqw5pt3megh--
