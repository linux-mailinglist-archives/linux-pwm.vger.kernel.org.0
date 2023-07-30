Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA97685ED
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Jul 2023 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjG3OJQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Jul 2023 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjG3OJQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Jul 2023 10:09:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E058F4
        for <linux-pwm@vger.kernel.org>; Sun, 30 Jul 2023 07:09:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQ76c-0001Be-7v; Sun, 30 Jul 2023 16:09:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQ76a-003CRF-HW; Sun, 30 Jul 2023 16:09:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQ76Z-0093R1-Qw; Sun, 30 Jul 2023 16:09:07 +0200
Date:   Sun, 30 Jul 2023 16:09:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 18/18] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20230730140904.vvfre34rcbictj5n@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-19-u.kleine-koenig@pengutronix.de>
 <CAMRc=MfGWvAGYAh8q7mOenGDMpKS3q7UK7-Yxw5bn1avhoQ-UQ@mail.gmail.com>
 <20230729213712.mkfqgk6cage6yqsd@pengutronix.de>
 <CAMRc=MeSg7Emhv4VKdsPLfjTrLtsN8M0uapnDFtYGfbJ8UjxJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="euw6x3ibxthi4jlp"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeSg7Emhv4VKdsPLfjTrLtsN8M0uapnDFtYGfbJ8UjxJA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--euw6x3ibxthi4jlp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bart,

On Sun, Jul 30, 2023 at 12:07:33PM +0200, Bartosz Golaszewski wrote:
> On Sat, Jul 29, 2023 at 11:37=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
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
>=20
> IMO there shouldn't be any need for PWM drivers to dereference struct
> device held by struct pwm_chip. If anything - it should be passed to
> the drivers in subsystem callbacks.
>=20
> I may be wrong of course, I don't know this subsystem very well but it
> seems to follow a pattern that's pretty common in the kernel and
> causes ownership confusion.

A difficulty I see is that as of now the ops-pointer is maintained in
driver-allocated data. So it's not possible to call the .free callback
once the driver is gone. So either unbinding the driver must be delayed
until all consumers are gone, or the reference to a PWM that a consumer
holds must be invalidated. Both options are not optimal. But I have to
admit that I didn't grasp the device core completely (yet?), so I might
well miss something.

Also I like the concept of "..._alloc" and find it clear enough. I'm not
aware of "ownership confusions". I'm open to hear about these if you
have something to point out.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--euw6x3ibxthi4jlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTGbv8ACgkQj4D7WH0S
/k5REQgAir2T4WNLUYSeGcANa5tKl+15WSsJe5uKUr1wsw1uZpGxqDOr/XnxywwW
YKCoU2LkOEdesSk2kAIDqP75fPosyUydzVTRtixRQayjYZLErNdW0Mmm/HeEDLaU
XdRzm3Ast7qqoiUrpoRp9zoDqAg91Z4FOUpM+xIcjLFqUkl+I1TaHVekqgQzlQ0h
mOhHf/tvjeo4n1YYsehiGBwFpZb9EsEjNpiwwZ0kayj3CLFpm0tid8IxerJMSGM1
n3EJYYVT27r0drgW2ZbLF9Y5SQyLSxd1zWGZEzRIRba0o9onf2U2UrJCj50IZRfr
nzU880E05GaG9nDhTpqct7jvXabeyw==
=BMBs
-----END PGP SIGNATURE-----

--euw6x3ibxthi4jlp--
