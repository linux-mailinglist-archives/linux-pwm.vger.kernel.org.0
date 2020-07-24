Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1F822CB67
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgGXQrg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 12:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgGXQrg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 12:47:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240BC0619E4
        for <linux-pwm@vger.kernel.org>; Fri, 24 Jul 2020 09:47:36 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jz0r8-00060c-6a; Fri, 24 Jul 2020 18:47:34 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jz0r7-0004Uo-1X; Fri, 24 Jul 2020 18:47:33 +0200
Date:   Fri, 24 Jul 2020 18:47:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v4] pwm: bcm-iproc: handle clk_get_rate() return
Message-ID: <20200724164732.dlzykskoyicvudxm@pengutronix.de>
References: <20200718044606.18739-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpkmtaie53wffwdm"
Content-Disposition: inline
In-Reply-To: <20200718044606.18739-1-scott.branden@broadcom.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zpkmtaie53wffwdm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 09:46:06PM -0700, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>=20
> Handle clk_get_rate() returning 0 to avoid possible division by zero.
>=20
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>

LGTM

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zpkmtaie53wffwdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8bEKIACgkQwfwUeK3K
7AmqhAf/VecpBhLCwuweFqfOdiYiJozKCjXZTiczR/q/hBwUPmyGhrk5tkKgSc5C
AkWRKXk2ZPhP+utJJesUg5gqs9CpNpEGrd1SeUkynnq8S1+1uVeqgBnZsFrU6uZP
xir/EBUvjPtDBiB5n+B34YEEN2ookofE7Sd0dh8zJOMtXEpSXYVJZqJ9woR4tdMP
TYyRIo9iN3EX4SA30yoSirxxcJzosEOzCbNthYUS5cum4warJ9VzqKg6BeV2HVBD
EesjyjrxvEZEVh48XYqXimSEWuQTRDN7iHBLI5WlkSJ6Kz/T8GXZZxBSFSFZIrfR
x8S6hu/VQUloNLsvvYwPKikoNgb7Vg==
=b6Vh
-----END PGP SIGNATURE-----

--zpkmtaie53wffwdm--
