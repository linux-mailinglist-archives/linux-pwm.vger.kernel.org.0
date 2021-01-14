Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A5F2F68F1
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 19:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbhANSFx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 13:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbhANSFw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Jan 2021 13:05:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67887C061796
        for <linux-pwm@vger.kernel.org>; Thu, 14 Jan 2021 10:05:12 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l06ze-0005bf-3P; Thu, 14 Jan 2021 19:05:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l06zd-0003wT-HD; Thu, 14 Jan 2021 19:05:09 +0100
Date:   Thu, 14 Jan 2021 19:05:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210114180509.j5wcbxuwx4rzfys7@pengutronix.de>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <YAB8ZmtOxRV1QN4l@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j6p2aexwzcoijx25"
Content-Disposition: inline
In-Reply-To: <YAB8ZmtOxRV1QN4l@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--j6p2aexwzcoijx25
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Thu, Jan 14, 2021 at 06:16:22PM +0100, Clemens Gruber wrote:
> On Mon, Jan 11, 2021 at 09:35:32PM +0100, Uwe Kleine-K=F6nig wrote:
> > My position here is: A consumer should disable a PWM before calling
> > pwm_put. The driver should however not enforce this and so should not
> > modify the hardware state in .free().
> >=20
> > Also .probe should not change the PWM configuration.
>=20
> I see. This would also allow PWMs initialized in the bootloader (e.g.
> backlights) to stay on between the bootloader and Linux and avoid
> flickering.
>=20
> If no one objects, I would then no longer reset period and duty cycles
> in the driver (and for our projects, reset them in the bootloader code
> to avoid leaving PWMs on after a kernel panic and watchdog reset, etc.)
>=20
> And if there is no pre-known state of the registers, we actually need
> the .get_state function fully implemented.

This sounds right.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j6p2aexwzcoijx25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAAh9IACgkQwfwUeK3K
7AkiRAf9HsjBHUFdx6tf8RgomKLnOSg5mQTjTfN8l5r3rM3YvPFexDA8bEMrCbD9
odIhii9oDJwwaK3MeDe2ox3wiP/fK/7NtOCO2ipDTtBt41VCdyAjJQBHrOQk3MyG
tMUSpnc9Ly7ebOJg1wKDl3m9WwBRtyUixnKkh/DzxCw6cQYL/0yc67pYAuk94Yft
s/kHzoqmiMoTLaVnOg84nt4j1k2vI7e3PAUA/IbmChOTHTkvU+wo2Wl61rb5Jhus
1AC0uKvsXssHMVk2NSYCB0bdS2HRpTOR6L1uEyDRINqBG6zjiDGHoKQjjzDDjqd9
eG5JusA5ChrNvkqwHsW+oMLZ4GfQDg==
=7aIM
-----END PGP SIGNATURE-----

--j6p2aexwzcoijx25--
