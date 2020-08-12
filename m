Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F39424276F
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 11:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHLJZn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgHLJZn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 05:25:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282AC06174A
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 02:25:42 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5n0v-0007hK-GJ; Wed, 12 Aug 2020 11:25:41 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5n0t-0005kC-Ko; Wed, 12 Aug 2020 11:25:39 +0200
Date:   Wed, 12 Aug 2020 11:25:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-pwm@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel: Make use of dev_err_probe()
Message-ID: <20200812092539.fbpapvrwxbmzfi65@pengutronix.de>
References: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
 <20200812082002.GD4354@dell>
 <20200812083204.kktnid63j6vefsky@pengutronix.de>
 <20200812084728.GI3448@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lmu2wukc77c5bv4a"
Content-Disposition: inline
In-Reply-To: <20200812084728.GI3448@piout.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lmu2wukc77c5bv4a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexandre,

On Wed, Aug 12, 2020 at 10:47:28AM +0200, Alexandre Belloni wrote:
> On 12/08/2020 10:32:04+0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Aug 12, 2020 at 09:20:02AM +0100, Lee Jones wrote:
> > > On Wed, 12 Aug 2020, Uwe Kleine-K=F6nig wrote:
> > > >  	atmel_pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > > >  	if (IS_ERR(atmel_pwm->clk))
> > > > -		return PTR_ERR(atmel_pwm->clk);
> > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
> > > > +				     "Failed to get clock\n");
> > >=20
> > > Isn't dev_err_probe() only useful for drivers handling -EPROBE_DEFER?
> >=20
> > devm_clk_get() might return -EPROBE_DEFER.
>=20
> If it did, you wouldn't be able to print this message.

Why that? It probably won't make it to the console immediately, but once
the clk is available the log buffer should be pushed out, shouldn't it?

> I' not sure it is worth adding so many checks for errors that will
> never happen.

I'm sure this train of thought is unsustainable. And people will copy
this code to platforms where this assumption might even be more wrong
than on at91.=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lmu2wukc77c5bv4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8ztZAACgkQwfwUeK3K
7AmMkAf/fPdflKTSmmXNABLeelpHORNhVWUW4mSGG4M8j5GcnX50LilzZnc4D7j1
Y7nMXt0Idc2W9xwxX+w5vM8sk/PEj+jmXMJSpVw3lKHVBx7f4TTn+eKDgUMNJ9yx
qdjXdw4xhHuR3eTR8DhLyeEhHpt00rGqGyphLNfTxXVbBr3d3Pgx1sRpOhvigA3a
GUsrXU2Kfoe7ViL1XBxMzoSjQWaHfIx+2LfgdDbZR2RRsIhtXYcyRImuDunSUoCm
+pHalyKI3WfUGmOMFx5Eacc5/E3GRGTUQnIQrkQYejL0Iy82zvh/Hn+tQ9ejDhRa
i/R1xNUOFoXhW75o0nwlER41SeVX0Q==
=NT70
-----END PGP SIGNATURE-----

--lmu2wukc77c5bv4a--
