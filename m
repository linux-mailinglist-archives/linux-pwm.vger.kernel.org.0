Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292423BB876
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jul 2021 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGEH61 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Jul 2021 03:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhGEH61 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jul 2021 03:58:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C924C061574
        for <linux-pwm@vger.kernel.org>; Mon,  5 Jul 2021 00:55:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0JSG-0008Ea-IW; Mon, 05 Jul 2021 09:55:48 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0JSF-0008GR-Jr; Mon, 05 Jul 2021 09:55:47 +0200
Date:   Mon, 5 Jul 2021 09:55:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel: rework tracking updates pending in hardware
Message-ID: <20210705075547.5feystwquxamsxfr@pengutronix.de>
References: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
 <20210421092606.1634092-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7nxk2ybyfax6hjmm"
Content-Disposition: inline
In-Reply-To: <20210421092606.1634092-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7nxk2ybyfax6hjmm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Apr 21, 2021 at 11:26:08AM +0200, Uwe Kleine-K=F6nig wrote:
> This improves the driver's behavior in several ways:
>=20
>  - The lock is held for shorter periods and so a channel that is currently
>    waited for doesn't block disabling another channel.
>=20
>  - It's easier to understand because the procedure is split into more
>    semantic units and documentation is improved
>=20
>  - A channel is only set to pending when such an event is actually
>    scheduled in hardware (by writing the CUPD register).
>=20
>  - Also wait in .get_state() to report the last configured state instead
>    of (maybe) the previous one. This fixes the read back duty cycle and so
>    prevents a warning being emitted when PWM_DEBUG is on.
>=20
> Tested on an AriettaG25.

On patchwork this patch is in the state "Under Review". Did you change
this? What does this mean? Does indeed someone look into this patch?

There was some discussion in reply to this patch, but that doesn't
affect correctness of it. It's just that there are still some problems
in the driver that this patch doesn't address, but the net effect of it
is still positive.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7nxk2ybyfax6hjmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDiuwAACgkQwfwUeK3K
7Am0/Qf7BhFqMhXjrRiezuusvjGedrMWLDnIIljBPAer6shGZW6mcyvING5Bnthh
8sRB8ZCdXzpkX18FU1uEUghwY0k0aRiMdmzx7SKCm91rOUJVmkZw/vYwvSjTfc4C
Zow/jYPKzDXOmkWtwwgONcpzWyHPAqUilAoJQ16/C3d047i5qXe5ReWPLPr2gGmf
kxIJVWx4JWbpg4K5ubuOvebd9LmX71UYQFZwCTvUMILl0Ttbmahhjba4tLtz65U7
npwl7kUIYhOu/4DV3uHYYTRQKjMNxcZAUswpHvYbwk3dUXoZ0ABHBelIHGXDozs8
YF8d7ZW24is+tK/yCwkdxVTusejBAg==
=gCff
-----END PGP SIGNATURE-----

--7nxk2ybyfax6hjmm--
