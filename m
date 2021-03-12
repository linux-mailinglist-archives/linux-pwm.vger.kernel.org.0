Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2724F33866B
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 08:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCLHMz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 02:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhCLHMi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Mar 2021 02:12:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0608C061574
        for <linux-pwm@vger.kernel.org>; Thu, 11 Mar 2021 23:12:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKbyM-0005HX-Ow; Fri, 12 Mar 2021 08:12:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKbyL-0007BE-MK; Fri, 12 Mar 2021 08:12:33 +0100
Date:   Fri, 12 Mar 2021 08:12:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: soften potential loss of precision in compat code
Message-ID: <20210312071233.wgd2fkeznh7xjv7y@pengutronix.de>
References: <20210308092322.24502-1-u.kleine-koenig@pengutronix.de>
 <20210311210639.GA29363@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r52cuu7xyraiw6yq"
Content-Disposition: inline
In-Reply-To: <20210311210639.GA29363@codeaurora.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--r52cuu7xyraiw6yq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 11, 2021 at 01:06:39PM -0800, Guru Das Srinagesh wrote:
> On Mon, Mar 08, 2021 at 10:23:22AM +0100, Uwe Kleine-K=F6nig wrote:
> >  		if (state->period !=3D pwm->state.period ||
> >  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> > +			int duty_cycle, period;
> > +
> > +			if (state->period < INT_MAX)
> > +				period =3D state->period;
> > +			else
> > +				period =3D INT_MAX;
>=20
> Using a MIN() macro here might improve readability:
> 	period =3D MIN(state->period, INT_MAX);

Which MIN macro. There are 17 defined in the kernel and none of them in
a header that could be sensibly included by this code.

There are some helpers in <linux/minmax.h> which would result in:

	period =3D min_t(u64, state->period, INT_MAX)

or

	period =3D min(state->period, (u64)INT_MAX);

=2E I don't feel strong here, my initial variant needs more vertical space
but might be a tad easier to understand. In retrospect I'd say that
adding a comment would be more imporant than how to actually calculate
the value, something like:

	/*
	 * The legacy callbacks use only (signed!) int for period and
	 * duty_cycle compared to u64 in struct pwm_state. So clamp the
	 * values to INT_MAX.
	 */

Sounds sensible?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r52cuu7xyraiw6yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBLFF4ACgkQwfwUeK3K
7Ak1oQf+PKsIDxlY+c0NpWKm9fU8tIgQ2MFVBHEhgtCFYLwgUO1bVOkSKMSMITqk
VehSutAEDzj7DEoD2jG5DN+IMrkC5UATI8PSQBr4zBB8HVw/I8OA46ejqZvGg/Mb
5F0io0he8Ym8kWG0PRcgybla3JGnyN0QwkkbXaW68UN0iE65HS2j7lC/QObun9In
LRRU22elqUuXX5ZOfMTphmhJyEDXWmhv1d5kdXAdOL7sTZooEoVaMbvoqhGM/14Q
bijHe3ZCM3HANBaf8hs4C7kCu9ZpVxfJWXdquYkJJTKZaMmbqN0jIkY+gdIez+3X
eJ/0OvExVHLb/abzD3nlwVSkIw1jRA==
=Q5R9
-----END PGP SIGNATURE-----

--r52cuu7xyraiw6yq--
