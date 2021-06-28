Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F233B66A9
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhF1Q0h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhF1Q0g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jun 2021 12:26:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6500C061574
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jun 2021 09:24:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxu3N-0006TZ-5k; Mon, 28 Jun 2021 18:24:09 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxu3L-00088p-V1; Mon, 28 Jun 2021 18:24:07 +0200
Date:   Mon, 28 Jun 2021 18:24:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
 <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
 <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
 <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
 <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
 <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxlp6tyzyeaflos4"
Content-Disposition: inline
In-Reply-To: <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mxlp6tyzyeaflos4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
> On 6/27/21 2:19 PM, Uwe Kleine-K=F6nig wrote:
> > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
> > > So for the moment, why not give an error? This will be legal code both
> > > now and after round_state is implemented.
> >=20
> > The problem is where to draw the line. To stay with your example: If a
> > request for period =3D 150 ns comes in, and let X be the biggest period=
 <=3D
> > 150 ns that the hardware can configure. For which values of X should an
> > error be returned and for which values the setting should be
> > implemented.
> >=20
> > In my eyes the only sensible thing to implement here is to tell the
> > consumer about X and let it decide if it's good enough. If you have a
> > better idea let me hear about it.
>=20
> Sure. And I think it's ok to tell the consumer that X is the best we can
> do. But if they go along and request an unconfigurable state anyway, we
> should tell them as much.

I have the impression you didn't understand where I see the problem. If
you request 150 ns and the controller can only do 149 ns (or 149.6667 ns)
should we refuse? If yes: This is very unusable, e.g. the led-pwm driver
expects that it can configure the duty_cycle in 1/256 steps of the
period, and then maybe only steps 27 and 213 of the 256 possible steps
work. (This example doesn't really match because the led-pwm driver
varies duty_cycle and not period, but the principle becomes clear I
assume.) If no: Should we accept 151 ns? Isn't that ridiculous?

> IMO, this is the best way to prevent surprising results in the API.

I think it's not possible in practise to refuse "near" misses and every
definition of "near" is in some case ridiculous. Also if you consider
the pwm_round_state() case you don't want to refuse any request to tell
as much as possible about your controller's capabilities. And then it's
straight forward to let apply behave in the same way to keep complexity
low.

> The real issue here is that it is impossible to determine the correct
> way to round the PWM a priori, and in particular, without considering
> both duty_cycle and period. If a consumer requests very small
> period/duty cycle which we cannot produce, how should it be rounded?

Yeah, because there is no obviously right one, I picked one that is as
wrong as the other possibilities but is easy to work with.

> Should we just set TLR0=3D1 and TLR1=3D0 to give them 66% duty cycle with
> the least period? Or should we try and increase the period to better
> approximate the % duty cycle? And both of these decisions must be made
> knowing both parameters. We cannot (for example) just always round up,
> since we may produce a configuration with TLR0 =3D=3D TLR1, which would
> produce 0% duty cycle instead of whatever was requested. Rounding rate
> will introduce significant complexity into the driver. Most of the time
> if a consumer requests an invalid rate, it is due to misconfiguration
> which is best solved by fixing the configuration.

In the first step pick the biggest period not bigger than the requested
and then pick the biggest duty cycle that is not bigger than the
requested and that can be set with the just picked period. That is the
behaviour that all new drivers should do. This is somewhat arbitrary but
after quite some thought the most sensible in my eyes.

> > > Perhaps I should add
> > >=20
> > > 	if (tlr0 <=3D tlr1)
> > > 		return -EINVAL;
> > >=20
> > > here to prevent accidentally getting 0% duty cycle.
> >=20
> > You can assume that duty_cycle <=3D period when .apply is called.
>=20
> Ok, I will only check for =3D=3D then.

You just have to pay attention to the case that you had to decrement
=2Eperiod to the next possible value. Then .duty_cycle might be bigger
than the corrected period.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mxlp6tyzyeaflos4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDZ96QACgkQwfwUeK3K
7AlJXgf7BKBFOIdY64LBcokhYBcDKmKMqIXrY1FhK8oF+FxlLdyQ89SrYSXpI29t
DagR8JwKJZn6eigEOVD8b1q+0oB4Rrou9g6Q3CkfF5OMLBcxXCXqne1nAOY1lpD2
AXzJjkfCHPNIcH6Cr3ESFhaGGdDzpb4KyxmYOjbrdxlbxlAr8HjgK8e2hbjAW31V
m6jzcwWcE/Rru6TklnULd0pkGt4+hEbFTKuwsxoUVMQr10dT7ZN+5zSD9G4nOejc
H6Zw8jdqSLsQ+DdI05+iADMUd7oVUnfYkMkCnJq8l7EYtrU35p+HDJNvJ0Djy19/
JYMrzGjxkiegkRdQubUWtuMHlDQwOQ==
=srzj
-----END PGP SIGNATURE-----

--mxlp6tyzyeaflos4--
