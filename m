Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF6F3B549F
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Jun 2021 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhF0SV5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 27 Jun 2021 14:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhF0SV5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 27 Jun 2021 14:21:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29002C061574
        for <linux-pwm@vger.kernel.org>; Sun, 27 Jun 2021 11:19:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxZNQ-0006uv-Sb; Sun, 27 Jun 2021 20:19:28 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxZNO-0002RM-SA; Sun, 27 Jun 2021 20:19:26 +0200
Date:   Sun, 27 Jun 2021 20:19:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210627181919.iunagls4j67ignhh@pengutronix.de>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
 <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
 <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
 <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
 <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ycistqidpnmvvrzs"
Content-Disposition: inline
In-Reply-To: <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ycistqidpnmvvrzs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
> On 6/25/21 12:56 PM, Uwe Kleine-K=F6nig wrote:
> > On Fri, Jun 25, 2021 at 11:13:33AM -0400, Sean Anderson wrote:
> > > On 6/25/21 2:19 AM, Uwe Kleine-K=F6nig wrote:
> > > > On Fri, May 28, 2021 at 05:45:22PM -0400, Sean Anderson wrote:
> > > >> + * - Cannot produce 100% duty cycle.
> > > >
> > > > Can it produce a 0% duty cycle? Below you're calling
> > > > xilinx_timer_tlr_period(..., ..., ..., 0) then which returns -ERANG=
E.
> > >=20
> > > Yes. This is what you get when you try to specify 100% duty cycle (e.=
g.
> > > TLR0 =3D=3D TLR1).
> >=20
> > OK, so the hardware can do it, but your driver doesn't make use of it,
> > right?
>=20
> So to clarify, I have observed the following behavior
>=20
> * When TCSR =3D=3D 0, the output is constant low.
> * When TLR1 (duty_cycle) >=3D TLR0 (period), the output is constant low.
>=20
> It might be possible to achieve constant high output by stopping the
> counters during the high time, but leaving the PWM bit set. However, I
> do not have a use case for this. I think it might be a nice follow-up
> for someone who wants that feature.

A typical use case is having an LED or a backlight connected to the PWM
and and want it to be fully on.

> That being said, is there a standard way to specify 100% or 0% duty
> cycle? It seems like one would have to detect these situations and use a
> different code path.

I don't understand that question. If pwm_apply_state is called with a
state having .duty_cycle =3D 0 (and .enabled =3D true) you're supposed to
emit a 0% relative duty. If .duty_cycle =3D .period is passed you're
supposed to emit a 100% relative duty.

> > > >> + * - Only produces "normal" output.
> > > >
> > > > Does the output emit a low level when it's disabled?
> > >=20
> > > I believe so.
> >=20
> > Is there a possibility to be sure? I'd like to know that to complete my
> > picture about the behaviour of the supported PWMs.
>=20
> See above.
>=20
> > > >> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_dev=
ice *unused,
> > > >> +			    const struct pwm_state *state)
> > > >> +{
> > > >> +	int ret;
> > > >> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> > > >> +	u32 tlr0, tlr1;
> > > >> +	u32 tcsr0 =3D xilinx_timer_read(priv, TCSR0);
> > > >> +	u32 tcsr1 =3D xilinx_timer_read(priv, TCSR1);
> > > >> +	bool enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> > > >> +
> > > >> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > >> +		return -EINVAL;
> > > >> +
> > > >> +	ret =3D xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->perio=
d);
> > > >> +	if (ret)
> > > >> +		return ret;
> > > >
> > > > The implementation of xilinx_timer_tlr_period (in patch 2/3) returns
> > > > -ERANGE for big periods. The good behaviour to implement is to cap =
to
> > > > the biggest period possible in this case.
> > >=20
> > > Ok. Is this documented anywhere?
> >=20
> > I tried but Thierry didn't like the result and I didn't retry. The
> > problem is also that many drivers we already have in the tree don't
> > behave like this (because for a long time nobody cared). That new
> > drivers should behave this way is my effort to get some consistent
> > behaviour.
>=20
> Do you have a link to the thread? IMO if you would like to specify
> behavior like this, is is very helpful to write it down so new authors
> don't have to get to v4 before finding out about it ;)

I misremembered, the last time I wanted to improve the documentation I
didn't write anything about the policy with the goal to improve the
documentation without hitting the a bit controversial policy stuff. The
thread is available at

	https://lore.kernel.org/r/20191209213233.29574-2-u.kleine-koenig@pengutron=
ix.de

=2E Thierry didn't reply to this thread yet.

My intension was to build on this one and formulate the expected policy
for new drivers.

The situation I'm in here wanting to install this policy is: On one hand
Thierry argues that consumers don't care much about how .apply rounds
because most consumers just don't have so exact requirements. And on the
other hand he doesn't want to change the existing behaviour for already
existing drivers to not break consumers. So the best I can currently to
do work on a more consistent behaviour is to enforce this for new
drivers.

