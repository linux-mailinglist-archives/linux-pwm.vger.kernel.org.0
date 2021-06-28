Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39613B66F2
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhF1QtU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 12:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhF1QtU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jun 2021 12:49:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212AC061574
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jun 2021 09:46:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxuPL-0000N2-6j; Mon, 28 Jun 2021 18:46:51 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxuPK-0000XT-Ew; Mon, 28 Jun 2021 18:46:50 +0200
Date:   Mon, 28 Jun 2021 18:46:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>, kernel@pengutronix.de,
        linux-tegra@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 5/6] pwm: tegra: Implement .apply callback
Message-ID: <20210628164650.4rnemsvlopy34ss7@pengutronix.de>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
 <20210617095145.163694-6-u.kleine-koenig@pengutronix.de>
 <YNnArzeS/DtIlFa9@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lf2kepb6gbqhkoe6"
Content-Disposition: inline
In-Reply-To: <YNnArzeS/DtIlFa9@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lf2kepb6gbqhkoe6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2021 at 02:29:35PM +0200, Thierry Reding wrote:
> On Thu, Jun 17, 2021 at 11:51:44AM +0200, Uwe Kleine-K=F6nig wrote:
> > To ease review this reuses the formerly implemented callbacks.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-tegra.c | 32 +++++++++++++++++++++++++++++---
> >  1 file changed, 29 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index 11a10b575ace..1161c6323e60 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -227,10 +227,36 @@ static void tegra_pwm_disable(struct pwm_chip *ch=
ip, struct pwm_device *pwm)
> >  	clk_disable_unprepare(pc->clk);
> >  }
> > =20
> > +static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> > +			   const struct pwm_state *state)
> > +{
> > +	int err;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +		return -EINVAL;
>=20
> Where does this come from? I can't see this condition anywhere in the
> existing driver.

The old driver doesn't implement .set_polarity, so this condition
originates from

        if (state->polarity !=3D pwm->state.polarity) {
                if (!chip->ops->set_polarity) {
                        err =3D -EINVAL;
                        goto out_err;
                }
		...

in the legacy code path in the core.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lf2kepb6gbqhkoe6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDZ/PEACgkQwfwUeK3K
7AlOywf/fUJTQa5LlYumhRtl7NjQ6p72PYVRcOtjtMFaOXSfOejmxlzrAdD5vhMF
6LcqQEOKSanrsm2FZ3wRfuKUkTB3eHPxZjn1ao961GomxFMmqXRBmisFMCg46Xfq
Wu4LbdvsCD/4Vqgq/qDA3owfnkKUbJpA+D7vj2qhG74cJZi/KpA1WsdJdA9RoGyh
QJ3NeYd/7snXmCMXOukI4Hd/6hAjB6yeLu+0RcAAyxAcNsqnSQpfBoB+KKaU6mjN
9Bi8NKRnzKwSg87VZU/nEzxxOQN43pFQPEBCYcVwZB0EA2rWgWO9XF58slrhnryz
ZhW8TSyFTafUpiTQJ7AElF8rlRsyAg==
=KeV5
-----END PGP SIGNATURE-----

--lf2kepb6gbqhkoe6--
