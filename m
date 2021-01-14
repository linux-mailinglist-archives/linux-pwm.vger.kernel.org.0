Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9532F6A45
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 20:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbhANS7V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 13:59:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:42209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbhANS7U (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 14 Jan 2021 13:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610650622;
        bh=qTnwybr7PbsPLKQjkyg5ukkUUsz3nfbiEC4dr4IScgk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WE6yu5cBKqBlZd+2auacjujUWLevlLZZmWkpwCVHpWDNprXL0Vtof3vNJ44NMAjHZ
         ORRi5dByXY+wcMZvsCeuLt02YGf0cyXzTpBfcS8SrXRdcevt1ug/sBfxoq2SLUsDEy
         fHMhD6UgaAs9vfROLDBfpUB2dXAwdOblNJvuGIfA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.208]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1l0flf2kUM-000c5l; Thu, 14
 Jan 2021 19:57:02 +0100
Date:   Thu, 14 Jan 2021 19:56:51 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <YACT87oEA17yJiff@latitude>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
 <20210109180220.121511-4-j.neuschaefer@gmx.net>
 <20210112203649.67f66996@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HZCy9zKgDQy/QBjw"
Content-Disposition: inline
In-Reply-To: <20210112203649.67f66996@aktux>
X-Provags-ID: V03:K1:cfFZLGgxjJbjT3NU7hnDESPThEwx2O8w4wIxZ67/Uqiws1AR9t0
 9FCBqnb6Kyvt6JlTv8eQOjBDHYyEyJymQBOzSJCjcvUALYN6khskivau2zg385i+XZL/OR7
 TEBIR8vN6ySlqPIlSXiiRdRlxiiicZlH24xk0SJRik4ZLuXZQmowI9QeN2Os7OzLmxL681M
 d/fPe6Rbzr4mPKsTc354Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wUOO+tWvK3k=:7eZPRXsOhlOSHNHavMx/JP
 ClzFnZRTnPvgBvfuhyuzNjXEGj9LY57QS8xSJ/gk6/D3eqT9/GkhC4lgrg3ufdfPbF+andw7x
 UW9A4DYAU3rjdbB9PrMOm4lzEl+9oNeMWSQKzoB25Mw9imgIa6EL+qfbObvePCuTrFH4bCSWf
 S2WPzSkb3gVhTAbfn8zHHpnAA4qUkz/SNuBq6/w4AkbQ+ngpHcJdfh3TPqoGUz97vFYM4+DUu
 oODoi683Sqs0qry53f6jt1V7f/+gtyhbFvvSpI8z2EwWLjogQC8x7nqlDYZWHdOz3i+R89W24
 dC2ixfzuuxumJ5anpdHkbbjl4a17lhrC5BSC901cf/qY4o+VL4MjezMCXb1TbzjEN6VRZfh6v
 pNIKw918k7l6CpAGr5fB7Mt0SA8tcu03RhDWTYMq5EXnZeEiEdSD5jX2gY18HZQIgWJSoKzWc
 rV3V87ltBPTCDQeCzOqM/TUeO89+J29LUAAJqrgAwCDXk/N0ZlgziG0NX2XqZtuoDby2hVlK9
 BYEJzYK19deX1gTYF3R8jVEFNnDoPcagC1KwOwGqFhw1cXvNe1GAwY1cOjryg6p5VWTe3Sdq6
 l/iVxkFnpSeLUnL/rV0Fbowmw4uSwGO1T6jbr0JKqevhQSPFOIinDg9XGZvQYx08qEd7y8U9h
 /aCbHZfiCqdAJ3siVXDZbAZuVpIsbKn9YazVW5DSXkTATq0zDnr9L8mq0gM5EMJdbuSqKd4ZA
 708TAgBvjInsb9AL5KGMerlUjEP/XGyLv4FRXov83lrhcKMcX151OLIZJSA52BNfZ6y2fuMCC
 gbeXYJvKqeZzc4E3qM29xV6upyu6NI13wTyMeEV2fVwQxzXlXEUDVczXQbwyOiIMjzFP4zfdu
 MdKhj+NggeNW0A11FlDg==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--HZCy9zKgDQy/QBjw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 08:36:49PM +0100, Andreas Kemnade wrote:
> On Sat,  9 Jan 2021 19:02:16 +0100
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
[...]
> > +static const struct of_device_id of_ntxec_match_table[] =3D {
> > +	{ .compatible =3D "netronix,ntxec", },
> > +	{}
> > +};
> > +
> MODULE_DEVICE_TABLE?

Yes, good idea.

> > +static struct i2c_driver ntxec_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ntxec",
> > +		.of_match_table =3D of_ntxec_match_table,
> > +	},
> > +	.probe_new =3D ntxec_probe,
> > +	.remove =3D ntxec_remove,
> > +};
> > +module_i2c_driver(ntxec_driver);
>=20
> MODULE_LICENSE()?
>=20
> modpost moans about that here.

I forgot those. Thanks for noticing.
I'll add the MODULE_ lines in v8.



Thanks,
Jonathan

--HZCy9zKgDQy/QBjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmAAk+oACgkQCDBEmo7z
X9szGg//QvOXORc7uh9Jjyie8pM10KL+AGsOtYoNGGd6pZu/uUmCTdY3bJ3PsYNS
tFEETWnnlg7zvIvi5ct92QGwmIYtg2zd1gYQbwOh513AGCArH94ow7g6aJtxk3HA
I8Xd/4pMrMaDZpv9S6xc09EBCLvniWaUxQ+1b/NAf4PgHDQpH/aOcoxG8PxxxsDD
dfBEqCOWR6rAKAy1wA0gdzzSX+v7QMoYnejpAjLdi1Lhnu6v2GhzYsPMiSxC95i+
ZzZna44PPaVE8LiwC2PqORimyXsF63srsY93kZEFfd10qe+zGCZx7qLjBLiKeTK8
JMt7QUz3ll9SWF8oYlMdofO7HHrtmqnWTMjgaYbhYqr2oqOunLWKyF2RUF1OMlU2
0HZS+wX3PGODLsPeyVup3Qx9hrkqQI2AOsQyW1nyDu/idUjC4bPGTK/7QpOGWFwx
eI3riV02jUpETGg93V3OrcHhefNdLJIPd9FGNDuz4gI1nmSggzfcnNlGIWvk1Pdi
ELV+NBvGXnxKPHvjlKSyiI5/oqw4Ernexb+yRnn0spfB8zGzomzUXOkp0WD8a0FA
5KT3UW/KnYg9kAl41zZksLacmuj4gQ7ZKRd2M2rakue0gi7mji1Zd8LZO7K6W4lb
LV4K5c05oLVqjumvUDXEzlrb9KfRz18HrBZs/F1d3+iV/6k0r74=
=fKvQ
-----END PGP SIGNATURE-----

--HZCy9zKgDQy/QBjw--
