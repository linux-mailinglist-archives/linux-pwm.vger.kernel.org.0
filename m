Return-Path: <linux-pwm+bounces-158-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019047F54E5
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 00:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB551C20BBD
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0FD20B2C;
	Wed, 22 Nov 2023 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBEF199
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 15:39:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5wp1-0006dY-OW; Thu, 23 Nov 2023 00:39:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5wp0-00AuuC-Qz; Thu, 23 Nov 2023 00:39:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5wp0-00668f-HT; Thu, 23 Nov 2023 00:39:54 +0100
Date: Thu, 23 Nov 2023 00:39:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231122233954.crq7jr5lv2c5piik@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de>
 <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z2qlqaxh74j6nlxe"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--z2qlqaxh74j6nlxe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bart,

On Wed, Nov 22, 2023 at 11:36:19AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 22, 2023 at 10:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Nov 21, 2023 at 05:11:11PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Nov 21, 2023 at 03:02:39PM +0100, Bartosz Golaszewski wrote:
> > > > Eh... I had a talk at LPC where I explained why I really dislike th=
is
> > > > approach but I guess this ship has sailed now and it's not a subsys=
tem
> > > > where I have any say anyway.
> > >
> > > Is there a record of your talk? I'm open to hear your arguments.
> >
> > I found your slides at
> > https://lpc.events/event/17/contributions/1627/attachments/1258/2725/Li=
nux%20Plumbers%20Conference%202023.pdf
> >
>=20
> My talk is here: https://www.youtube.com/watch?v=3DVxaAorwL89c&t=3D29310s
>=20
> > The main critic as I understand it about the "alloc_foo() +
> > register_foo()" approach is: "Breaks life-time logic - the driver
> > allocates the object but is not responsible for freeing it".
> >
> > Yes, the driver allocates the object (via a subsystem helper). It is not
> > responsible for freeing the object, but the driver must drop its
> > reference to this object when going away. So foo_alloc() is paired by
> > foo_put().
> >
>=20
> Is it though? I don't see any pwmchip_put() being called in this
> patch.

It's not in this patch. Up to patch #103 I'm preparing drivers and the
code that is moved into the core isn't better than what was done before
in each driver.

Look at patch #106 which does the relevant conversion in
pwmchip_alloc(). When unbinding the mvebu gpio driver the necessary
pwmchip_put() is triggered by the devm cleanup registered in
devm_pwmchip_alloc().

> I assume it's done implicitly but that's just confusing and
> does break the scope.
>=20
> > The solution you present as the good way has the struct device in the
> > foo_wrapper. In GPIO land that's struct gpio_device, right?
>=20
> Exactly.
>=20
> > gpiochip_add_data_with_key() allocates that using kzalloc() and "frees"
> > it with gpio_device_put() right? So your approach suffers from the same
>=20
> No, the structure is allocated by kzalloc() but it's life-time is tied
> with the struct device embedded in it and it's freed in the device's
> .release() callback when the last reference is dropped.

With the complete series applied a pwmchip is allocated by
pwmchip_alloc() and it's life-time is tied with the struct device
embedded in it and it's freed in the device's .release() callback when
the last reference is dropped.

In this respect I see a certain similarity between your gpio approach
and mine for pwm. So either I don't understand your critic on my patch
set, or I don't see why it shouldn't apply to your approach, too.

Yes, gpio drivers look fine having only ..._alloc() paired with
=2E.._free() and ..._get() with ..._put(). But that's only because you
moved that "inconsistency" of kzalloc() <-> put_device() into the gpio
core, while I kept it in the drivers.

Renaming pwmchip_alloc() to pwmchip_get_new() was a honest suggestion
that moves that inconsistency to the core, too.

> > inconsistency, the only upside is that you do that once at the subsystem
> > level instead of in each driver. (And in return you have two allocations
> > (priv + foo_wrapper) while the "alloc_foo() + register_foo()" approach
> > only needs one.)
>=20
> Memory is cheap and this is not a hot path, so it isn't a big deal.

It's not only about wasting memory and the time needed to dereference
pointers. It's also about complexity that has to be grasped by humans.
Also not being in a hot path doesn't mean it's bad to pick the faster
approach. Having said that I'm not sure if the hot paths (e.g.
gpiod_set_value()) really don't suffer from having two separate
allocations.

But I guess we're both biased here to our own approach because that's
what each of us thought about in detail.

> > Let's just rename foo_alloc() to foo_get_new() and the problem is gone?
>=20
> Nope, because from a quick glance at PWM code, I'm convinced it will
> suffer from the same hot-unplug problem I described in my talk. In
> which case this rework will not fix all the issues.

Please look at the state after patch #107. If you spot an issue there,
please tell me.

> > In the implementation of foo_get_new() kzalloc() is still paired with
> > put_device() in foo_put(), but IMHO that's fine. The responsibility to
> > kfree() is traded to the struct device with device_initialize() in
> > return for a reference to the device. That's something you won't get rid
> > of while keeping the concept of reference counting.
>=20
> But if the PWM driver is unbound with users still holding references -
> do you have a mechanism to handle that?

Yes, should be fine starting with patch #107. In my tests (on top of
patch #108) it works fine. I held /dev/pwmchipX open and unbound the
lowlevel driver. The ioctls are caught in the core then and yield an
error and the kfree of the pwmchip struct is delayed until /dev/pwmchipX
is closed.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z2qlqaxh74j6nlxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVekUkACgkQj4D7WH0S
/k78tAf6AzTX5s1Y+yVF12beh2v9YbM02qCT0k9nv7VyHhXFDrE4D+C4e7rmoLeL
8YtqoWz66jRT9QAPURLP87viuumj36KowhgmQoaZan5FSlOZWqXHSPKzWL27jlkX
4pwLEMfsctan6Vq4LBMCT7/3iaZVtqXAknYdW7054df1QtsSsEgu0q2zcJGDNTpN
IHmPZCkCBgk7985UtEKI6V0oQNNSFFT+47gQBaLm8cNIgWCKo8jHKOLvvNCS6IEi
esF/7RtXi1RcKTMr0SJT/NdnDVoiWXUUMmZAMzDQEHRzhamoeFLcn3qyGsTXGQVy
M5/aULGp+mrxnChQ+Oxj1fgGj6hoXQ==
=Vpvj
-----END PGP SIGNATURE-----

--z2qlqaxh74j6nlxe--

