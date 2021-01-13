Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A212F453F
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 08:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAMHea (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 02:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbhAMHea (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 02:34:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07356C061794
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 23:33:50 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzaf4-0007Yo-BF; Wed, 13 Jan 2021 08:33:46 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzaf3-0003MI-RH; Wed, 13 Jan 2021 08:33:45 +0100
Date:   Wed, 13 Jan 2021 08:33:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/7] pwm: rockchip: Replace "bus clk" with "PWM clk"
Message-ID: <20210113073345.hsd57lowyiev5wmf@pengutronix.de>
References: <cover.1608735481.git.simon@simonsouth.net>
 <1c2f85dafab03d6f5cdbcac37e7288de8f90e6d8.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zn4wy2rshgfchd2i"
Content-Disposition: inline
In-Reply-To: <1c2f85dafab03d6f5cdbcac37e7288de8f90e6d8.1608735481.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zn4wy2rshgfchd2i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Simon,

On Wed, Dec 23, 2020 at 11:01:05AM -0500, Simon South wrote:
> Clarify the Rockchip PWM driver's error messages by referring to the clock
> that operates a PWM device as the "PWM" clock, rather than the "bus"
> clock (which is especially misleading in the case of devices that also use
> a separate clock for bus access).

Maybe mention that this is the clock that is named "pwm" in the
devicetree and so matches to that, too.

Other than that the patch is fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zn4wy2rshgfchd2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+olcACgkQwfwUeK3K
7Ak2Rwf+NtPPnqewogx4sLf5pmYt5Foi1nz7pQI1IiF94evAfRu0Xv63rm1D1bZl
TjyYzJe2ZS1Yqnrs62x9pPuCYSzrQZ4hZZyXkaIbfqwreSVFKt364ufe5DwY1caW
ssGSzZ2sAtKYDB0J7uKiCm+GlLUzRJw2Vmx5Q1ItkEOzGtJjoW3VRjzWLK3t4w0M
cF9cNr0ybg48TJWlvmyslD2EuBq3h5ykRH5PwhUM0EevnuYUnSoc0mtxjs2ByAd5
7gj9m8Zw7qBKzi8ReljxIjQogLrRALKQsHax8Ub9pBfVifUiHn6p7WF3BB7AMFQ6
vey5vWoRJetCI4JsMrUUXetEaEtjQg==
=EBfT
-----END PGP SIGNATURE-----

--zn4wy2rshgfchd2i--
