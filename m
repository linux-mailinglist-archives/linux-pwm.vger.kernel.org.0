Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6D28FF2F
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404665AbgJPHe3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404664AbgJPHe2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Oct 2020 03:34:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB2C061755
        for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2020 00:34:28 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kTKFu-0006Gf-QO; Fri, 16 Oct 2020 09:34:26 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kTKFu-0004sy-8k; Fri, 16 Oct 2020 09:34:26 +0200
Date:   Fri, 16 Oct 2020 09:34:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20201016073426.vyjehbkyn3sxn7d5@pengutronix.de>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
 <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s3e632f7peb5icpv"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s3e632f7peb5icpv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ayyathurai,

Can you please fix your MUA to properly quote when replying, this is
really annoying.

On Fri, Oct 16, 2020 at 03:18:08AM +0000, Ayyathurai, Vijayakannan wrote:
> > On Thu, Oct 15, 2020 at 03:36:09AM +0800, vijayakannan.ayyathurai@intel=
=2Ecom wrote:
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
>
> Until v10, It is as per your suggestion. But I have changed it in v11
> to overcome the issue mentioned by Uwe. I have kept the snip of v10
> FYR below.
>=20
> //Start snip from v10 review mailing list
> //> +static int keembay_pwm_remove(struct platform_device *pdev) {
> //> +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> //> +
> //> +	clk_disable_unprepare(priv->clk);
> //> +
> //> +	return pwmchip_remove(&priv->chip);
> //
> //You have to call pwmchip_remove first. Otherwise you're stopping the PW=
M while the framework still believes everything to be fine.
> //
> //> +}
> //End snip from v10 review mailing review

Note that we're both (Andy and I) are right. You must not disable the
clocks before pwmchip_remove() (otherwise for a short time the PWM looks
ready but isn't). And if you use devm-stuff to enable the clock it will
be disabled only after the remove callback completed and your .remove
may look like:

	static int keembay_pwm_remove(struct platform_device *pdev)
	{
		struct keembay_pwm *priv =3D platform_get_drvdata(pdev);

		return pwmchip_remove(&priv->chip);
	}

because you won't have to care for the clock explicitly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s3e632f7peb5icpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+JTP8ACgkQwfwUeK3K
7An1Fgf/b2bq68yJEXElIdOAqbvuMPT9ZRnrewxfZ6WTx3SUUSfa04D5+6G9Qedm
yXm9T2uN8xb+mkA6O8gykLKaaSALFkT15wvgedgAqcPMMrL/fS30Z7z9q3O2mvLN
bTHAxCXgroDl+xAeQr8VRRY6wE2Hn5gRSa+Zy8mKn+V6neZTkj6Sdj4a5JKTS/R0
Tgb7CAi8W+gVFBB1xP3jrhEZysp7XfqEwQm3bovlJNoSNAQMzB8UhDudvJ8ta2eq
r2u8gljkSwuBZ0C3utcoevSlVu/dpw0pFAQdZKVCebaySHusyjP2Bwtk1zpj5z3I
HdzoT9bzLvbwocioCkqgcV+rv7h0GQ==
=PCCl
-----END PGP SIGNATURE-----

--s3e632f7peb5icpv--
