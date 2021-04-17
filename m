Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84491363213
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhDQTwX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbhDQTwX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 15:52:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD0C061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 12:51:56 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXqyv-0006zB-Tz; Sat, 17 Apr 2021 21:51:53 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXqyv-0003Mx-8X; Sat, 17 Apr 2021 21:51:53 +0200
Date:   Sat, 17 Apr 2021 21:51:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <20210417195150.5fdcpxfbasp4y264@pengutronix.de>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ff2fxzbhzbuvas53"
Content-Disposition: inline
In-Reply-To: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ff2fxzbhzbuvas53
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 02:14:48PM +0200, Clemens Gruber wrote:
> The switch to the atomic API goes hand in hand with a few fixes to
> previously experienced issues:
> - The duty cycle is no longer lost after disable/enable (previously the
>   OFF registers were cleared in disable and the user was required to
>   call config to restore the duty cycle settings)
> - If one sets a period resulting in the same prescale register value,
>   the sleep and write to the register is now skipped
> - Previously, only the full ON bit was toggled in GPIO mode (and full
>   OFF cleared if set to high), which could result in both full OFF and
>   full ON not being set and on=3D0, off=3D0, which is not allowed accordi=
ng
>   to the datasheet
> - The OFF registers were reset to 0 in probe, which could lead to the
>   forbidden on=3D0, off=3D0. Fixed by resetting to POR default (full OFF)
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

(I sent my ack to v8 before, but indeed this was the version I intended
to ack)

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ff2fxzbhzbuvas53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7PFMACgkQwfwUeK3K
7AkQFAf7Bf/gV7qahl2vQAfHsWkDcCGR5BJfoJKbbHbYDThTeEVojA/x8LgbaH9g
QThc4OEKrQvwaikwerXHKTbDXWZkGY3rGuf6aAzOg9Ue3BplgNSovkdePziavycG
E16uyTFhuupd3AEJ0lkBcsDG6TFJ4jyD0LEJP3EJNpHcXpZCV1fzBqVNa8kH14Gj
DyUkQqfvJUc0bhuGV1PSn7WjFJyOIDFRFfTamq/Qn/cVBV9Pljz+kR6r1+OJS/Gu
qvZPBSoQ/6Vv+nZiLb9FNPvfAd4P1e9ip6+mA1BZ6J3DQVEkkX2JLZh2LVMPSPnY
c0plbd/hg15dojJWZglR/afI/DjrwA==
=k/RB
-----END PGP SIGNATURE-----

--ff2fxzbhzbuvas53--
