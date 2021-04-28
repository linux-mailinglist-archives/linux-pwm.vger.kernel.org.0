Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F7D36D20C
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 08:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhD1GOv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 02:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhD1GOv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 02:14:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA1AC061574
        for <linux-pwm@vger.kernel.org>; Tue, 27 Apr 2021 23:14:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbdSR-0002qp-S0; Wed, 28 Apr 2021 08:13:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbdSP-0003Xz-78; Wed, 28 Apr 2021 08:13:57 +0200
Date:   Wed, 28 Apr 2021 08:13:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Roman Beranek <roman.beranek@prusa3d.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Subject: Re: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
Message-ID: <20210428061357.725m72aikc52n4gg@pengutronix.de>
References: <20210428001946.1059426-1-roman.beranek@prusa3d.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jcd6h5dtj45zoqrf"
Content-Disposition: inline
In-Reply-To: <20210428001946.1059426-1-roman.beranek@prusa3d.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jcd6h5dtj45zoqrf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Roman,

On Wed, Apr 28, 2021 at 02:19:46AM +0200, Roman Beranek wrote:
> More often than not, a PWM period may span nowhere near as far
> as 1 jiffy, yet it still must be waited upon before the channel
> is disabled.

I wonder what happens if you don't wait long enough. Is this a
theoretical issue, or do you see an (occasional?) breakage that is fixed
by this patch?

I guess the problem is that if you disable too early the output freezes
and that might be in a state where the output is still active? Would
polling the PWMx_RDY bit in the control register help here?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jcd6h5dtj45zoqrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCI/SIACgkQwfwUeK3K
7AkXLAf/bUbMStbK4wgMlibFbdHTkhIKSDtArwAbiulVWM1p/j7hivJ/JASFPjaI
ZoY077XgIBojXcgJ4eqsnHJGmEevyvcxiBJCF/TDNUNgr4Azk9zO6dh3zCIDtQT9
gKimlPCsrPOOt53Ai0N1LOKgghYa7g6tS1Bdf7dEtQuryX52NUmBgHnbvz2AoiAo
mb6e7bIEyEUSpjIfIjVGg06WmfP0Zo6CyQRQqsBsgJ2I3X/lHkT2H3eV8yHWRbwK
fTO17Bk1uVXgPYPAcIm74bBcUjFpApkbJA4671mohspC23SYsPhN+6k68uUeIoWh
M56TvuCDCsEF0iiF0SCSHP39EW1W8Q==
=sMKq
-----END PGP SIGNATURE-----

--jcd6h5dtj45zoqrf--
