Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4C139D1BC
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Jun 2021 23:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFFVvV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Jun 2021 17:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhFFVvV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Jun 2021 17:51:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A6C061766
        for <linux-pwm@vger.kernel.org>; Sun,  6 Jun 2021 14:49:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq0e8-0005ml-JB; Sun, 06 Jun 2021 23:49:28 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq0e7-0006OP-QO; Sun, 06 Jun 2021 23:49:27 +0200
Date:   Sun, 6 Jun 2021 23:49:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Subject: Patches for next
Message-ID: <20210606214924.lrecu6msanhdejpj@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s6egbcodfvtbmjdh"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s6egbcodfvtbmjdh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

[I already sent this mail before, but failed to also send it to the
linux-pwm list. So here is a resend. Please ignore the first
submission.]

I saw you applied a few patches to your for-next branch. IMHO there are
some more that are ready for prime time:

 - [v2] pwm: Drop irrelevant error path from pwmchip_remove()=20
   in (implicit) v1 you only had some concerns about the commit log.
   This is the same patch with an improved commit log.

 - [v2] pwm: Ensure for legacy drivers that pwm->state stays consistent
   this is a rework that improves behaviour for legacy drivers: It
   ensures that pwm->state is consistent even if a callback fails, it
   fixes a glitch when disabling and it adds tracing support en passant.

 - several cleanup series that improve individual drivers.
   (naming cleanup, conversion to .apply, stop checking the return code
   of pwmchip_remove()). There are series for
	- tiecap
	- berlin
	- pxa
	- stm32-lp
	- sprd
	- imx1

 - devm_pwmchip_add
   You had some doubts to my initial patch set that only converted one
   driver. In the meantime I identified and patched several drivers that
   can benefit from this function and simplified accordingly. This
   affects the following patches:

	- pwm: Add a devm managed function to add pwm_chips=20
	- pwm: lpss: Simplify using devm_pwmchip_add=20
	- [v2] pwm: meson: Simplify using devm_pwmchip_add=20
	- pwm: clps711x: Simplify using devm_pwmchip_add()=20
	- pwm: imx1: Simplify using devm_pwmchip_add()=20
	- pwm: crc: Simplify using devm_pwmchip_add()=20

It would be great if you would still consider these for the next merge
window or reply to these patches with your concerns.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s6egbcodfvtbmjdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC9QuAACgkQwfwUeK3K
7AnoNAgAmMjR748qe//g4yZm3s7MJc1fyjCoIhnXTeuCb9k63BY+5LXcFcm+uVP4
YaYnjGXuzJfz0xvEg10lKGyUhxpkbjuUEZ7uEAxq1SfSGcfEqnxoCQVrqSKJ9pqn
7vAFraH4skn7Z8CMP4eY0alk49D1FYzTdk3JwkipRC3pv/oT6UgU0xsxv7jnS8Ag
aDfq3wp6xjy7Od6tPw7KBWZUsNIUqlf3OwdT6PFAdMQFxMSi28AaDqG+ZZtDBkbx
At1Lf1Z2uLz5/5Ul2dwYGXNjeuOBw8lr+Lyksbq3lE9LCTSdHfBMhwoFVzHay5XM
V2ZvJXIWqu25JH0XAvktMCoWqV2LsA==
=MFHY
-----END PGP SIGNATURE-----

--s6egbcodfvtbmjdh--
