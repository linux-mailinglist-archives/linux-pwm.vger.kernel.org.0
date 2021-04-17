Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2DB363219
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhDQT6V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 15:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbhDQT6V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 15:58:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E59C061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 12:57:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXr4i-0007NH-2p; Sat, 17 Apr 2021 21:57:52 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXr4h-0003WW-G4; Sat, 17 Apr 2021 21:57:51 +0200
Date:   Sat, 17 Apr 2021 21:57:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/8] pwm: pca9685: Support hardware readout
Message-ID: <20210417195751.fmp23yalcrra5dtw@pengutronix.de>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
 <20210415121455.39536-2-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bvswtb7ux4j5wzkh"
Content-Disposition: inline
In-Reply-To: <20210415121455.39536-2-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bvswtb7ux4j5wzkh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 15, 2021 at 02:14:49PM +0200, Clemens Gruber wrote:
> Implement .get_state to read-out the current hardware state.
>=20
> The hardware readout may return slightly different values than those
> that were set in apply due to the limited range of possible prescale and
> counter register values.
>=20
> Also note that although the datasheet mentions 200 Hz as default
> frequency when using the internal 25 MHz oscillator, the calculated
> period from the default prescaler register setting of 30 is 5079040ns.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
> Changes since v8:
> - As we left the math in apply as-is, use DIV_ROUND_DOWN in get_state

I first thought this was wrong, because .apply uses ROUND_CLOSEST for
period and ROUND_UP for duty. But as the calculation for period is exact
this doesn't matter and round-down is indeed correct here.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bvswtb7ux4j5wzkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7PbwACgkQwfwUeK3K
7AlUqggAgTeCATxyERnv7ObYyikmsKMbhQlvlJqeaf7fOM8yEU8NLr3jXl6rhp0M
LDiZ9AxudFXQu9Y8+CiTOPSeX01y3ZyQmqGy7EUgnPN0483QgSVPHni1GLIKlciN
vqGoGhv13Gv5HOWKecgHgUCuiHWyg8Rukm5ntThRtCdYA88yaNkYqxWyzRnc5Owd
H/Pigj4Jt5tAG5cqz2SriP413uGBsD9t97mHPG7pKhU9UckFTNdTC5auw/xFvp8W
jvpzuVT5cOGV6hHF3e193atsiRhT/VQYfJeXMukY9iGZ4tIqIlT1klJHeJaRG6t6
StjYQHCsZmEV+1Exfkt8DOANlkMGMA==
=KL41
-----END PGP SIGNATURE-----

--bvswtb7ux4j5wzkh--
