Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1032B0FE9
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 22:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgKLVOr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 16:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgKLVOr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 16:14:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36052C0613D1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 13:14:47 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdJvP-0004eQ-Ip; Thu, 12 Nov 2020 22:14:35 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdJvL-0004uN-GY; Thu, 12 Nov 2020 22:14:31 +0100
Date:   Thu, 12 Nov 2020 22:14:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     alexandre.belloni@bootlin.com, heiko@sntech.de,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-riscv@lists.infradead.org, festevam@gmail.com,
        f.fainelli@gmail.com, shc_work@mail.ru, khilman@baylibre.com,
        wens@csie.org, jonathanh@nvidia.com,
        linux-rockchip@lists.infradead.org,
        ludovic.desroches@microchip.com,
        bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
        slemieux.tyco@gmail.com, linux-pwm@vger.kernel.org,
        rjui@broadcom.com, s.hauer@pengutronix.de, mripard@kernel.org,
        vz@mleia.com, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, paul.walmsley@sifive.com,
        matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com,
        nicolas.ferre@microchip.com, palmer@dabbelt.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        claudiu.beznea@microchip.com, nsaenzjulienne@suse.de
Subject: Re: [PATCH 01/32] pwm: sun4i: convert to
 devm_platform_ioremap_resource
Message-ID: <20201112211429.kfyqzkmmchjo6pll@pengutronix.de>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20201112161346.gp5nenuagx5wmwl2@pengutronix.de>
 <20201112190649.GA908613@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tbr6hc6mbthldmnv"
Content-Disposition: inline
In-Reply-To: <20201112190649.GA908613@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tbr6hc6mbthldmnv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Nov 12, 2020 at 08:06:49PM +0100, Thierry Reding wrote:
> I also think that it's overly narrow is scope, so you can't actually
> "blindly" use this helper and I've seen quite a few cases where this was
> unknowingly used for cases where it shouldn't have been used and then
> broke things (because some drivers must not do the request_mem_region()
> for example).

You have a link to such an accident?

> And then there are cases where the driver needs the
> resource for some other purpose, so you can't use the helper either, or
> at least it looses all of its advantages in those cases.

There is devm_platform_get_and_ioremap_resource() for (some of) these
cases.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tbr6hc6mbthldmnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+tpbMACgkQwfwUeK3K
7AnGUAf/eqdMaCevia5PicSHdbjGo8N+UPIL+x67rEHWKlaFM+cxULidS7KA+9eu
dk+gFEctD+RPOjCMe700AYmJcUetXl9GIqNaMYKUWUp+1EvVbI5dgVQ6E/kRUNMv
Mrq+Uyd9AEy4c70glsVl0r9PyGArKQ2UT56Io53YmLVuXT2OMPTgReoKaLcC5MqQ
oUiK/scmn+9xMoC6xqRakYvrrErly3+08kSF/GpyazLhJAxXOBFAftn/oPEJu4Xu
3oQXCoQQam+Yv2QAKTMuafSASZ6ff+5RFDq0WS7MZhPFyXojHSdb7hIJmEgwz0s+
koJKn1yBUrNr12RvadGhKUr9eh3dPA==
=Jz14
-----END PGP SIGNATURE-----

--tbr6hc6mbthldmnv--
