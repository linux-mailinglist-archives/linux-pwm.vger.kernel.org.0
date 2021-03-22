Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88A344995
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 16:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCVPr0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCVPrC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 11:47:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EB9C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 08:47:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOMlg-0005Ks-Uc; Mon, 22 Mar 2021 16:47:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOMlg-0005F3-1n; Mon, 22 Mar 2021 16:47:00 +0100
Date:   Mon, 22 Mar 2021 16:46:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v3] pwm: Soften potential loss of precision in compat code
Message-ID: <20210322154659.vwlavhpacfp5rdpw@pengutronix.de>
References: <20210315080050.2337075-1-u.kleine-koenig@pengutronix.de>
 <YFh7uCgeir4L+ZTf@orome.fritz.box>
 <20210322112947.iru2dj3yggkhecwl@pengutronix.de>
 <YFiKY7nrIDj+ZD47@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="atzn3iyi3emehixu"
Content-Disposition: inline
In-Reply-To: <YFiKY7nrIDj+ZD47@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--atzn3iyi3emehixu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 22, 2021 at 01:15:31PM +0100, Thierry Reding wrote:
> On Mon, Mar 22, 2021 at 12:29:47PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 22, 2021 at 12:12:56PM +0100, Thierry Reding wrote:
> > > On Mon, Mar 15, 2021 at 09:00:51AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > The legacy callback .config() only uses int for period and duty_cyc=
le
> > > > while the corresponding values in struct pwm_state are u64. To prev=
ent
> > > > that a value bigger than INT_MAX is discarded to a very small value,
> > > > explicitly check for big values and pass INT_MAX instead of discard=
ing.
> > > >=20
> > > > Acked-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > > Changes since v2 (Message-Id: 20210312212119.1342666-1-u.kleine-koe=
nig@pengutronix.de)
> > > >=20
> > > >  - Fixed indention of comment (noticed by Guru Das)
> > > >  - Add Ack for Guru Das.
> > > >=20
> > > >  drivers/pwm/core.c | 13 +++++++++++--
> > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > index 4b3779d58c5a..b1adf3bb8508 100644
> > > > --- a/drivers/pwm/core.c
> > > > +++ b/drivers/pwm/core.c
> > > > @@ -605,9 +605,18 @@ int pwm_apply_state(struct pwm_device *pwm, co=
nst struct pwm_state *state)
> > > > =20
> > > >  		if (state->period !=3D pwm->state.period ||
> > > >  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> > > > +			int duty_cycle, period;
> > > > +
> > > > +			/*
> > > > +			 * The legacy callbacks use only (signed!) int for
> > > > +			 * period and duty_cycle compared to u64 in struct
> > > > +			 * pwm_state. So clamp the values to INT_MAX.
> > > > +			 */
> > > > +			period =3D min(state->period, (u64)INT_MAX);
> > > > +			duty_cycle =3D min(state->duty_cycle, (u64)INT_MAX);
> > >=20
> > > Do we want to highlight this using a WARN()?
> >=20
> > That would be fine for me, too. In the past you were not happy with
> > WARN I added, so I implemented this in a silent way.
>=20
> The WARN that I remember was in a completely different context. There
> are occasions when it's good to be loud. I think this is one of them.
>=20
> > > It seems to me like doing this would always be a programming error and
> > > easy to fix. Silently truncating this to just INT_MAX may not give the
> > > desired effect and be actively wrong most of the time.
> > >=20
> > > Come to think of it: why not just refuse such requests with -EINVAL?
> > > That's what drivers already do if they're faced with values that they
> > > can't handle.
> >=20
> > No, the strategy I ask authors of new drivers to implement is to program
> > the biggest possible period not bigger than the requested period. So if
> > a consumer requests INT_MAX+3 it must already today cope with the case
> > that it gets a smaller period.
>=20
> That just seems wrong. I mean to a degree this might be sensible, but
> the way you do this here it's completely out of hands. What if somebody
> tries to configure this?

The charm it has is that it is simple and doesn't cut somewhere
arbitrary.

> 	duty-cycle: 0x0000000100000000
> 	period:     0x0000000200000000
>=20
> Clearly what they were aiming for is a 50% duty-cycle, but with your
> proposal, this will now result in a 100% duty-cycle, which is cleary not
> what's requested here.

OK, can you please formally describe how a hardware driver author should
detect these clear aims? Some document that for any given request and
any given hardware capability tells what setting to pick would be great.

Assume that the longest 50% setting some driver can implement is
duty_cycle =3D 0x7fffffff ns + period =3D 0xfffffffe ns. What is the biggest
duty_cycle + period where you want 0x7fffffff + 0xfffffffe to be
configured?

I expect that anything that targets to be practically better than my
approach is damned to be complicated, arbitrary and still doesn't catch
all clear aims. Still more because "clear aims" is something that is
subjective to each developer. And assume you really produce a recipe
that clearly dissects between "round a little bit" and "clearly not what
was requested", do you really want to implement that in each and every
low level driver? I don't, this would be a maintenance mess.

So that's why I think we need pwm_round_state with *easy* rules.

And given that this easy (and admittedly practically imperfect) rule
was "Use the biggest possible period not bigger than requested" and I
still consider this a good choice, clamping instead of returning an
error is still the right choice in my eyes.

> That's different, in my opinion, from a case where you may have to round
> a little bit and get a deviation of, say, 1% in the resulting signal.

Let's assume "1% deviation is ok" is to become the golden rule. If
the nearest possibility to satisfy the request

	.duty_cycle =3D 1000 ns
	.period =3D 2000 ns

was

	.duty_cycle =3D 1010 ns
	.period =3D 1980 ns

would this be within the 1% rule or wouldn't it? (The relative duty
cycle is > 51% and so it's off by > 2%, but the individual values differ
by just 1%.) Or should we prefer

	.duty_cycle =3D 1010 ns
	.period =3D 2030 ns

