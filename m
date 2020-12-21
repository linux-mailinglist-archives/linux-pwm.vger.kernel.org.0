Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472FC2DFAF5
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Dec 2020 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgLUKT3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Dec 2020 05:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgLUKT2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Dec 2020 05:19:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E904C0613D3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Dec 2020 02:18:48 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krHIi-0007qT-1O; Mon, 21 Dec 2020 10:16:20 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krHIh-0007fN-31; Mon, 21 Dec 2020 10:16:19 +0100
Date:   Mon, 21 Dec 2020 10:16:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/3] pwm: rockchip: Eliminate potential race condition
 when probing
Message-ID: <20201221091618.oxjpmlnmo5iaobt7@pengutronix.de>
References: <cover.1608407584.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eeksxyzczcgmi3o7"
Content-Disposition: inline
In-Reply-To: <cover.1608407584.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eeksxyzczcgmi3o7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Simon,

On Sat, Dec 19, 2020 at 03:44:07PM -0500, Simon South wrote:
> This patch series aims to eliminate the race condition Trent Piepho
> identified[0] in the Rockchip PWM driver's rockchip_pwm_probe()
> function, by moving code that disables a PWM device's signal clock
> ahead of the code that registers the device via pwmchip_add().
>=20
> It additionally
>=20
> - Fixes a potential kernel hang introduced by my earlier commit
>   457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
>   probing") by ensuring a device's APB clock is enabled before its
>   registers are accessed, and
>=20
> - Tries to improve the driver by (re-)enabling the signal clock of
>   only PWM devices that appear to have been started already by the
>   bootloader, rather than enabling every device's signal clock and
>   selectively disabling it later.
>=20
> I've tested these changes on my (RK3399-based) Pinebook Pro with its
> screen backlight enabled by U-Boot and they appear to work fine.
>=20
> I'd be grateful for help with testing on other devices, particularly
> those with SoCs like the RK3328 that use separate bus and signal
> clocks for their PWM devices. (My ROCK64 uses its PWM-output pins for
> other purposes and wasn't of help here.)

While looking through your I found another little problem that you might
want to address: rockchip_pwm_get_state() calls clk_get_rate(pc->clk).
According to the documentation (in include/linux/clk.h) this is only
valid for enabled clocks but there are no precautions that pc->clk is
enabled.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eeksxyzczcgmi3o7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/gZ+AACgkQwfwUeK3K
7AlBSwgAi/BqGwU/XSxPIDslGkhzhyao4Lwb9+ApXPmCwjizBPznMsBo8AuBODp3
qPZWN4S8C1RgBOGthjLjEaELaEqYh/IajguDC1OKV82zb59ySexhWQmdRiLzv5cz
FYDsmYOOM7bzZJ227cjjsbJJzW3uKukIOl9E3NRlEgpcTUKCX+gc2GuuiewVOU4V
Cflcdh1Vwt3puLDz8Lb2XBSIrhoV6f1r+ZP4qFuNU0DgICGueFKIST2ijpMHxQHU
Px/Q34UUSW3qB/n02kphI8nZjvND9gVM2b8JQ0qVcXnQiBV0fv9EyIwFAOz3ulzb
DU7qQrJDGXndMbVRuQPF0NtWWr1wIQ==
=j9Pi
-----END PGP SIGNATURE-----

--eeksxyzczcgmi3o7--
