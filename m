Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD02F475A
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 10:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbhAMJRi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 04:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbhAMJRi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 04:17:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6978FC061575
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jan 2021 01:16:58 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzcGs-0003Gm-Sm; Wed, 13 Jan 2021 10:16:54 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzcGp-0001aO-Qw; Wed, 13 Jan 2021 10:16:51 +0100
Date:   Wed, 13 Jan 2021 10:16:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     Simon South <simon@simonsouth.net>, linux-pwm@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>, steven.liu@rock-chips.com
Subject: Re: [PATCH v3 7/7] pwm: rockchip: Enable clock before calling
 clk_get_rate()
Message-ID: <20210113091651.u6bylq6i2xeyrmwh@pengutronix.de>
References: <CAKUh=Rw=9u-hhjRv6cFMLuq0+od=gAGedbv-on1rgGweWu_SeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7nqk4vhu4dp4xkai"
Content-Disposition: inline
In-Reply-To: <CAKUh=Rw=9u-hhjRv6cFMLuq0+od=gAGedbv-on1rgGweWu_SeA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7nqk4vhu4dp4xkai
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kever,

[stripped recipients a bit]

On Fri, Dec 25, 2020 at 03:15:12PM +0800, Kever Yang wrote:
> + David and Steven,
>=20
> Hi Steven,
>     please help to review this patch set.

I wonder if a private message would have been enough instead of seven
identical mails to a massive set of people.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7nqk4vhu4dp4xkai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+uoAACgkQwfwUeK3K
7AmuUgf9EQmQeSORmdlw2lI3XCumQsN9tvN8V3fM7xVwy247I+EVZxjnVZ0uOdFE
2SZLXl0hBqBp53YUyqgFruFfgBL/7FYnTptB2MZE2TrOqjHrLo5j+xvP6wBp7Acx
gRrjgAfIj1h4PPH7Yw4v7SMt3BPaNqX9Isbg9m7Rvp4/5kJUE/04djUrR3QCWiQw
va4/HU44AL5uF5F40rHwnYTo0RZVk2AN/oBmgKQKIh7GEbL0sQ6DGYHeZypUPrVw
5P6LRM2rqHo5YhbXlREU27M3/rAW8tym0cZCGGEV6x7PocDo6Jw0CKgEVhi0gXOz
Qsm7Swfi7T9ae3auiOvt11PngEMnlg==
=FlOI
-----END PGP SIGNATURE-----

--7nqk4vhu4dp4xkai--
