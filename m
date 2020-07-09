Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C961821999A
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 09:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgGIHTP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 03:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIHTP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 03:19:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF09C061A0B
        for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2020 00:19:14 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jtQpr-0006S0-Ix; Thu, 09 Jul 2020 09:19:11 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jtQpq-0001G5-MO; Thu, 09 Jul 2020 09:19:10 +0200
Date:   Thu, 9 Jul 2020 09:19:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: PWM SUBSYSTEM
Message-ID: <20200709071910.kjrffbb3mvpmcshm@pengutronix.de>
References: <20200708175924.15554-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmgiwuezro3rtemv"
Content-Disposition: inline
In-Reply-To: <20200708175924.15554-1-grandmaster@al2klimov.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fmgiwuezro3rtemv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 07:59:24PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>=20
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>=20
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

LGTM:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fmgiwuezro3rtemv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8GxOsACgkQwfwUeK3K
7AlGWAf9G+Z7fPy07lmGONJ+2G/rHAVec04kNvEx3wx1lho0PfZvpRhaoaKhXQoa
lrYfDDMIbnng2Vqrpw7cA0LzFzedAO7pKofJ1d3I3PkjjPcCU5Cu2pw3rgH4KOgB
eNIX2zuJnVBVKYEbqqO4WnIbHW0b8Yu5iWOErTvUmj7WKM6Otzz1zMRpmo01CtKk
c0uHaPM9eDS8rLFr5Nd4emmyr5+YfcqOHWQ51odVlE627bIo2HYnfpWEQYsOBxX8
sUXL/m8o7LCDv+tYYEj1neLl8LuHl517g8A3XvM11W5Di/kVTFdiW9ti6+DBFCyK
GdWu+meRxhGhw00XiU8Z7GZXgDAHzg==
=I6Zg
-----END PGP SIGNATURE-----

--fmgiwuezro3rtemv--
