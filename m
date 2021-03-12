Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047BB338E88
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 14:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhCLNP5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 08:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCLNPf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Mar 2021 08:15:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A3C061574
        for <linux-pwm@vger.kernel.org>; Fri, 12 Mar 2021 05:15:35 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKhdc-0006p4-30; Fri, 12 Mar 2021 14:15:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKhdb-0007W1-GJ; Fri, 12 Mar 2021 14:15:31 +0100
Date:   Fri, 12 Mar 2021 14:15:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: lifetime of pwm devices
Message-ID: <20210312131531.wzstoal33gscr4ws@pengutronix.de>
References: <20210312083449.5htbbr2zgqfxc3wo@pengutronix.de>
 <YEtAdbNA/c/FtVgX@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uovfwj45t5vi7d6s"
Content-Disposition: inline
In-Reply-To: <YEtAdbNA/c/FtVgX@kroah.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--uovfwj45t5vi7d6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 12, 2021 at 11:20:37AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 12, 2021 at 09:34:49AM +0100, Uwe Kleine-K=F6nig wrote:
> > Now I wonder if it is just harder to trigger such a crash or if the link
> > is good enough to cover all corner cases.
> >=20
> > I wonder if the pretty approach would be to ensure that the pwmchip's
> > lifetime is tracked using a struct dev that ensures that the pwmchip
> > doesn't go away until the consumer releases it. Is there an urge to
> > address this?
>=20
> Preventing user-causable oopses is always good :)

The key question is: Is the device link good enough to prevent all the
nasty things. Or is there an urge to address problems?

> The driver model should solve this, if it is used properly, why isn't
> the pwm layer using a struct device today?

I think this isn't used today because the PWM framework hasn't evolved
enough. I tried to do this already but I don't understand the driver
core and pwm code good enough yet to be done with that quickly. Ideally
without changing the uservisible sysfs stuff.

Looking at different implementations I wonder: the i2c core uses a
completion in the device release function. I assume this isn't what I
need to do to win a prize?! Other subsystems use an alloc function to
have the memory under framework control (e.g. spi_alloc_master,
siox_master_alloc, alloc_etherdev_mqs etc) and to be able to kfree it in
the release function. Is this the only clean way? What is the good
framework to let me find some inspiration?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uovfwj45t5vi7d6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBLaXAACgkQwfwUeK3K
7AmlIgf/RH8nbTd+KaOvvuC6/d8/5WwHS+vw+usllPACkf7FD+O6dC/J9Vsfd3cZ
PGG14OkfN5ENxS+DEI4QWMWRp2ODglhbAQc21Ar8MyOuWIpGG4cEbZg4kdOqB8JZ
sZBZCInv6CKX8q3WYJwSxn4vMBnKlPJAnNvW30X90gPRnQ1A8sPkZtS4+7pMtN6e
xHBzxLFoywKQr4cAHdh6oC6NAgtUaMTzm12ovWv3MAGZJ7HWaQ9icXnrgLHzNs9g
9Efx8tuzsRknQrTRCEbX0LAMnJKG9w12cShu4S3kYiMhV6HlDwQHD7fSjieEB0ZM
C8vz1mmq7gADCZ7vg8OCghuVYeSKLg==
=JWrr
-----END PGP SIGNATURE-----

--uovfwj45t5vi7d6s--
