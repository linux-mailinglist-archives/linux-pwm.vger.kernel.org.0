Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495D5343FBF
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVLaE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCVL3u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:29:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C79C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:29:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOIkm-0006kQ-Nz; Mon, 22 Mar 2021 12:29:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOIkm-0000l8-13; Mon, 22 Mar 2021 12:29:48 +0100
Date:   Mon, 22 Mar 2021 12:29:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v3] pwm: Soften potential loss of precision in compat code
Message-ID: <20210322112947.iru2dj3yggkhecwl@pengutronix.de>
References: <20210315080050.2337075-1-u.kleine-koenig@pengutronix.de>
 <YFh7uCgeir4L+ZTf@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fiiybnxlcpj5sciu"
Content-Disposition: inline
In-Reply-To: <YFh7uCgeir4L+ZTf@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fiiybnxlcpj5sciu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 12:12:56PM +0100, Thierry Reding wrote:
> On Mon, Mar 15, 2021 at 09:00:51AM +0100, Uwe Kleine-K=F6nig wrote:
> > The legacy callback .config() only uses int for period and duty_cycle
> > while the corresponding values in struct pwm_state are u64. To prevent
> > that a value bigger than INT_MAX is discarded to a very small value,
> > explicitly check for big values and pass INT_MAX instead of discarding.
> >=20
> > Acked-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v2 (Message-Id: 20210312212119.1342666-1-u.kleine-koenig@=
pengutronix.de)
> >=20
> >  - Fixed indention of comment (noticed by Guru Das)
> >  - Add Ack for Guru Das.
> >=20
> >  drivers/pwm/core.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 4b3779d58c5a..b1adf3bb8508 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -605,9 +605,18 @@ int pwm_apply_state(struct pwm_device *pwm, const =
struct pwm_state *state)
> > =20
> >  		if (state->period !=3D pwm->state.period ||
> >  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> > +			int duty_cycle, period;
> > +
> > +			/*
> > +			 * The legacy callbacks use only (signed!) int for
> > +			 * period and duty_cycle compared to u64 in struct
> > +			 * pwm_state. So clamp the values to INT_MAX.
> > +			 */
> > +			period =3D min(state->period, (u64)INT_MAX);
> > +			duty_cycle =3D min(state->duty_cycle, (u64)INT_MAX);
>=20
> Do we want to highlight this using a WARN()?

That would be fine for me, too. In the past you were not happy with
WARN I added, so I implemented this in a silent way.

> It seems to me like doing this would always be a programming error and
> easy to fix. Silently truncating this to just INT_MAX may not give the
> desired effect and be actively wrong most of the time.
>=20
> Come to think of it: why not just refuse such requests with -EINVAL?
> That's what drivers already do if they're faced with values that they
> can't handle.

No, the strategy I ask authors of new drivers to implement is to program
the biggest possible period not bigger than the requested period. So if
a consumer requests INT_MAX+3 it must already today cope with the case
that it gets a smaller period.

The underlaying problem can only be solved with a way to query the
resulting configuration for a given request. I have a prototype I can
share if you're interested.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fiiybnxlcpj5sciu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYf6gACgkQwfwUeK3K
7AmKjggAnf9qSq784zng2a5E+I+Blpi3VTq4ua0k/grM+xiqj4OrhsIJJOZdmrYl
MQRTuw7JsbtsiDuK1nZAxDGOUTtHWwaUklEQSKGPBHh3qA1pcHtidqef3JSpWl0v
NTRDhrKtG3KQLIjtmk0wMjUnZHHv+6qYXriYJC5aGPDKrJh1H3RHggzm/PlTgODh
AWmH9w4GpIvSgBnZD1WRuA5X7IpcRu55u7DdhgyCVgjrSbbVcbAfboPUtcEfOrId
E7ZK41iZBB6pjiR8oO9iEoCUGoI24vA4/3IBiZmvpZaJ/dWatGJmBBVMF8y5d/dz
2P5Biw8G/4Ssb8nTsNnHjvw/tYRfUA==
=c2id
-----END PGP SIGNATURE-----

--fiiybnxlcpj5sciu--
