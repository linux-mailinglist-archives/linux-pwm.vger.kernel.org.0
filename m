Return-Path: <linux-pwm+bounces-122-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC257F334E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A125EB21CA9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6A59152;
	Tue, 21 Nov 2023 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803018C
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 08:11:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5TLF-0004Kx-Ae; Tue, 21 Nov 2023 17:11:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5TLE-00Aciy-Bv; Tue, 21 Nov 2023 17:11:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5TLE-0053IE-2M; Tue, 21 Nov 2023 17:11:12 +0100
Date: Tue, 21 Nov 2023 17:11:11 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231121161111.zphi7pn77ns7sgu2@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2bkicqqkj5zxhgqq"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--2bkicqqkj5zxhgqq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bart,

On Tue, Nov 21, 2023 at 03:02:39PM +0100, Bartosz Golaszewski wrote:
> Eh... I had a talk at LPC where I explained why I really dislike this
> approach but I guess this ship has sailed now and it's not a subsystem
> where I have any say anyway.

Is there a record of your talk? I'm open to hear your arguments.
=20
> It's not clear in the cover letter - are these patches supposed to go
> through their respective subsystem trees?

This patch can only go in once patch #37 is in. So for now the options
are:

 - Wait until devm_pwmchip_alloc() is in the mainline and apply this
   patch then via the gpio tree
 - Ack it and let it go in via the pwm tree with the other patches.
=20
I'm not sure how quick this series will go in, so there is no rush.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2bkicqqkj5zxhgqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVc1p8ACgkQj4D7WH0S
/k5PBQgAujymUNLy+qfU2/Pxtc8/Sf/S74wq9YJGCVqpeVPwMzcwHXj+TPDw47/l
kR8QDiXAlEnvpTOpEKfRLXBeHkWOCHQZYEBMqVQz6dK7ujVAxlaoqZ0IrWlwdamG
byqTjBhQ9STXUZUfv73UDOg84pkuzPmdpAZlTJMwu9EoRh8rqIPFw4DXi8bjpvby
n5MvXkSeFemaAtlhvJZ7KDYWBqTPfu/+dsb1a0NG8B0mhCg5Pw9bVQppa2/OKaT4
aCeyzK/HC6JVmfb4xWbW6CUUX2JkNxZPEq9/hOh0HKhjncjc4SFLeT5GR/q23U5w
s1wKQZMBwIFAjEpOW0NQBqfpn+BV9Q==
=plBG
-----END PGP SIGNATURE-----

--2bkicqqkj5zxhgqq--

