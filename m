Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10163B6789
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhF1RWx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhF1RWx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jun 2021 13:22:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E0C061574
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jun 2021 10:20:27 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxuvo-0003qf-P5; Mon, 28 Jun 2021 19:20:24 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxuvl-00032M-UA; Mon, 28 Jun 2021 19:20:21 +0200
Date:   Mon, 28 Jun 2021 19:20:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
 <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
 <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
 <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
 <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
 <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
 <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="su54eesto2tmxgqt"
Content-Disposition: inline
In-Reply-To: <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--su54eesto2tmxgqt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
> On 6/28/21 12:24 PM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
> > > On 6/27/21 2:19 PM, Uwe Kleine-K=F6nig wrote:
> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
> > > > > So for the moment, why not give an error? This will be legal code=
 both
> > > > > now and after round_state is implemented.
> > > >
> > > > The problem is where to draw the line. To stay with your example: I=
f a
> > > > request for period =3D 150 ns comes in, and let X be the biggest pe=
riod <=3D
> > > > 150 ns that the hardware can configure. For which values of X shoul=
d an
> > > > error be returned and for which values the setting should be
> > > > implemented.
> > > >
> > > > In my eyes the only sensible thing to implement here is to tell the
> > > > consumer about X and let it decide if it's good enough. If you have=
 a
> > > > better idea let me hear about it.
> > >=20
> > > Sure. And I think it's ok to tell the consumer that X is the best we =
can
> > > do. But if they go along and request an unconfigurable state anyway, =
we
> > > should tell them as much.
> >=20
> > I have the impression you didn't understand where I see the problem. If
> > you request 150 ns and the controller can only do 149 ns (or 149.6667 n=
s)
> > should we refuse? If yes: This is very unusable, e.g. the led-pwm driver
> > expects that it can configure the duty_cycle in 1/256 steps of the
> > period, and then maybe only steps 27 and 213 of the 256 possible steps
> > work. (This example doesn't really match because the led-pwm driver
> > varies duty_cycle and not period, but the principle becomes clear I
> > assume.) If no: Should we accept 151 ns? Isn't that ridiculous?
>=20
> I am fine with this sort of rounding. The part I take issue with is when
> the consumer requests (e.g.) a 10ns period, but the best we can do is
> 20ns. Or at the other end if they request a 4s period but the best we
> can do is 2s. Here, there is no obvious way to round it, so I think we
> should just say "come back with a reasonable period" and let whoever
> wrote the device tree pick a better period.

Note that giving ridiculus examples is easy, but this doesn't help to
actually implement something sensible. Please tell us for your example
where the driver can only implement 20 ns what is the smallest requested
period the driver should accept.

> > > IMO, this is the best way to prevent surprising results in the API.
> >=20
> > I think it's not possible in practise to refuse "near" misses and every
> > definition of "near" is in some case ridiculous. Also if you consider
> > the pwm_round_state() case you don't want to refuse any request to tell
> > as much as possible about your controller's capabilities. And then it's
> > straight forward to let apply behave in the same way to keep complexity
> > low.
> >=20
> > > The real issue here is that it is impossible to determine the correct
> > > way to round the PWM a priori, and in particular, without considering
> > > both duty_cycle and period. If a consumer requests very small
> > > period/duty cycle which we cannot produce, how should it be rounded?
> >=20
> > Yeah, because there is no obviously right one, I picked one that is as
> > wrong as the other possibilities but is easy to work with.
> >=20
> > > Should we just set TLR0=3D1 and TLR1=3D0 to give them 66% duty cycle =
with
> > > the least period? Or should we try and increase the period to better
> > > approximate the % duty cycle? And both of these decisions must be made
> > > knowing both parameters. We cannot (for example) just always round up,
> > > since we may produce a configuration with TLR0 =3D=3D TLR1, which wou=
ld
> > > produce 0% duty cycle instead of whatever was requested. Rounding rate
> > > will introduce significant complexity into the driver. Most of the ti=
me
> > > if a consumer requests an invalid rate, it is due to misconfiguration
> > > which is best solved by fixing the configuration.
> >=20
> > In the first step pick the biggest period not bigger than the requested
> > and then pick the biggest duty cycle that is not bigger than the
> > requested and that can be set with the just picked period. That is the
> > behaviour that all new drivers should do. This is somewhat arbitrary but
> > after quite some thought the most sensible in my eyes.
>=20
> And if there are no periods smaller than the requested period?

Then return -ERANGE.

> Any way you slice it, there will be situations where there is nothing
> reasonable to do other than return an error.

ack.

> > > > > Perhaps I should add
> > > > >
> > > > > 	if (tlr0 <=3D tlr1)
> > > > > 		return -EINVAL;
> > > > >
> > > > > here to prevent accidentally getting 0% duty cycle.
> > > >
> > > > You can assume that duty_cycle <=3D period when .apply is called.
> > >=20
> > > Ok, I will only check for =3D=3D then.
> >=20
> > You just have to pay attention to the case that you had to decrement
> > .period to the next possible value. Then .duty_cycle might be bigger
> > than the corrected period.
>=20
> This is specifically to prevent 100% duty cycle from turning into 0%. My
> current draft is
>=20
> 	/*
> 	 * If TLR0 =3D=3D TLR1, then we will produce 0% duty cycle instead of 10=
0%
> 	 * duty cycle. Try and reduce the high time to compensate. If we can't
> 	 * do that because the high time is already 0 cycles, then just error
> 	 * out.
> 	 */
> 	if (tlr0 =3D=3D tlr1 && !tlr1--)
> 		return -EINVAL;

If you follow my suggested policy this isn't an error and you should
yield the biggest duty_cycle here even if it is zero.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--su54eesto2tmxgqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDaBMwACgkQwfwUeK3K
7Al5wgf/fe3w8YJA5nohjWPVBc2aZToeUCAzgjFtIOccEueW2H5A0hkAYk0XmsrS
MzaUxLKn6qj7gIvQzgNNQT3VOrIUc96DHOd2ezwMi7o4sx1UQHAEZWSDHBJu4bwr
lkgRY86mgbzEdF6dvKdo03nyGG2yvrxMxv64MPuigt1GZiE6Pg2faRf/8puiVFXt
/R8o59T9hk638INhjcDI8mNtKDBHTu4AYh1Eo2zcdjZVTSBkBaZbOBnSdPBe9jlY
M1GeBBT0pzpBdbM8GI6bsW9HIEzIagLQwRrRFxwEnV1n9uwExYkyrBycL5djbP+J
kObI3VVk0pSVfLr2YOUfZ/z6ZL2xrQ==
=cNHw
-----END PGP SIGNATURE-----

--su54eesto2tmxgqt--
