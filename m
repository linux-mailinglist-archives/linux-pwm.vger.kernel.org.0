Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C615E2C394A
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Nov 2020 07:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgKYGs3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Nov 2020 01:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgKYGs2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Nov 2020 01:48:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FC0C0613D4
        for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2020 22:48:28 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khobL-0002TL-0D; Wed, 25 Nov 2020 07:48:27 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khobK-0000TG-1f; Wed, 25 Nov 2020 07:48:26 +0100
Date:   Wed, 25 Nov 2020 07:48:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: sl28cpld: fix getting driver data in pwm callbacks
Message-ID: <20201125064821.w3wtcrrt3x6am6xc@pengutronix.de>
References: <20201124212432.3117322-1-u.kleine-koenig@pengutronix.de>
 <e92a3e855332b8e5fd6698a77852f758@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64agno3jgm4vkjkc"
Content-Disposition: inline
In-Reply-To: <e92a3e855332b8e5fd6698a77852f758@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--64agno3jgm4vkjkc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 11:22:33PM +0100, Michael Walle wrote:
> Am 2020-11-24 22:24, schrieb Uwe Kleine-K=F6nig:
> > Currently .get_state() and .apply() use dev_get_drvdata() on the struct
> > device related to the pwm chip. This only works after .probe() called
> > platform_set_drvdata() which in this driver happens only after
> > pwmchip_add() and so comes possibly too late.
> >=20
> > Instead of setting the driver data earlier use the traditional
> > container_of approach as this way the driver data is conceptually and
> > computational nearer.
> >=20
> > Fixes: 9db33d221efc ("pwm: Add support for sl28cpld PWM controller")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I wasn't able to reproduce the original bug, it seems it is really
> timing/kernel/kernel config dependent. Thus I could only test if it
> still working and could not verify that the original bug is fixed.
> Nonetheless:
>=20
> Tested-by: Michael Walle <michael@walle.cc>
>=20
>=20
> Btw. the backtrace is available here:
>   https://lavalab.kontron.com/scheduler/job/108#L950

This is triggered from deferred_probe_work, so my best guess is that
both the pwm-fan (here the consumer) and the pwm hardware driver were
probed in parallel with a timing that made pwm-fan hit the short window
when driver data was unset.

I wonder if we {sh,c}ould expand PWM_DEBUG to hit this kind of error.
E.g. let pwmchip_add() request and get_state each PWM.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--64agno3jgm4vkjkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+9/jAACgkQwfwUeK3K
7An99gf/Zy02DrKeO0LtL+6oNhdTvYhBD7DusPfb4nzQ9sNQfirf+8NWakXf8h8c
LbZPc/EAVOSpn2zGYAzSyKRM5unjYfkshY+JGb7H2AWCFR+l9Znu9R6VS8/zYhi3
CJNjftAmt+2+jPTaDRYZxaQjYys6EE7dggbjNlrsxtYB3+1YYJr/6GBk53Mxn/TQ
uUL2FF/RtOwr7umyPqtxGufnoYqaayItsndNj2yw6hHAMXc+eO3yTJqm5u3yEyGk
blzJUDFx7pyflRmXFjoFAT/UQYH3krRUcqOs73WblM9cUZgaMNd+YvYe9+9ql1XU
dpv4LayW4PvBw/18psRosXzxvOBmLw==
=fGrf
-----END PGP SIGNATURE-----

--64agno3jgm4vkjkc--
