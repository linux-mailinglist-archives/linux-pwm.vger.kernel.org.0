Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315AE29229C
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Oct 2020 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgJSGmV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Oct 2020 02:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgJSGmV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Oct 2020 02:42:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A36C061755
        for <linux-pwm@vger.kernel.org>; Sun, 18 Oct 2020 23:42:21 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUOs7-00052n-D7; Mon, 19 Oct 2020 08:42:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUOs5-0001af-KD; Mon, 19 Oct 2020 08:42:17 +0200
Date:   Mon, 19 Oct 2020 08:42:17 +0200
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
Message-ID: <20201019064217.y7hnbjlmgyjughqm@pengutronix.de>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
 <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
 <20201016073426.vyjehbkyn3sxn7d5@pengutronix.de>
 <DM6PR11MB42503DE0B047D3EBBA3997C4FB1E0@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j2panhcy4y7w7ebu"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB42503DE0B047D3EBBA3997C4FB1E0@DM6PR11MB4250.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--j2panhcy4y7w7ebu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 05:44:36AM +0000, Ayyathurai, Vijayakannan wrote:
> Hi Uwe,
>=20
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Friday, 16 October, 2020 1:04 PM
> > Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
> >=20
> > Hello Ayyathurai,
> > Note that we're both (Andy and I) are right. You must not disable the c=
locks
> > before pwmchip_remove() (otherwise for a short time the PWM looks ready
> > but isn't). And if you use devm-stuff to enable the clock it will be di=
sabled only
> > after the remove callback completed and your .remove may look like:
> >=20
> > 	static int keembay_pwm_remove(struct platform_device *pdev)
> > 	{
> > 		struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> >=20
> > 		return pwmchip_remove(&priv->chip);
> > 	}
> >=20
> > because you won't have to care for the clock explicitly.
>=20
> Sure. I will incorporate the same in the next version.
>=20
> Also, Is it fine not to care clock during pwmchip_add like below,
>=20
>         ret =3D pwmchip_add(&priv->chip);
>         if (ret)
>                 return dev_err_probe(dev, ret, "Failed to add PWM chip\n"=
);

Yes, if you cared for disabling the clk using devm_* you don't need
(even: must not) disable the clock in the error path because the devm
release functions are also called on .probe() failing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j2panhcy4y7w7ebu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+NNUYACgkQwfwUeK3K
7AmW5gf/Q7nPxaPpgjYSmfOA5qQ85A1qiVUreh21xhUhEr7bIerVkzaKFV1i9MxP
GYo53ALqsz6k8GgXStGOQVsm7kpPrvJkS0znpt31iaFcitKGfjbc2HMzZQc92gS2
D1d0oskGl2q0IaZS9YYzbWobdmB4oBo+aaeSPdXjRBcG49skHfdPzn0GSaji94+o
h8ZB3HHOh+sn4z4aDA+0gvqIW+Wp9dLnWr+1GhSUqO5wCbGvolavbuaNDrDTywxx
U/VR0xHKWhrA+lBgVTWcbgwk3wMde4CNA423ukMDawXTRYP/D5IJqa21WpQ2xVUU
POemBOjvJmE5ltdbOdVNnsXfioDzlA==
=r8J1
-----END PGP SIGNATURE-----

--j2panhcy4y7w7ebu--
