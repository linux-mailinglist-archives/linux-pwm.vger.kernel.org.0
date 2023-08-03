Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB68D76E4C8
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Aug 2023 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjHCJnY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Aug 2023 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjHCJm5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Aug 2023 05:42:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DB49DE
        for <linux-pwm@vger.kernel.org>; Thu,  3 Aug 2023 02:42:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRUqU-0007Re-4s; Thu, 03 Aug 2023 11:42:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRUqS-000oGz-QE; Thu, 03 Aug 2023 11:42:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRUqS-00A7Gv-43; Thu, 03 Aug 2023 11:42:12 +0200
Date:   Thu, 3 Aug 2023 11:42:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 18/18] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20230803094212.g3il26hqbboppiz4@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-19-u.kleine-koenig@pengutronix.de>
 <CAMRc=MfGWvAGYAh8q7mOenGDMpKS3q7UK7-Yxw5bn1avhoQ-UQ@mail.gmail.com>
 <20230729213712.mkfqgk6cage6yqsd@pengutronix.de>
 <CAMRc=MeSg7Emhv4VKdsPLfjTrLtsN8M0uapnDFtYGfbJ8UjxJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jpbr3ky5ktfxb5ch"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeSg7Emhv4VKdsPLfjTrLtsN8M0uapnDFtYGfbJ8UjxJA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jpbr3ky5ktfxb5ch
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bart,

On Sun, Jul 30, 2023 at 12:07:33PM +0200, Bartosz Golaszewski wrote:
> On Sat, Jul 29, 2023 at 11:37=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello Bartosz,
> >
> > On Sat, Jul 29, 2023 at 04:09:40PM +0200, Bartosz Golaszewski wrote:
> > > Looks good to me (although I have my reservations about the concept of
> > > foo_alloc() for subsystems in the kernel...).
> >
> > Wolfram's EOSS talk[1] mentioned "__cleanup__ + kref as suggested by Ba=
rtosz?
> > Paradigm shift, probably looong way to go". I guess that's what you'd
> > prefer? Do you have a link for me to read about this?
> >
>=20
> For now I prefer the gpiolib model. One structure allocated and
> controlled by the driver (struct gpio_chip) which needs to live only
> as long as the device is bound to a driver and a second structure
> private to the subsystem, allocated and controlled by the subsystem
> (struct gpio_device) which also contains the referenced counted struct
> device and is only released by the device's release callback.

The issue I want to fix for pwm (but don't know yet how to do) is: What
should happen to PWMs that are requested by a consumer when the PWM
driver goes away.

I looked into how gpio does it, and I think the "solution" there is:

	dev_crit(&gdev->dev,
		 "REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED\n");

introduced in e1db1706c86e ("gpio: gpiolib: set gpiochip_remove retval
to void"). (But the problem is actually older because returning -EBUSY
as done before is bad, too) I'd hope this could be done better?!

While trying to understand how gpio works, I found a few issues that are
(I think) fixable with the gpiolib model:

 - gpiochip_add_data_with_key() calls device_initialize(&gdev->dev) and
   has later error paths that don't do device_put() but kfree gdev.

 - the locking scheme in gpiod_request_commit() looks strange. gpio_lock
   is released and retaken possibly several times. I wonder what it
   actually protects there. Maybe doing

	diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
	index edab00c9cb3c..496b1cebba58 100644
	--- a/drivers/gpio/gpiolib.c
	+++ b/drivers/gpio/gpiolib.c
	@@ -2064,13 +2064,11 @@ static int gpiod_request_commit(struct gpio_desc *=
desc, const char *label)
				goto out_free_unlock;
			}
		}
	+	spin_unlock_irqrestore(&gpio_lock, flags);
		if (gc->get_direction) {
			/* gc->get_direction may sleep */
	-		spin_unlock_irqrestore(&gpio_lock, flags);
			gpiod_get_direction(desc);
	-		spin_lock_irqsave(&gpio_lock, flags);
		}
	-	spin_unlock_irqrestore(&gpio_lock, flags);
		return 0;
	=20
	 out_free_unlock:

   simplifies the code and given that gpiod_get_direction() rechecks
   gc->get_direction unlocked I don't think we'd loose anything here.

 - there is a race condition: gpiochip_remove() takes &gdev->sem when
   invalidating gdev->chip and calling gpiochip_set_data(), but the
   various gpio API functions calling VALIDATE_DESC_VOID don't hold
   &gdev->sem, so gpiochip_remove() might clean gdev->chip just between
   a consumer calling VALIDATE_DESC_VOID(desc) and
   WARN_ON(desc->gdev->chip->can_sleep) (e.g. in gpiod_set_value).

> IMO there shouldn't be any need for PWM drivers to dereference struct
> device held by struct pwm_chip. If anything - it should be passed to
> the drivers in subsystem callbacks.

I don't understand this. I think we agree that a PWM driver shouldn't
have to care about the devices's lifetimes. It's difficult enough to get
this right on the subsystem level.

> I may be wrong of course, I don't know this subsystem very well but it
> seems to follow a pattern that's pretty common in the kernel and
> causes ownership confusion.

Yes that's common. I think another thing that's common though is that
device lifetime isn't properly handled, and while I don't consider
myself as an expert here, the above makes me consider that gpio is no
exception here. So I doubt it serves as a good example to copy from.

Having said that I think the ..._alloc approach is easy enough for
subsystem drivers. Also for pwm we only need a devm_... variant, so
getting the driver part right is really easy.

And given that ..._alloc makes it easier for a subsystem core to do
things right (as it only has to handle a single data structure that
lives long enough) that's what I did here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jpbr3ky5ktfxb5ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTLdnMACgkQj4D7WH0S
/k4JSgf/fGVkl9NdCoz5kRSOxoqYsg0CdBu8+U38Jpnp6gGedamP10T33xo0qnPv
aAkNYlpCa1ZjCwg9FPTE5Ef4+Mqn/tH7urJZ+t97lXbNr9ndbFmM9bQdi6Ojg3RY
JP4sTPVXjm8ylSbxnDme5KJfEZzck9+vNHei+xi8Y7T61GlVT10oNBd/Lr8TPq81
QaC6xb5WAbJtRPqAkGAx7anWKptNKvelU/M6ma7itX5UPUvUUBvackRz1SdWVWga
CrkzRY8894lxKBZEBuzfEW5sSKFVOwDx7glHp986OcpqLtltfB71lZ98kknCUhUS
q8F4seIUHXtcC3+qfaLPd93CkXC22g==
=vBqN
-----END PGP SIGNATURE-----

--jpbr3ky5ktfxb5ch--