> > > And wouldn't this result in the wrong duty cycle? E.g. say the max
> > > value is 100 and I try to apply a period of 150 and a duty_cycle of 75
> > > (for a 50% duty cycle). If we cap at 100, then I will instead have a
> > > 75% duty cycle, and there will be no error.
> >=20
> > Yes that is right. That there is no feedback is a problem that we have
> > for a long time. I have a prototype patch that implements a
> > pwm_round_state() function that lets a consumer know the result of
> > applying a certain pwm_state in advance. But we're not there yet.
>=20
> So for the moment, why not give an error? This will be legal code both
> now and after round_state is implemented.

The problem is where to draw the line. To stay with your example: If a
request for period =3D 150 ns comes in, and let X be the biggest period <=3D
150 ns that the hardware can configure. For which values of X should an
error be returned and for which values the setting should be
implemented.

In my eyes the only sensible thing to implement here is to tell the
consumer about X and let it decide if it's good enough. If you have a
better idea let me hear about it.

> > > So I will silently get the wrong duty cycle, even when that duty cycle
> > > is probably more important than the period.
> >=20
> > It depends on the use case and every policy is wrong for some cases. So
> > I picked the policy I already explained because it is a) easy to
> > implement for lowlevel drivers and b) it's easy to work with for
> > consumers once we have pwm_round_state().
>=20
> What about sysfs? Right now if you try to specify an inexpressible
> period you get an error message. I saw [1], but unfortunately there do
> not appear to be any patches associated with it. Do you have plans to
> implement such an interface?
>=20
> [1] https://lore.kernel.org/linux-pwm/CAO1O6seyi+1amAY5YLz0K1dkNd7ewAvot4=
K1eZMpAAQquz0-9g@mail.gmail.com/

In my eyes we better implement a pwmctl interface that doesn't work via
sysfs but using an ioctl; similar what gpio did with gpioctl for various
reasons.

> > > > Also note that state->period is an u64 but it is casted to unsigned=
 int
> > > > as this is the type of the forth parameter of xilinx_timer_tlr_peri=
od.
> > >=20
> > > Hm, it looks like I immediately cast period to a u64. I will change t=
he
> > > signature for this function next revision.
> >=20
> > Then note that period * clk_get_rate(priv->clk) might overflow.
>=20
> Ok, so is mult_frac the correct macro to use here?
>=20
> > > >> +	ret =3D xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_=
cycle);
> > > >> +	if (ret)
> > > >> +		return ret;
>=20
> Perhaps I should add
>=20
> 	if (tlr0 <=3D tlr1)
> 		return -EINVAL;
>=20
> here to prevent accidentally getting 0% duty cycle.

You can assume that duty_cycle <=3D period when .apply is called.

> > > >> +	else if (pwm_cells)
> > > >> +		return dev_err_probe(dev, -EINVAL, "#pwm-cells must be 0\n");
> > > >
> > > > What is the rationale here to not support #pwm-cells =3D <2>?
> > >=20
> > > Only one PWM is supported. But otherwise there is no particular
> > > reason.
> >=20
> > The usual binding is to have 3 additional parameters.
> >   1) chip-local pwm number (which can only be 0 for a pwmchip having
> >      .npwm =3D 1)
> >   2) the "typical" period
> >   3) some flags (like PWM_POLARITY_*)
> >=20
> > I don't care much if you implement it with or without 1), but 2) and 3)
> > should IMHO be here. If you don't want 1),
> > http://patchwork.ozlabs.org/project/linux-pwm/patch/20210622030948.9667=
48-1-bjorn.andersson@linaro.org/
> > might be interesting for you. (But note, Thierry didn't give feedback to
> > this yet, it might be possible he wants 1)-3) for new drivers.)
>=20
> Ok, so since I let of_pwmchip_add set xlate, I don't need to change
> anything in this driver? Then I will remove this check for v5.

Yes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ycistqidpnmvvrzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDYwSMACgkQwfwUeK3K
7AnIBggAlPOYEWVOy7ALmO1d8KGdldnfM/x9nBOHfJlFuz/Uu5L+Yy+jKMIJsWd4
So+uy3ag4ONOOwQZQl0365dGa3BbYM5o9kwW0yoS/PrecqrvU1UpQ+CO/jLpgI0f
mRqBQQobLQCP2dKKcLn6PCj+XskeCntT31j7ICtzOVWj6RT24yuLWcvLIswIZkFo
SnI4a0+4hV1Ll69IRZEfdIKAbNHDHiER99HsdRqs8jvTFG0UEMUtE75c1bE/DiTS
fDMR6ZG/bDrYsmlGb39qWcyr3oywtbADth3fpA74bxvYJF15kA5jsEuDPQua1QfR
JUljjXE+BV8Xqim7TIwkt+usBtctsw==
=2rGA
-----END PGP SIGNATURE-----

--ycistqidpnmvvrzs--
