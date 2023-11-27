Return-Path: <linux-pwm+bounces-207-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A527F9E03
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Nov 2023 11:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630971C2048A
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Nov 2023 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E818C19;
	Mon, 27 Nov 2023 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701A10F
	for <linux-pwm@vger.kernel.org>; Mon, 27 Nov 2023 02:58:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r7ZK9-0005pS-Ne; Mon, 27 Nov 2023 11:58:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r7ZK9-00BvCn-8H; Mon, 27 Nov 2023 11:58:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r7ZK8-009HRJ-V0; Mon, 27 Nov 2023 11:58:44 +0100
Date: Mon, 27 Nov 2023 11:58:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231127105844.kpu5ori6o6umfynh@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de>
 <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
 <ZWCTtPVkTUQNLVoa@orome.fritz.box>
 <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgngfnshdocqqbbp"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--kgngfnshdocqqbbp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bartosz,

On Fri, Nov 24, 2023 at 10:16:40PM +0100, Bartosz Golaszewski wrote:
> I admit I've been quite busy but I do plan on going through Uwe's
> series next week and maybe running tests similar to what I have for
> GPIO on it.

That's great. If you want to do that on my tree that already saw a few
improvements compared to what I sent out, get it at

	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking

=2E The improvements are only on the driver level, so unless you're using
one of the improved drivers, the difference wouldn't be that big I
guess. For (maybe) quicker feedback loops, you can find me on irc (e.g.
on libera's #linux-pwm) if that's a communication channel you like.

I look forward to your findings,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kgngfnshdocqqbbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVkdmQACgkQj4D7WH0S
/k59QQf/ctQ226cNV+XiF5RcgVUjG41vpAVTl3OC5HhRm9JYfW2YxMTa1z8R7k0q
cvLMD+OxkK8cNUP+67XP9nYFnMdC6wm2ONNfKUM43zyi8taFI9zkOoHvxPcR8t4D
eXm7CAi1cS79JKrP88bR4+a7XMYolGHBznB0iWGvIeb7UnCguSypbZDGj4rapere
wDTnuNmt74IZ0dP92qpXxJyPdCasp8z3a7TnmB4uhGKmY2MxBF8bBGHyL5I11jZW
yEnwQVdCD0ZMi1f9lrq1taQClXvAxwsOroHx+ZGKYt5RyMyUOGyPes8Yuz0cmrCy
8w/f4O0w1WmvPSi4Sxq8c4I9gts8KQ==
=1wQu
-----END PGP SIGNATURE-----

--kgngfnshdocqqbbp--

