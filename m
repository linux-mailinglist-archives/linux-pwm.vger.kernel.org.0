Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5487EE485
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Nov 2023 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjKPPmi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Nov 2023 10:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjKPPmi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Nov 2023 10:42:38 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0213B101
        for <linux-pwm@vger.kernel.org>; Thu, 16 Nov 2023 07:42:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3eVk-00033Q-M5; Thu, 16 Nov 2023 16:42:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3eVj-009Tzc-FR; Thu, 16 Nov 2023 16:42:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3eVj-002hT5-5K; Thu, 16 Nov 2023 16:42:31 +0100
Date:   Thu, 16 Nov 2023 16:42:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: stm32: Mark capture support as broken
Message-ID: <20231116154231.3w36liekcww5x3ih@pengutronix.de>
References: <20231115211815.441067-1-u.kleine-koenig@pengutronix.de>
 <045e7e79-db14-40c1-bc87-8c0dcb76afbd@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrfr53pwdnsnhlel"
Content-Disposition: inline
In-Reply-To: <045e7e79-db14-40c1-bc87-8c0dcb76afbd@foss.st.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yrfr53pwdnsnhlel
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabrice,

On Thu, Nov 16, 2023 at 03:59:48PM +0100, Fabrice Gasnier wrote:
> On 11/15/23 22:18, Uwe Kleine-K=F6nig wrote:
> > As described in the added comment, calling capture on one channel stops
> > all PWM output on the other channels. While it probably isn't hard to
> > fix, I cannot test it. Also this bug supports my guess that capture
>=20
> No, there's a check in stm32_pwm_capture() not to break a running PWM
> channel:
>=20
> 	if (active_channels(priv)) {
> 		ret =3D -EBUSY;
> 		goto unlock;
> 	}

Ahh, indeed. Is this a hardware limitation, or could capturing also work
without toggling TIM_CR1_CEN?

> > isn't used in practise. So instead of an untested fix, mark capture
> > support as broken. If indeed there are users this will hopefully make
> > them speak up and provide a tested fix.
>=20
> That looks like a revival of earlier discussion[1] to deprecate the
> capture interface[1].
>=20
> [1]
> https://lore.kernel.org/linux-pwm/Yz%2F4V0gH%2FvrWSS8U@orome/T/#mc5fb080c=
2576e3c2558a646dc5db40f6ff00c9b0

Yes, I still think capturing is an alien part of the PWM framework.

> Please notice there's a on-going work to move on the counter interface
> to support capture[1]. There's still some pending work & review at my
> end to address.
> So I don't agree to mark this as broken. For now, there may be users
> without alternative.

OK, I'll discard my patch from my mailbox and patchwork.

Thanks for the feedback,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yrfr53pwdnsnhlel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVWOGYACgkQj4D7WH0S
/k5ybQf+Jl+7dGsuTdVXMYWzA15hs5bJ4kJ0leKC5+7fLWjhpBOd5D83fCNsVXK3
cuXp43sVxhWZu4mYsT6v/o8tGiYW131NqLs4u0FyV7DkvxnVLbabSf0ULEsBPwbC
Oz8h89C1AYd+jmrvuWUCjfNKYOUqbVH0h+MgqU1lSkSlQZ8GGAo9Dnw9CA9j8f4L
t0ELIJgGfX4zLtyGh3m6YcsxiGMCSum8f+wHpYWLHRYLaObY4rCxjh2OZ42gHlHy
xRobKWdq0ZzjGqvLdzTD7rnSs9HM+3X+iXl2/ZAAkEwa2R10Hbtz6NKkt4uznEwO
nJNnH7FTXRaq3AYU6V2R9PFHugJnzQ==
=4SoR
-----END PGP SIGNATURE-----

--yrfr53pwdnsnhlel--
