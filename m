Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48792830EC
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Oct 2020 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJEHgM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Oct 2020 03:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgJEHgM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2020 03:36:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B5C0613CE
        for <linux-pwm@vger.kernel.org>; Mon,  5 Oct 2020 00:36:12 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kPL2F-0004xR-10; Mon, 05 Oct 2020 09:35:51 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kPL23-0001St-3I; Mon, 05 Oct 2020 09:35:39 +0200
Date:   Mon, 5 Oct 2020 09:35:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20201005073538.g37j3tfc7q4gifdz@pengutronix.de>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-6-j.neuschaefer@gmx.net>
 <20200925054424.snlr3lggnsv575wu@pengutronix.de>
 <20201004014323.GD500800@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ve23n3n3k4nkv36h"
Content-Disposition: inline
In-Reply-To: <20201004014323.GD500800@latitude>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ve23n3n3k4nkv36h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sun, Oct 04, 2020 at 03:43:23AM +0200, Jonathan Neusch=E4fer wrote:
> On Fri, Sep 25, 2020 at 07:44:24AM +0200, Uwe Kleine-K=F6nig wrote:
> > > +static struct platform_driver ntxec_rtc_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "ntxec-rtc",
> > > +	},
> > > +	.probe =3D ntxec_rtc_probe,
> >=20
> > No .remove function?
>=20
> I don't think it would serve a purpose in this driver. There are no
> device-specific resources to release (no clocks to unprepare, for
> example).

I had in mind that without a .remove callback the driver cannot detach.
but looking in the code (drivers/base/platform.c) this seems wrong.
So my concern can be considered void.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ve23n3n3k4nkv36h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl96zMcACgkQwfwUeK3K
7AkG8wf+MDL1PUfowGS0UkWxYzb50CA1v9Z1Bx0aEmXSf9HVA6T8xsjxQwsDQXS5
Q3pzcQbjH1uGtttynGQPFMlc78UfIAktFUQmL2CjGTpNtbo/V0ljUJPWDt71Y2L1
ZMOfiC1KwjRgIdlNz3DHDbNcwZ9i3BcQ26Ua2vfPqL4cxnBuSmTxMerScJcio7bq
PH2zr2+7B3c03j1hdXhpnsbegbN8nc6ktjyDh/yOmPyz34wdBHExMkITFIf4IXX1
Qrez1zwcPayzDzE25VR6w1rdyvHhg1Zh9hz8tU+ixJmuIXyoUql+nTeepAd8uJZk
wowaWSYgMq53Vg02xGLMUHGVzFCc1g==
=0UxN
-----END PGP SIGNATURE-----

--ve23n3n3k4nkv36h--
