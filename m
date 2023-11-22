Return-Path: <linux-pwm+bounces-137-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16947F4135
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 10:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2835BB20CE3
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54A53C6BD;
	Wed, 22 Nov 2023 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3765273C
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 01:05:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5jAN-0002Zt-9G; Wed, 22 Nov 2023 10:05:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5jAM-00AmNW-Ln; Wed, 22 Nov 2023 10:05:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5jAM-005a4H-C5; Wed, 22 Nov 2023 10:05:02 +0100
Date: Wed, 22 Nov 2023 10:05:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vnkbjaxtjrd3vfig"
Content-Disposition: inline
In-Reply-To: <20231121161111.zphi7pn77ns7sgu2@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--vnkbjaxtjrd3vfig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bart,

On Tue, Nov 21, 2023 at 05:11:11PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 21, 2023 at 03:02:39PM +0100, Bartosz Golaszewski wrote:
> > Eh... I had a talk at LPC where I explained why I really dislike this
> > approach but I guess this ship has sailed now and it's not a subsystem
> > where I have any say anyway.
>=20
> Is there a record of your talk? I'm open to hear your arguments.

I found your slides at
https://lpc.events/event/17/contributions/1627/attachments/1258/2725/Linux%=
20Plumbers%20Conference%202023.pdf

The main critic as I understand it about the "alloc_foo() +
register_foo()" approach is: "Breaks life-time logic - the driver
allocates the object but is not responsible for freeing it".

Yes, the driver allocates the object (via a subsystem helper). It is not
responsible for freeing the object, but the driver must drop its
reference to this object when going away. So foo_alloc() is paired by
foo_put().

The solution you present as the good way has the struct device in the
foo_wrapper. In GPIO land that's struct gpio_device, right?
gpiochip_add_data_with_key() allocates that using kzalloc() and "frees"
it with gpio_device_put() right? So your approach suffers from the same
inconsistency, the only upside is that you do that once at the subsystem
level instead of in each driver. (And in return you have two allocations
(priv + foo_wrapper) while the "alloc_foo() + register_foo()" approach
only needs one.)

Let's just rename foo_alloc() to foo_get_new() and the problem is gone?

In the implementation of foo_get_new() kzalloc() is still paired with
put_device() in foo_put(), but IMHO that's fine. The responsibility to
kfree() is traded to the struct device with device_initialize() in
return for a reference to the device. That's something you won't get rid
of while keeping the concept of reference counting.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vnkbjaxtjrd3vfig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVdxD0ACgkQj4D7WH0S
/k5u+QgAhL9cAHEDJb5mLuHj9xxdGW6XS2h8ZWboeVJZx9RkdvOhbA89AqXVuL6L
LKbgWsC5s06WsGm5+8TuZpNMC/yME/HrnnhKLh5AMFutwlw6LkVv8l7eZoEx8zQ8
lPPnLKdkETgKRrZ95syylMPuyejkhaJ7aKXLp4kUtU9n2fEcPFFmLAaIRfD01LQG
6zztVXR2QGrOASO9XRoAQoMVpDbT7kCyts1SEMNj5t59BAQG/bAdrc/6LGrlbpk4
n9O5vnfZEXLFNSU1FhxKHRpb95WlHAj78Dwg+ON/G6OQvFWYCn/sfp43UUmu7lVL
MpTlsOzEufI17Q6s6obYW8avnJWY5g==
=XKPy
-----END PGP SIGNATURE-----

--vnkbjaxtjrd3vfig--

