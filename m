Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8890E2DF9DB
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Dec 2020 09:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgLUIW5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Dec 2020 03:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgLUIW5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Dec 2020 03:22:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67FC0613D3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Dec 2020 00:22:17 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krGSI-0002hv-PF; Mon, 21 Dec 2020 09:22:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krGSH-0001bX-6N; Mon, 21 Dec 2020 09:22:09 +0100
Date:   Mon, 21 Dec 2020 09:22:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Enable APB clock during register
 access while probing
Message-ID: <20201221082209.z4hkrcym4o7xhmmb@pengutronix.de>
References: <cover.1608407584.git.simon@simonsouth.net>
 <49ceda3def13f6186073745e99d7315c974bfa81.1608407584.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p5sod6t4ua4wtkzs"
Content-Disposition: inline
In-Reply-To: <49ceda3def13f6186073745e99d7315c974bfa81.1608407584.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--p5sod6t4ua4wtkzs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Dec 19, 2020 at 03:44:08PM -0500, Simon South wrote:
> Commit 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
> probing") modified rockchip_pwm_probe() to access a PWM device's registers
> directly to check whether or not the device is running, but did not also
> change the function to first enable the device's APB clock to be certain
> the device can respond. This risks hanging the kernel on systems with PWM
> devices that use more than a single clock.
>=20
> Avoid this by enabling the device's APB clock before accessing its
> registers (and disabling the clock when register access is complete).
>=20
> Fixes: 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while prob=
ing")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Trent Piepho <tpiepho@gmail.com>
> Signed-off-by: Simon South <simon@simonsouth.net>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p5sod6t4ua4wtkzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/gWy0ACgkQwfwUeK3K
7AkYKwf+PiKyvaFCQDuDh1Xr+SRJX5lmDg7ayx7+Oo2bCsDzFd/8w00TQ+2Uiww4
cKfiIuaoajQHEgbhOF2CTWO+4tqLvwR3ewDYn/O7r30oiRUqVpvzBm2bId8gudc+
g3L9JkXN8A2xcE1H0mozTS62Zt5TKD7LZmFzx6+dQlH50GUx/cLZ3pX+EAj4b7Mg
3NJKt989STjjmKNqtGga+FwFEF3xFp3tjfEDuWM+pkbd+MktElSZwW5+utmj7yKv
juSTid9duOy5pmjRjpsD3E4EAeePCVPXdYyptEXv6NgZRX34RGe4PCqKP8AhXqn1
lGHidsy2l4MjVX+guwwxp7q7Wh9pYA==
=S3YF
-----END PGP SIGNATURE-----

--p5sod6t4ua4wtkzs--
