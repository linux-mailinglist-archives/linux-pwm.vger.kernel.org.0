Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA12F2092
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 21:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbhAKUTG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 15:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390827AbhAKUS7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 15:18:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BADAC061795
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2021 12:18:19 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3dh-0006uY-2H; Mon, 11 Jan 2021 21:18:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3dg-0001on-Lr; Mon, 11 Jan 2021 21:18:08 +0100
Date:   Mon, 11 Jan 2021 21:18:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] gpio: mvebu: improve pwm period calculation accuracy
Message-ID: <20210111201808.ojtp3bkaq2iadl52@pengutronix.de>
References: <cover.1610362661.git.baruch@tkos.co.il>
 <b6fcb9829f06c1dfe2451ed57c84ba499b235022.1610362661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qaufrotskcb37mg2"
Content-Disposition: inline
In-Reply-To: <b6fcb9829f06c1dfe2451ed57c84ba499b235022.1610362661.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qaufrotskcb37mg2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 01:17:03PM +0200, Baruch Siach wrote:
> Divide the full period value to reduce rounding error.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qaufrotskcb37mg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8sn0ACgkQwfwUeK3K
7Al0bwf/WsHsOt+n2Y619kakJZYtcOPBKD2oyQSMTiGuNmzdbhLl7PjDO64iaKnW
f0q26oPFC5T8eWSGeSnUBe/pBq+EhYjhQwN8o1zawF0sDdE9fVkMr4hGg7I5xSuq
wNjOmWHCshMrx0YcRmJJH4peuBVQWarG4wPayK37+wmIEmdE3LZcxgJBB01cJBDg
gwN+VxFhcc2EJyX2iIdziqzxYfXQSr/rtLpgzRWo4Dj2dGidpiIrba0s96m/TKA+
PxihnVgGCRGmZmjkhGbh1kn/XUwZzbh2V3qQ1+zpKVIhwFj3eKPs99qHgmzVdyj2
0N3NWaC1k7Qsq6toLUbwHtxQkbGaTQ==
=3RXC
-----END PGP SIGNATURE-----

--qaufrotskcb37mg2--
