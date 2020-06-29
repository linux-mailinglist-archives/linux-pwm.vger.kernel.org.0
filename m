Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB920D9CB
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 22:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgF2Tut (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 15:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387851AbgF2Tus (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:50:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6398C03E979
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 12:50:48 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpznh-0000h3-F5; Mon, 29 Jun 2020 21:50:45 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpzng-0005aB-Te; Mon, 29 Jun 2020 21:50:44 +0200
Date:   Mon, 29 Jun 2020 21:50:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200629195044.uvgma53cajiko3gf@pengutronix.de>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <20200629160844.6ecf79c1@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mft2vsrhiooh6kvs"
Content-Disposition: inline
In-Reply-To: <20200629160844.6ecf79c1@xps13>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mft2vsrhiooh6kvs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 04:08:44PM +0200, Miquel Raynal wrote:
> Hello Uwe, Thierry,
>=20
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun,  3 May 2020
> 12:54:53 +0200:
>=20
> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
>=20
> Can I have a status on this patch please?
>=20
> If it was forgotten, I would be good to have it queued now, otherwise,
> may I know the reason?

You could reply to my feedback ... If you could say there: "What you
want isn't possible" I'd count this as a strong indication to not ask to
implement Andy's suggestion. (Even if this would be possible, I'm not
sure this is a good idea, but still ...)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mft2vsrhiooh6kvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl76RhEACgkQwfwUeK3K
7AnNygf/ajou6A2cnBZDepvApB9y0hCf2RUYvXMGZEw5WqGZbmWr5Edmtsym/bZL
9x4/ugEvXcDFZrYfnYxCaEX6Y4HpKvwKX+gu2Ovbfx4LE3nEqZHh0qXrQgK2vTUD
By5NJRRup31nL9iIjmLPrG4I1ddDdN2/oQU9sHtycbwhEunnV0GuzlwBdKA6LISX
N+MBcqPfpoUlS0xCYRVacwtVNnS8/5yjA30pnUHLrHyfcErNjSKL647CmSv1B+Zx
BENNroAw8tgHnrOASQ4RAmRMQ7zIPhv+/cfv2ICG4q4E8C+MPgDc7JnW1GOhBeDV
d+D8SLIBaU7HDi4BTUcZSg8br9TmtA==
=YjLE
-----END PGP SIGNATURE-----

--mft2vsrhiooh6kvs--
