Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE635B269
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Apr 2021 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhDKIWo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKIWo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 04:22:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E70C061574
        for <linux-pwm@vger.kernel.org>; Sun, 11 Apr 2021 01:22:27 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVVMP-0000W7-CT; Sun, 11 Apr 2021 10:22:25 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVVMO-0002Qy-Pk; Sun, 11 Apr 2021 10:22:24 +0200
Date:   Sun, 11 Apr 2021 10:22:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Prevent a glitch in compat code
Message-ID: <20210411082216.jlrhzgo2or4s3gyd@pengutronix.de>
References: <20210308093600.25455-1-u.kleine-koenig@pengutronix.de>
 <YFh47dFLmWqZHvz7@orome.fritz.box>
 <20210322111131.w2c6lj6m2vw7socw@pengutronix.de>
 <20210410214642.nh2c4jhxbcqd7jxt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jnvqyy4sejfvozh"
Content-Disposition: inline
In-Reply-To: <20210410214642.nh2c4jhxbcqd7jxt@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4jnvqyy4sejfvozh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 10, 2021 at 11:46:42PM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Mar 22, 2021 at 12:11:31PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 22, 2021 at 12:01:01PM +0100, Thierry Reding wrote:
> > > On Mon, Mar 08, 2021 at 10:36:00AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > When a PWM is to be disabled, configuring the duty cycle and
> > > > period before actually disabling the hardware might result in eithe=
r a
> > > > glitch or a delay. So check for disabling first and return early in=
 this
> > > > case.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/pwm/core.c | 20 +++++++++++---------
> > > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > index 4058d3c86a45..4604ca3e0e62 100644
> > > > --- a/drivers/pwm/core.c
> > > > +++ b/drivers/pwm/core.c
> > > > @@ -597,6 +597,12 @@ int pwm_apply_state(struct pwm_device *pwm, co=
nst struct pwm_state *state)
> > > >  			pwm->state.polarity =3D state->polarity;
> > > >  		}
> > > > =20
> > > > +		if (!state->enabled && pwm->state.enabled) {
> > > > +			chip->ops->disable(chip, pwm);
> > > > +			pwm->state.enabled =3D false;
> > > > +			return 0;
> > >=20
> > > I don't think we can return early here because otherwise if consumers
> > > happen to modify the period along with the enabled state, the changes
> > > to the period will get lost.
> >=20
> > This however doesn't matter, because the output of a disabled PWM only
> > depends on polarity. (And polarity is already cared for.)
> >=20
> > And if a driver calls pwm_enable() afterwards (or the equivalent in
> > terms of pwm_apply_state) the period and duty_cycle will be picked up
> > correctly.
>=20
> I see you marked my patch as "changes requested" in patchwork. However
> I'm convinced your feedback is wrong and so I still think the patch
> is safe to be applied unmodified.

After sleeping about this I understood you're right. I will rework the
patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4jnvqyy4sejfvozh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBysbQACgkQwfwUeK3K
7Am6tQf/WIbBvuhLkR6Tr9CJY7QeuHr6QFPZT4+IV3+Ely7jbWiACRjRA+IohLuK
r/P/2a9gw6UfPtLROQy60CKwNSdi2XqVhJ9jsB+ygFgDK5hYSXAVTzfsuCj+JoEW
Lt6iFTZU8U+UAodLDpkK2W2PJhO1UPep/ZnSYZdaAdlf7+Uq/pW3PoFUPCIvnLVo
E6CXoBTOG3URfEAv+GQTJlPQfaVKdlXwB6/EXAQ4wrxf+tUWC+pDvCkxSSEhOzIi
aSbK+PoAjsmtIhgwJnako6P1IjTg+OKmY5gL52ZpsjrCMD3YqcIrDbQyRPyaTAcH
QjB/sLX/5H0XxVF88qqQ+hU2ohtbyQ==
=Slb/
-----END PGP SIGNATURE-----

--4jnvqyy4sejfvozh--
