Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576012F4596
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 08:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbhAMHzA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 02:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbhAMHzA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 02:55:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA15C061575
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 23:54:19 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzayr-00016f-Cu; Wed, 13 Jan 2021 08:54:13 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzayp-000449-Rl; Wed, 13 Jan 2021 08:54:11 +0100
Date:   Wed, 13 Jan 2021 08:54:11 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 7/7] pwm: rockchip: Enable clock before calling
 clk_get_rate()
Message-ID: <20210113075411.dhkjzdrnmvcmfag6@pengutronix.de>
References: <cover.1608735481.git.simon@simonsouth.net>
 <58dc19f81bbf531d2921c6fb0018a5cc37dc9794.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g6256zhcfbdw2nec"
Content-Disposition: inline
In-Reply-To: <58dc19f81bbf531d2921c6fb0018a5cc37dc9794.1608735481.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g6256zhcfbdw2nec
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2020 at 11:01:09AM -0500, Simon South wrote:
> The documentation for clk_get_rate() in include/linux/clk.h states the
> function's result is valid only for a clock source that has been
> enabled. However, the Rockchip PWM driver uses this function in two places
> to query the rate of a clock without first ensuring it is enabled.
>=20
> Fix this by modifying rockchip_pwm_get_state() and rockchip_pwm_apply() so
> they enable a device's PWM clock before querying its rate (in the latter
> case, the querying is actually done in rockchip_pwm_config()) and disable
> the clock again before returning.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Simon South <simon@simonsouth.net>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g6256zhcfbdw2nec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+pyAACgkQwfwUeK3K
7AkQyAf/cnf8VmK43pfs9BMAPKHF1PXLAW1yGSVfYuNJXYg5++1vGuZ5COOV5/uH
Z+VtHlz1G7uZKrrmzkoLeADfZ79p1xPSj3M7U2W5HxqmsUNVbkAg+0xebpw1oPPW
+DpvP+FvbfbsOnnsML+V5wUP6RxJiCde+2Q/wHBnKSj099UOLMX3pynrk4d0dLkv
XkEmP9Pf3rBgJJsYTQJzjCmuB8gwFCYQKOFzKe9JnzLnBTRmUAmEYzWQJSMtXR1A
Yb/luHZHsZ/7/HxljSBV/GWUQascY3qrSDi9FAruq0DaXdMPI8CnOh/eKa4Xat4o
iQ9zj67xUI8yXvjv6PMCVxXVgOv9+A==
=hgG5
-----END PGP SIGNATURE-----

--g6256zhcfbdw2nec--
