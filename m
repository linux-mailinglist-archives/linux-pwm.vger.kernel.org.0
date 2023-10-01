Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16567B4717
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Oct 2023 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjJALKb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 1 Oct 2023 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjJALKb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 1 Oct 2023 07:10:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A683BD
        for <linux-pwm@vger.kernel.org>; Sun,  1 Oct 2023 04:10:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmuLB-00025c-M3; Sun, 01 Oct 2023 13:10:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmuLA-00AGkD-UN; Sun, 01 Oct 2023 13:10:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmuLA-0070ms-L4; Sun, 01 Oct 2023 13:10:24 +0200
Date:   Sun, 1 Oct 2023 13:10:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        Sean Young <sean@mess.org>
Subject: Re: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Message-ID: <20231001111024.a3ce3het2y3n7kvx@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230926100625.vudo7qp3h5r2dz62@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uqk2oi6j2yuidlmu"
Content-Disposition: inline
In-Reply-To: <20230926100625.vudo7qp3h5r2dz62@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--uqk2oi6j2yuidlmu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

On Tue, Sep 26, 2023 at 12:06:25PM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Aug 08, 2023 at 07:17:50PM +0200, Uwe Kleine-K=F6nig wrote:
> > this series addresses the issues I reported already earlier to this
> > list[1]. It is based on pwm/for-next and several patches I already sent
> > out, too. Maybe some of these have to be reworked (e.g. Thierry already
> > signalled not to like the patches dropping runtime error messages) but
> > in the expectation that I will have to create a v2 for this series, too
> > and it actually fixes a race condition, I sent the patches out for
> > review anyhow. For the same reason I didn't Cc: all the individual
> > maintainers.
> >=20
> > If you want to actually test I suggest you fetch my complete history
> > from
> >=20
> > 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
> >=20
> > .=20
> >=20
> > In the end drivers have to allocate their pwm_chip using
> > pwmchip_alloc(). This is important for the memory backing the pwm_chip
> > being able to have a longer life than the driver.
> >=20
> > The motivation for this series is to prepare the pwm framework to add a
> > character device for each pwm_chip for easier and faster access to PWMs
> > from userspace compared to the sysfs API. For such an extension proper
> > lifetime tracking is important, too, as such a device can still be open
> > if a PWM disappears.
>=20
> I wonder how this topic will continue. This series fixes a lifetime
> issue that can result in a userspace triggered oops and it builds the
> base for my efforts to create a /dev/pwmchipX for faster control of PWMs
> from userspace (compared to sysfs). (Currently in the prototype stage.)
>=20
> I'd like to get this in during the next merge window, please tell me
> what needs to be done to make this happen.

One problem I noticed yesterday is that this series depends on patch
"drm/ssd130x: Print the PWM's label instead of its number" that
currently waits in drm-misc-next for getting in the main line. The
series could for sure be reworked to not rely on this patch, but I'd
prefer to wait until after the next merge window instead of reworking
it.

Still, getting some feedback here in the mean time would be nice. The
questions I wonder about myself are:

 - In patch #1, devm_pwmchip_alloc() could get another parameter for the
   .ops member. This would save a line per driver like

   	chip->ops =3D &pwm_clk_ops;

   in return for an additional parameter that yields longer lines in the
   drivers.

 - In patch #101 instead of using &pwm_lock a per-pwmchip lock could be
   used for pwm_apply_state(). This would allow to parallelize pwm calls
   for different chips; I don't know how much this matters. Maybe the
   sensible option here is to keep it simple for now (i.e. how I
   implemented it now) until someone complains? (But see also the next
   item.)

 - A further complication is the requirement of pwm-ir-tx for faster
   pwm_apply_state() calls, see

	https://lore.kernel.org/linux-pwm/ZRb5OWvx3GxYWf9g@gofer.mess.org
   	https://lore.kernel.org/linux-pwm/1bd5241d584ceb4d6b731c4dc3203fb9686ee=
1d1.1696156485.git.sean@mess.org

   . This complicates the locking scheme, I didn't try to address that
   yet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uqk2oi6j2yuidlmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUZU58ACgkQj4D7WH0S
/k7iawf+Joydsj+PrvpJn8yDmVhTYD82kORXiXjwGEuk7l5YKP3lmfY/dnoYC+mO
bdFMzFaaLqgvABPhUDYqlLkvfZ/m8dgiKq7xT7Z4MHykh6OtDGlkmRVFYnFzm5rE
LEYgroTWIdH+pikIHQy6PSyNwQOa/LTR6U7gUmonvL9f4EQPcMl+uBkSY7dfTrg3
dks0mc9A1E0Fqpoc+nQUZ3annOcplNTH+YIwBnPOoH23yvseXUHrx4xRyswugm/1
F1OfDZtWBNTdn+PocVheMTkp+CJJHmOjD1uXfwv2SEkzZdBkmzulrvVuCAIpDq6O
IrqpUYcFbFK+QjpUfluwi39+n1Bf0Q==
=twMT
-----END PGP SIGNATURE-----

--uqk2oi6j2yuidlmu--
