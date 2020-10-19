Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DFD2922A3
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Oct 2020 08:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgJSGqY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Oct 2020 02:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgJSGqY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Oct 2020 02:46:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70DC061755
        for <linux-pwm@vger.kernel.org>; Sun, 18 Oct 2020 23:46:24 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUOw2-0005Rp-8I; Mon, 19 Oct 2020 08:46:22 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUOw1-0001v7-Ft; Mon, 19 Oct 2020 08:46:21 +0200
Date:   Mon, 19 Oct 2020 08:46:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201019064621.swtdoooluaw4qa5k@pengutronix.de>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
 <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
 <20201016092127.GF4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6yobwbdhsk5e6ju"
Content-Disposition: inline
In-Reply-To: <20201016092127.GF4077@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--t6yobwbdhsk5e6ju
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 12:21:27PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 16, 2020 at 03:18:08AM +0000, Ayyathurai, Vijayakannan wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
> > Sent: Thursday, 15 October, 2020 4:12 PM
> > On Thu, Oct 15, 2020 at 03:36:09AM +0800, vijayakannan.ayyathurai@intel=
=2Ecom wrote:
> > > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> ...
>=20
> > > +	priv->clk =3D devm_clk_get(dev, NULL);
> > > +	if (IS_ERR(priv->clk))
> > > +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get=20
> > > +clock\n");
> > > +
> > > +	ret =3D clk_prepare_enable(priv->clk);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(priv->base)) {
> >=20
> > > +		clk_disable_unprepare(priv->clk);
> >=20
> > See below.
> >=20
> > > +		return PTR_ERR(priv->base);
> > > +	}
> > > +
> > > +	priv->chip.base =3D -1;
> > > +	priv->chip.dev =3D dev;
> > > +	priv->chip.ops =3D &keembay_pwm_ops;
> > > +	priv->chip.npwm =3D KMB_TOTAL_PWM_CHANNELS;
> > > +
> > > +	ret =3D pwmchip_add(&priv->chip);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
> >=20
> > > +		clk_disable_unprepare(priv->clk);
> >=20
> > This messes up with ordering of things.
> >=20
> > That's why devm golden rule is either all or none. You may fix this by =
switching to devm_add_action_or_reset().
> >=20
> > One of possible way is like in below drivers:
> >=20
> > 	% git grep -n devm_add_action_or_reset.*disable_unprepare -- drivers/
> >=20
> > But it may be fixed in follow up change. Depends on maintainers' wishes.
> >=20
> > Sure. I shall incorporate and check based on maintainers wish in the ne=
xt version.
> >=20
> > > +		return ret;
> > > +	}
> > > +
> > > +	platform_set_drvdata(pdev, priv);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int keembay_pwm_remove(struct platform_device *pdev) {
> > > +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> > > +	int ret;
> > > +
> > > +	ret =3D pwmchip_remove(&priv->chip);
> > > +	clk_disable_unprepare(priv->clk);
> > > +
> > > +	return ret;
> >=20
> > ...and this will be simplified to
> >=20
> > 	return pwmchip_remove(&priv->chip);
> >=20
> > Until v10, It is as per your suggestion. But I have changed it in v11 t=
o overcome the issue mentioned by Uwe. I have kept the snip of v10 FYR belo=
w.
> >=20
> > //Start snip from v10 review mailing list
> > //> +static int keembay_pwm_remove(struct platform_device *pdev) {
> > //> +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> > //> +
> > //> +	clk_disable_unprepare(priv->clk);
> > //> +
> > //> +	return pwmchip_remove(&priv->chip);
> > //
> > //You have to call pwmchip_remove first. Otherwise you're stopping the =
PWM while the framework still believes everything to be fine.
> > //
> > //> +}
> > //End snip from v10 review mailing review
> >=20
> > > +}
>=20
> What I said does not contradict with what Uwe said. So, please, fix order=
ing
> either by dropping devm_ in the middle or adding devm_ action.
>=20
> Now you moved serious ordering issue in ->remove() (which Uwe noted) to l=
ess
> serious in ->probe(). But issue is still present.

The easiest way is probably to do the clk_prepare_enable() only after
all devm_ stuff in .probe. (But I'm not emphatic about that, it would be
fine for me to wait until devm_clk_get_enabled() lands.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t6yobwbdhsk5e6ju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+NNjoACgkQwfwUeK3K
7AkL6gf/ernPYCFp/asgM7CNMvDlRLGGZy9z/a2JYDH1nKep9edRHnNCsR4ROY/U
Bc5McTHrtImMRVntPuCq+eVD74wtLlqF15u/bc5f8q6iorOIPvsw1mrc3QVTasku
UvxAwZffBrU3QKer35FFGoJ5xwSzlWSdu0Br7a+Hq0ziiKSquJ16R/kJMvC+Li40
JNcrVu5eaKilRbiDpAjGlVNja5xYGWi7LdFZJ5R5cb5rJg0luF4dv0Ezjuy/Tgt6
f/c23l5hQ8Sw7hQIFtc/vJfNT3JaCiaxFdJM94idX4hI0F9XtlAYIpCbD0GeqQIm
RWY/cHHFomL4Fa0CtynSJar8UI+yCA==
=XTNH
-----END PGP SIGNATURE-----

--t6yobwbdhsk5e6ju--
