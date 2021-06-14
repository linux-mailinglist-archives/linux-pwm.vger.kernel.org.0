Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0385A3A5D9F
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Jun 2021 09:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhFNHYf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Jun 2021 03:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhFNHYc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Jun 2021 03:24:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB4C061756
        for <linux-pwm@vger.kernel.org>; Mon, 14 Jun 2021 00:22:29 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lsgvS-0000zF-4I; Mon, 14 Jun 2021 09:22:26 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lsgvR-00068g-8s; Mon, 14 Jun 2021 09:22:25 +0200
Date:   Mon, 14 Jun 2021 09:22:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: Re: [PATCH 7/7] pwm: ep93xx: Prepare clock before using it
Message-ID: <20210614072222.wgivnzbaekxxw7qu@pengutronix.de>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
 <20210613233041.128961-8-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qdhm5hxduamuxfg"
Content-Disposition: inline
In-Reply-To: <20210613233041.128961-8-alexander.sverdlin@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7qdhm5hxduamuxfg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 14, 2021 at 01:30:41AM +0200, Alexander Sverdlin wrote:
> Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> to Common Clock Framework.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Maybe it would make sense to move the prepare into the probe function?!
Anyhow, for now preparing the driver for the common-clk switch is the
focus and for that the conversion is correct, so:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7qdhm5hxduamuxfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDHA6sACgkQwfwUeK3K
7An4UQf/bv7niFaS9SbdW9F3d1rel1x9K+f/z7FGHWWHl07v+iTpBzXL+fizLqAE
Cm01ON8UcKB4tMuCj/1h8h+wXVv6j4PYUtrdInjgOjOqVYEFDE//I8mL/eMPkv30
m2Hg5s82SL+EXFgy2Wi6RYnXPjMJO+OWYxZmr8IaSGvW6J7j/ipoGcEnSQSnUlCq
EqM1XMhETsxj3ilYr9F4QJwixYZTk7lI/HytVBy91nFTqf8U/foOEnG6TvFwrWQw
zpwqqmUcP4G4onTenXo4b0bt996QNfI7XLh37X9c5lHiYLHW6IzAn7I1j5clOfWt
qHRH1NtndolPU9Cf8yiqSSX+JxcvIA==
=hUiz
-----END PGP SIGNATURE-----

--7qdhm5hxduamuxfg--