where the period is off by more than 1% but the relative duty_cycle is
actually nearer to the "clearly requested" 50%?

> > The underlaying problem can only be solved with a way to query the
> > resulting configuration for a given request. I have a prototype I can
> > share if you're interested.
>=20
> I don't think we need to go all the way for this legacy code. But I
> think we need to make sure that people get a result that is reasonably
> within what they asked for. And I think just flat out rejecting these
> kinds of requests that are completely out of bounds of the hardware is
> better than silently clamping the values. I'd be surprised if this even
> had an impact at all on any existing drivers because it had, the
> truncation that's currently happening would've likely already exposed
> any of them.
>=20
> Also, in most of these cases the period has been hand-picked and is part
> of device tree (or some legacy PWM lookup table), and it was picked
> because it is supported by the hardware. Since the duty-cycle always has
> to be smaller than the period (we actively reject configurations if that
> is not the case), I don't think it likely that we'd currently hit these
> conditions at all.

Does "I don't think we need to go all the way for this legacy code." and
"the period has been hand-picked" mean we shouldn't care at all about
legacy code and just assume nothing bad will happen until eventually all
legacy drivers are gone?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--atzn3iyi3emehixu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYu/AACgkQwfwUeK3K
7AmhEQf+PQlWTfGrnFQ3CRO8S9P2EGeScODL/MDMyv+UoaVKAojKBSF8k0H6mRAc
hqs/lEpaqYNSAttsUNpkamLiUnjeUp3a8/Z5OiGfX+FtTXvEkpbGSqB/AS1TsVZ/
0fJBqAb+KcgbkPeCeCw1/r+q4bSYyrdAc+1N3eOHM1copQ6rhlIxdmmfqkVOwUw/
GjU3GkK2GEzgXQp6pF0NFaKDSwPsQo5BT7CwxGygvFAaXi2ryPmJVJDpP/ne/ezv
1Wz7Tuiu5Ii6D1FlVdY8JJrNjWBpdGyAs+pV92tvtCbZ6AKwPchWBJ80fZczITXn
91g9cOI9cPLWY2NWU00d7iCzv3CgNQ==
=Hd0u
-----END PGP SIGNATURE-----

--atzn3iyi3emehixu--
