Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBF52D1C4D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 22:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgLGVrf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 16:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgLGVrf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 16:47:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD75C061794
        for <linux-pwm@vger.kernel.org>; Mon,  7 Dec 2020 13:46:54 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmOLE-0004A9-2U; Mon, 07 Dec 2020 22:46:44 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmOLC-0001da-7r; Mon, 07 Dec 2020 22:46:42 +0100
Date:   Mon, 7 Dec 2020 22:46:41 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sean Young <sean@mess.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201207214641.64xom6njb3mlnhgp@pengutronix.de>
References: <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
 <20201206141941.GA24807@gofer.mess.org>
 <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
 <20201207094320.GA10460@gofer.mess.org>
 <20201207135209.htp7plyotjxp37q2@pengutronix.de>
 <X85KYHVSwIKcBoRe@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ljsvtnk2xcuzdnkj"
Content-Disposition: inline
In-Reply-To: <X85KYHVSwIKcBoRe@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ljsvtnk2xcuzdnkj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Dec 07, 2020 at 04:29:36PM +0100, Thierry Reding wrote:
> On Mon, Dec 07, 2020 at 02:52:09PM +0100, Uwe Kleine-K=F6nig wrote:
> > I asked in the hardware department of the company I work for and they
> > had another usecase: Motors where for example a 1 ms pulse means "move
> > forwards" and 2 ms means "move backwards". They had the same idea as I
> > had: You want to know beforehand the result of a given
> > pwm_apply_state().
>=20
> I've occasionally considered the idea of adding a pwm_check_state() API
> that would allow you to pass in a struct pwm_state and get a result as
> to whether it can be applied or not. It's never really made much sense
> because pwm_apply_state() can already return failure if it can't apply
> the state.
>=20
> However, if we need some way for consumers to be more clever about state
> changes, then something like pwm_check_state() might be more useful if,
> in addition to just checking the validity/applicability of the state we
> can also return the state that would be applied after all the hardware-
> specific rounding.

You describe exactly the function I had in mind when talking about
pwm_round_state. In my eyes pwm_round_state is the better name, because
it makes it obvious that it modifies the passed pwm_state. The clk
framework also has clk_round_rate with similar semantics.

> I'm not sure how useful that really is because it makes the usage really
> difficult on the consumer side. Perhaps there's no need for this anymore
> if the consumer is able to specify the rounding, so perhaps we should
> concentrate on that API first.

Yeah, I think it will not be very useful to be used directly by
consumers in most cases. The driver's callback can however be used in
helper functions provided by the framework. The pwm-ir-tx driver would
then do:

	struct pwm_state state =3D {
		.period =3D carrier_period,
		.duty_cycle =3D 0,
		...
	};

	ret =3D pwm_round_nearest(mypwn, &state);
	if (!ret)
		... error handling

and then inspect state to judge if it is good enough and use that.

> One of the reasons I was reluctant to introduce a "default" rounding
> behaviour is precisely because it's not clear cut, so in some cases the
> default may not be what we really want, such as in the pwm-ir-tx case
> here.

I think we can agree that with consumers having different needs we
should be able to give all of them what they need. Preferably in a way
that lowlevel drivers must do only something simple and the main
complexity lives in common framework code.

> > Given that the bcm2835 driver is quite trivial I would be happy to
> > create a series that "fixes" the driver to round down and provide a
> > prototype for pwm_round_nearest for you to test on pwm-ir-tx. A willing
> > tester and a real use-case were the single two things that stopped me
> > investing time here.
>=20
> I'd like to avoid adding a new function for this functionality and
> instead add a rounding type field to the PWM state. Also, in doing so we
> should be able to keep the status quo for everyone by making the default
> rounding behaviour "don't care", which is what basically everyone right
> now uses. In specific cases like pwm-ir-tx we can adjust the rounding to
> become "nearest".

