Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850DF2FD723
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbhATReD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 12:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbhATR0E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Jan 2021 12:26:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E80C0613CF
        for <linux-pwm@vger.kernel.org>; Wed, 20 Jan 2021 09:25:23 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l2HED-0007E4-9d; Wed, 20 Jan 2021 18:25:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l2HDt-0003dQ-No; Wed, 20 Jan 2021 18:24:49 +0100
Date:   Wed, 20 Jan 2021 18:24:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/4] gpio: mvebu: improve handling of pwm zero on/off
 values
Message-ID: <20210120172449.z55oyiktpez76zwe@pengutronix.de>
References: <cover.1611128398.git.baruch@tkos.co.il>
 <fb61ffe7275237715af92015b2216b8355feb0d6.1611128398.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7i7bkmbdao25rjm4"
Content-Disposition: inline
In-Reply-To: <fb61ffe7275237715af92015b2216b8355feb0d6.1611128398.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7i7bkmbdao25rjm4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 06:16:28PM +0200, Baruch Siach wrote:
> Hardware appears to treat zero value as 2^32. Take advantage of this
> fact to support on/off values of up to UINT_MAX+1 =3D=3D 2^32. Adjust both
> .apply and .get_state to handle zero as a special case.
>=20
> Rounded up division result in .get_state can't be zero, since the
> dividend is now larger than 0. Remove check for this case.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Analyzed-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7i7bkmbdao25rjm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAIZ14ACgkQwfwUeK3K
7Am43QgAlhpAMjUS5lyrhrNQdVVIq+zrFhcmzsorsvBCzxThEDvX8zDEagYumWpI
eLhnqfrf8Sih4Q8IdvC49DlYMj77DcMlwLYNvCf+KR4LkcBrANp8MsKyGMXdKmRu
KaOo5greL3fISrXCddluJBz/AY3lNRSvasQgYBbZlUcWmIT4usiRpuuS7XfRmkFS
23rzl3TZ4XEtyLnr73jJ7xmYgJg9aNRlOUOtIZ8kQ11Y6fl+wQWgCpsodWo/4t/B
3YASAH9hMBhboxD3cGhhG+Gza7XomINaZhKLFUf3PoBGnueGju0suOsF9tT1p2wS
s/gxj0bkBsQWrbglhgk2x2RRoZcH5A==
=EzHw
-----END PGP SIGNATURE-----

--7i7bkmbdao25rjm4--
