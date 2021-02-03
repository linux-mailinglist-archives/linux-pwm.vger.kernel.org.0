Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9519F30D43B
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Feb 2021 08:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhBCHqu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Feb 2021 02:46:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55401 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhBCHqt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Feb 2021 02:46:49 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l7CpO-0000ZG-Mn; Wed, 03 Feb 2021 08:43:54 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l7CpN-0005Dj-QG; Wed, 03 Feb 2021 08:43:53 +0100
Date:   Wed, 3 Feb 2021 08:43:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, vz@mleia.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: lpc18xx-sct: remove unneeded semicolon
Message-ID: <20210203074353.judxqscjba6ph7qu@pengutronix.de>
References: <1612320605-6430-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xoijghsafgj7dcgf"
Content-Disposition: inline
In-Reply-To: <1612320605-6430-1-git-send-email-yang.lee@linux.alibaba.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xoijghsafgj7dcgf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2021 at 10:50:05AM +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/pwm/pwm-lpc18xx-sct.c:292:2-3: Unneeded semicolon
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

But this is prior art:
https://lore.kernel.org/r/20210128134537.GA54687@068c7b848bbb

This patch is better though as it doesn't have a bogus Fixes: line.

*shrug*, I let Thierry decide which one to pick up.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xoijghsafgj7dcgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAaVDYACgkQwfwUeK3K
7AnY3QgAnhJW6xrm1dfNxyfMToFJ7FJ+D8AVVWp18RLDoVCvXTNcdNonJz87C3Yz
kGYGjBvqPNBJY3ad6UP3VbPKpx6ZCDS452eYMHwG5CgCz1GgFheR8kVL/0HneTnD
ea/ezvGVO1ntjtlkadaXRObP/lVh3alYDduUHqWmS33sxF+M/BccKEiMMFee1S6X
q/6qXxQ7Pz44l/spdASPtnogWcPmWMx+7/5qjDyx8Ir215DXgCSAlfnEFgbSGHa2
rKrOzj2i/qsw2k8/a+xfHk6kOLI5F8v3U29iWVdXSiHSwHJK2mUhfYSLn6LW9OoV
pIDO5Y1XWQdMwCSjXBDlBVSVzbXGPw==
=c/Sp
-----END PGP SIGNATURE-----

--xoijghsafgj7dcgf--
