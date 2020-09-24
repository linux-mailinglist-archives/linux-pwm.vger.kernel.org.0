Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367C92773C1
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgIXORO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXORG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Sep 2020 10:17:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC37C0613CE
        for <linux-pwm@vger.kernel.org>; Thu, 24 Sep 2020 07:17:05 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kLS3Q-0004vB-CR; Thu, 24 Sep 2020 16:17:00 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kLS3P-0002us-8b; Thu, 24 Sep 2020 16:16:59 +0200
Date:   Thu, 24 Sep 2020 16:16:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com, rtanwar@maxlinear.com
Subject: Re: [PATCH v13 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200924141659.4wov7w2l2bllpre4@pengutronix.de>
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
 <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
 <20200924065534.e2anwghhtysv63e7@pengutronix.de>
 <20200924132334.GT3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mb7bv4ys4jbc3fg3"
Content-Disposition: inline
In-Reply-To: <20200924132334.GT3956970@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mb7bv4ys4jbc3fg3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:23:34PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 24, 2020 at 08:55:34AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 15, 2020 at 04:23:37PM +0800, Rahul Tanwar wrote:
>=20
> ...
>=20
> > > +	ret =3D lgm_clk_enable(dev, pc);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable clock\n");
> >=20
> > You used dev_err_probe four times for six error paths. I wonder why you
> > didn't use it here (and below for a failing pwmchip_add()).
>=20
> dev_err_probe() makes sense when we might experience deferred probe. In n=
either
> of mentioned function this can be the case.
>=20
> > > +		return ret;
> > > +	}
>=20
> ...
>=20
> > > +	ret =3D lgm_reset_control_deassert(dev, pc);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
> >=20
> > After lgm_reset_control_deassert is called pc->rst is unused. So there
> > is no need to have this member in struct lgm_pwm_chip. The same applies
> > to ->clk. (You have to pass rst (or clk) to devm_add_action_or_reset for
> > that to work. Looks like a nice idea anyhow.)
>=20
> True. And above dev_err_probe() is not needed.

You argue that dev_err_probe() gives no benefit as
lgm_reset_control_deassert won't return -EPROBE_DEFER, right?

Still I consider it a useful function because

 a) I (as an author or as a reviewer) don't need to think if the
    failing function might return -EPROBE_DEFER now or in the future.
    dev_err_probe does the right thing even for functions that don't
    return -EPROBE_DEFER.

 b) With dev_err_probe() I can accomplish things in a single line that
    need two lines when open coding it.

 c) dev_err_probe() emits the symbolic error name without having to
    resort to %pe + ERR_PTR.

 d) Using dev_err_probe() for all error paths gives a consistency that I
    like with a maintainer's hat on.

So I still want to request using dev_err_probe() in all error paths.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mb7bv4ys4jbc3fg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9sqlgACgkQwfwUeK3K
7AkrswgAgys4+V3gT2KS+en571E0eZ2IJRK+pU1FnbGgCi4mTfhzKCPkQqV5Aiik
exkINzwVonHyvDfS6r1mFSJAOQNBu7Fwi0grOw16ztYP9YB3GolG6hPDRRt+frEq
va8ssmYie4r6ycJaTkyvCk7hYZhu/My2IVntc4YNwUPMxIMNkYtScCQNu+FHYe04
MVd4TmSmeWk5LYzQ/xYoSPZAUfYXEGKN6nBMM5MeGrQpaB2hddRsnSy8aE1sJ7ZS
jGMvIGLCBYtW3whGQoGzp/4O3a2zBdbMVj8VzINCf4Mj4/w5sGvdQ18kBCGs8kqQ
GjJqfyxrbHAGJoO1K7MYp+9qnAQYtA==
=D4Q0
-----END PGP SIGNATURE-----

--mb7bv4ys4jbc3fg3--
