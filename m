Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D036620F4F5
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbgF3MpN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 08:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbgF3MpE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 08:45:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A2C03E979
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jun 2020 05:45:04 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jqFdF-0004Gz-9G; Tue, 30 Jun 2020 14:45:01 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jqFdE-00026X-AU; Tue, 30 Jun 2020 14:45:00 +0200
Date:   Tue, 30 Jun 2020 14:45:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200630124500.m765t276atb3wqgy@pengutronix.de>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <20200629160844.6ecf79c1@xps13>
 <20200629195044.uvgma53cajiko3gf@pengutronix.de>
 <20200630085828.1aebdf99@xps13>
 <CAMpxmJUHy+5ynmsU6FhX=MJR6XbwoNr65NGqzuAd0Bm-JS1kWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="krdjdadfcr2hiurd"
Content-Disposition: inline
In-Reply-To: <CAMpxmJUHy+5ynmsU6FhX=MJR6XbwoNr65NGqzuAd0Bm-JS1kWw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--krdjdadfcr2hiurd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Bartosz,

On Tue, Jun 30, 2020 at 11:13:31AM +0200, Bartosz Golaszewski wrote:
> I can't find anything in any of the previous threads. What was the
> reason to not go the MFD way here?

MFD doesn't work because the different "modes" are not orthogonal. So
this is not a single device that provides several functions at the same
time that can be used in parallel.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--krdjdadfcr2hiurd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl77M8kACgkQwfwUeK3K
7All0Qf9GdnPCjEM0OlXRr7bI7rOuAhdap/1C3qSS/4I43TT+CcuEs+lztsEi5Tm
DtpykD0ZiI0bhUI3SIJmS9gN4IAgQhAjYpNcgBt8/2OthVxkz8OgLDzxsan6kPIH
2U8Dxa9hPsdW7VRnXmBqKC2eeR+PPKItUy7RzkV07Qs/SUTBO4xCLifwHT7WlOnA
vBvicgmTboB6XlEfIWOq95QrZT3cchHlekcM9Qe3TGDLz2F+rj2PSWYe807G++W5
JfIpwwh1rn1TTxUxpfnaq8tx8UuHoy2XTkUnKVN8FsMRHIKfDxH13FpOWJ7r/5CO
WjYLxGth+0dO+cUZ5yDYqbbt4OZOyQ==
=bp8M
-----END PGP SIGNATURE-----

--krdjdadfcr2hiurd--