And you want to adapt all drivers (maybe on a on-demand base) to
implement "round-down", "round-period-to-nearest-but-duty-down" and all
other demands that my come up in the future? Did you notice how
difficult "round-nearest" is even in the simple example with a single
divider in my mail to Sean earlier today? I don't want this in several
drivers. And note this isn't even workable, consider the servo motor
example where a 1ms pulse means move forward and 2ms pulse means move
backwards. In this case you really want to know before applying the
state that the resulting pulses will be longer than (say) 1.8 ms or
shorter than 1.2 ms. And note that adding a "rounding" member to state
doesn't prevent us touching all drivers. If I request a certain state
with round-nearest and the driver is not aware of rounding it might use
round-down and even applies this. Also the PWM driver should not be free
to say "Ohh, the consumer requested 2ms and rounding up, but 1ms is the
best I can do, so that's what they get". So I might drive my vehicle
into a house and won't even notice before something bad happens.

This convinces me that it's impossible to provide the needed features to
consumers without adding a new callback that queries the HW capabilities
without modifying the output.

> That said, the rounding behaviour is not something that the API can
> guarantee, because if we start rejecting "nearest" requests, we might
> end up breaking a bunch of setups that want "nearest" but where the
> controller doesn't support it.

I cannot follow you. Why do you want to reject nearest requests? There
should always be a single state that is nearest to a given request. If
you request a period length of 2 years the actually returned state might
use a considerably shorter period, but there should be no need to reject
this. (It might only be good if this can be noticed before the state
with the shorter period is put into action.)

For round-down some states are impossible, but round-nearest should be
fine.

> At the same time I don't want to make it
> a prerequisite that all drivers implement all possible rounding
> behaviours because it puts a very high burden on the driver writer that
> may not need (or have a way of testing) anything other than "nearest",
> or "round down", or whatever.

That's why I think all drivers should just implement "round down" and
framework logic can implement the necessary logic to still provide
consumers a "round nearest" or any other necessary rounding strategy.

> So I think from an API perspective the rounding behaviour would always
> have to be a sort of "hint" to the driver to specify what the consumer
> wants to use, but it should never fail to apply a state purely on this
> rounding behaviour, so returning some state that's the best the driver
> can do is better than failing if it doesn't know some mode.

I don't agree. If I want my motor to move forward, I don't want the PWM
driver in use be lax enough to result in a backwards move.

> This also ensures that existing drivers will be able to continue to work
> the same way they always have, and the new mechanism is merely something
> to improve the use-cases where we need more precise control.

My thought to go forward is:

- Introduce a new callback "round_state" or "round_down_state" to make
  it more obvious which behaviour is expected.
- For all drivers implementing this callback, enforce that
  .apply(.round_down_state(somestate)) behaves identically to
  .apply(somestate) and that .round_down_state indeed rounds down.
- Implement a pwm_round_nearest_state() function that only works for
  lowlevel drivers implementing .round_down_state. This way it can rely
  on the above item and so can be implemented without too much hassle.

Also all drivers can just stay as they are and as soon as someone
implements the round_down_state callback the driver becomes more useful.
Until this is the case they just continue to work as they do today, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ljsvtnk2xcuzdnkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/Oor4ACgkQwfwUeK3K
7AnWSwf/b9/HDWESUlV8hHpDv7nDC9UwQOOjmbEWVlbNljb5s1p8YU2Oxp75e+x3
Tu/BlbUlBOSZxfU3cb0/iLyAo4qbEU+D/ARKn6jvwMfsgPiYb49DCG9o2BfL9YtQ
q4FFJ6845NRocN0Tpp7w7a/FHQVHbdwBdA0qPvvyVyf4PxoV+DpRyEqXzsX7tpGn
MJazfvarSkD3xpYv82gBWOF+OITEocH4FCWJIq72Fw5AWUqpM1II1c84KR8AZkF0
ky/Cl2KDBvVLDECWkc+wo3VL9oT3vWc5iN42ivkTAcYvtdq0yzZB+5p5OzKKTRj8
iFo0kmIDlqUSIW3uACRS9Tfa1GDZeg==
=6zhQ
-----END PGP SIGNATURE-----

--ljsvtnk2xcuzdnkj--
