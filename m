Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25358329417
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 22:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbhCAVrC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 16:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbhCAVox (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 16:44:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A4EC0617A9
        for <linux-pwm@vger.kernel.org>; Mon,  1 Mar 2021 13:44:11 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGqKm-00039F-CO; Mon, 01 Mar 2021 22:44:08 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGqKl-0000fm-O6; Mon, 01 Mar 2021 22:44:07 +0100
Date:   Mon, 1 Mar 2021 22:44:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 1/7] pwm: pca9685: Switch to atomic API
Message-ID: <20210301214407.4xitetvqbsdoer6w@pengutronix.de>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jbzb7vdleqvxvrto"
Content-Disposition: inline
In-Reply-To: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jbzb7vdleqvxvrto
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Tue, Dec 15, 2020 at 10:22:22PM +0100, Clemens Gruber wrote:
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EOPNOTSUPP;

We agreed on -EINVAL for that one since 2b1c1a5d5148.

Other than that the patch looks ok (but note I only looked quickly).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jbzb7vdleqvxvrto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA9YCQACgkQwfwUeK3K
7AlbVggAjhMX1tA5gAqeopKXsYbCnrWvjpnvYNV8amg8MkQxRz878g0aceOQ4EYG
+cc9M2GflTbj/xdReZ1b7Z6noB4CM+QQkPsIGlf0I8j6eT1qRPBPW6KxR3jhw1+K
/scoZGR4MOVThQtBAFNvFF6CFV9VXiVUaE/cuw+9jlHuWtITuxYyZLnQsEEzdAOB
/hZiaLfl/fD9+ApLnYOmnBfyVBhTu7taufPvJYU0HKOtuKs/LIOeCavj0Wyplww3
377KV2Kyok4ux85pQYZqxz0FEeA1uufVt0RgudlanfbDlBcKgTgryJs5MGVenlkL
QxXjnI4bYJ3WOp+3aGbPkUZBmAAayQ==
=ig8H
-----END PGP SIGNATURE-----

--jbzb7vdleqvxvrto--
