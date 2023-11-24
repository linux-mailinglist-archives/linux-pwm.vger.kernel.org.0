Return-Path: <linux-pwm+bounces-202-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D705C7F85B6
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 22:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C489BB20A61
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA73BB36;
	Fri, 24 Nov 2023 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24279B0
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:59:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6eCY-0003qq-9k; Fri, 24 Nov 2023 22:59:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6eCX-00BLwd-B1; Fri, 24 Nov 2023 22:59:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6eCX-007hYW-1T; Fri, 24 Nov 2023 22:59:05 +0100
Date: Fri, 24 Nov 2023 22:59:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231124215904.bycfutwcj5hbzklv@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="dg6adlijopdjpgmi"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--dg6adlijopdjpgmi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bart,

On Fri, Nov 24, 2023 at 10:16:40PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 24, 2023 at 1:14=E2=80=AFPM Thierry Reding <thierry.reding@gm=
ail.com> wrote:
> > On Wed, Nov 22, 2023 at 11:36:19AM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 22, 2023 at 10:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Tue, Nov 21, 2023 at 05:11:11PM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Tue, Nov 21, 2023 at 03:02:39PM +0100, Bartosz Golaszewski wro=
te:
> > > > > > Eh... I had a talk at LPC where I explained why I really dislik=
e this
> > > > > > approach but I guess this ship has sailed now and it's not a su=
bsystem
> > > > > > where I have any say anyway.
> > > > >
> > > > > Is there a record of your talk? I'm open to hear your arguments.
> > > >
> > > > I found your slides at
> > > > https://lpc.events/event/17/contributions/1627/attachments/1258/272=
5/Linux%20Plumbers%20Conference%202023.pdf
> > > >
> > >
> > > My talk is here: https://www.youtube.com/watch?v=3DVxaAorwL89c&t=3D29=
310s
> >
> > I've been watching this along with Laurent's talk from last year (and I
> > guess I should probably also go through Wolfram's patch from earlier
> > this year) and I really like what you presented. It also sounds like
> > there was a lot of support across various audience members, so I think
> > it'd be good to rally around such a common pattern so we can start to
> > improve things on a more wide basis.
> >
> > Given that this wasn't very long ago, I wouldn't expect that much work
> > has happened yet on the resmgr library. However, I think it would fit
> > very well both with how PWM works today and with what Uwe has in mind
> > for the character device support.
> >
> > Thierry
>=20
> Hi Thierry,
>=20
> Thanks for the kind words. No work has been done so far other than
> thinking about the possible API. I'm currently in the process of
> trying to fix the object life-time and concurrent access in GPIO -
> mostly improving the dire locking situation. My goal is to implement
> all I spoke about in GPIO first and then try to generalize it to some
> other subsystem like what Greg KH suggested.
>=20
> I've already got support from Wolfram on that and we of course could
> use any help we can get.
>=20
> I admit I've been quite busy but I do plan on going through Uwe's
> series next week and maybe running tests similar to what I have for
> GPIO on it. I'm quite certain (correct me if I'm wrong) that this
> series doesn't improve the locking (specifically hot-unplug events
> during API calls). I think that my proposal has the advantage of
> having the pointer to the implementation in the "wrapper" which can be
> easily protected with RCU.

Maybe I didn't understand the problem yet, but I think hotplugging isn't
a problem for my approach. The hardware accesses in the lowlevel driver
(probably) fail then but that's something you cannot prevent. And
because pwmchip->lock is held during calls in the lowlevel driver,
removal of the driver is delayed accordingly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dg6adlijopdjpgmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVhHKgACgkQj4D7WH0S
/k65+ggApt68hK3C9Z/YVkTW+X39DDQFcD7IWB9KI2WTOLSczhMtbe61FiUCl3PI
w9j0ukwCdVDwu5GP60zvHZHn0/JyRdKJfwVFcGFuVNFwFe4dL83150CDOLxQ7E1w
IjAls5DeM2UKbM0ExYygIvlEfL5U046QHirH9MH71KGNr+oMhhdYOhjU5VtqRYch
Exa2UoNP9cQQygWH8DbLJA4W81MW7d5HuA5F5CNB9zA2w7QzgvVvsS43jC4VpRxL
zFmQ8qnk06LlXCx9fYXApxxsJaJeCSywRGm2Lor4V6JHGj3nK0PKy1Y4XsQ/ARcu
FmMV7KtpKdcAfmBMRa01YUbH/Wm79g==
=AYja
-----END PGP SIGNATURE-----

--dg6adlijopdjpgmi--

