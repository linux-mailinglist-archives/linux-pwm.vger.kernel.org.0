Return-Path: <linux-pwm+bounces-277-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC92801917
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Dec 2023 01:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEFF1F210FA
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Dec 2023 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDC3D82;
	Sat,  2 Dec 2023 00:43:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401B5F9
	for <linux-pwm@vger.kernel.org>; Fri,  1 Dec 2023 16:43:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r9E6H-00077a-MR; Sat, 02 Dec 2023 01:43:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r9E6H-00CxvF-2F; Sat, 02 Dec 2023 01:43:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r9E6G-00CYHW-P9; Sat, 02 Dec 2023 01:43:16 +0100
Date: Sat, 2 Dec 2023 01:43:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231202004316.mxhrfsgcitupc6cc@pengutronix.de>
References: <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de>
 <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
 <ZWCTtPVkTUQNLVoa@orome.fritz.box>
 <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
 <20231127105844.kpu5ori6o6umfynh@pengutronix.de>
 <CAMRc=Me=J0f4epqmeLasqMYfMjMz46jpfmBpxV2bHGcp5Ev47Q@mail.gmail.com>
 <20231128090732.54xm72pnnjmbsjqb@pengutronix.de>
 <CAMRc=McAYSpCY=E1Ze7xKuBom8xOzQ4+5f7vYm33ihVU90xM1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="utrqdmjlgkaxkrgv"
Content-Disposition: inline
In-Reply-To: <CAMRc=McAYSpCY=E1Ze7xKuBom8xOzQ4+5f7vYm33ihVU90xM1w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--utrqdmjlgkaxkrgv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 11:14:32AM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 28, 2023 at 10:07=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
>=20
> [snip]
>=20
> >
> > > I see the
> > > chip->operational field that is set to false on release. In my
> > > version, we just use a NULL-pointer to carry the same information.
> >
> > Yup, sounds obvious. Your usage of "just" sounds as if your variant was
> > better. To give the alternative view where the suggested approach sounds
> > better would be:
> >
> > You need a pointer and I "just" a bool that even has a name implying its
> > function. You need to dereference the pointer in several places as the
> > needed information is distributed over two structures while it's all
> > together in a single struct for the usual foo_alloc() + foo_register()
> > approach.
> >
>=20
> There's another reason we do that. I'm no longer sure if I mentioned
> it in my talk (I meant to anyway).
>=20
> In GPIO we have API functions that may be called from any context -
> thus needing spinlocks for locking - but also driver callbacks that
> may use mutexes internally or otherwise sleep. I don't know if this is
> the case for PWM too but in GPIO we may end up in a situation where if
> we used a spinlock to protect some kind of an "is_operational" field,
> we'd end up sleeping with a spinlock taken and if we used a mutex, we
> couldn't use API function from atomic contexts.
>=20
> This is the reason behind locking being so broken in GPIO at the
> moment and why I'm trying to fix it this release cycle.
>=20
> Splitting the implementation into two structures and protecting the
> pointer to the provider structure with SRCU has the benefit of not
> limiting us in what locks we use underneath.
>=20
> Every subsystem has its own issues and we need to find something
> generic enough to cover them all (or most of them anyway). I don't
> think having a single structure cuts it.

I'm convinced it works. I introduced a wrapper pwmchip_lock() that for
now uses a mutex and once we have fast pwm_chips it uses a mutex for
sleeping pwm_chips and a spinlock for the fast ones.

That's similar to how struct irq_chip::irq_bus_lock works. For sleeping
chips that callback uses a mutex, for fast chips a spinlock.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--utrqdmjlgkaxkrgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVqfaMACgkQj4D7WH0S
/k6Oiwf9FE3nFPcJUcovOOoRtBuBRq8EZ4E7MPKRyOETfTMnO14p6KFQ8VHRsC7B
7HlmQs6du5CY14ih8Po10qqeK05HgrZqkOLHoa+L08HmIFdt7Em3UA+hGv49+zHd
5kIFZK8QQytCoOWxzJKPvdbjAUGS2zM/Ioklbnrg349QYO2YhzhfKX0Z9P9Vt6sJ
FzuEqjAoIT42ohR4KlKFnNIpGlLUxSSjzzOhtYQgvEQQUNAo6DHb2l+Lmy4kmztp
51Nx4tTU7RDGX83+og3xpSyEEpvnTBAVfwpOy6ogLIC6cvrQpZCsc7HqmtojZwq5
DOueQJZB3Ln7TTlohGPOkN+xbcqE8g==
=bbBc
-----END PGP SIGNATURE-----

--utrqdmjlgkaxkrgv--

