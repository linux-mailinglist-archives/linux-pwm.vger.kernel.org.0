Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57BF2DFAF6
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Dec 2020 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgLUKTa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Dec 2020 05:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgLUKTa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Dec 2020 05:19:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED074C0613D6
        for <linux-pwm@vger.kernel.org>; Mon, 21 Dec 2020 02:18:49 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krHVH-0000aP-2a; Mon, 21 Dec 2020 10:29:19 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krHVG-0008QP-P2; Mon, 21 Dec 2020 10:29:18 +0100
Date:   Mon, 21 Dec 2020 10:29:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: provide new devm helpers for prepared and
 enabled clocks
Message-ID: <20201221092918.3uuxfe4caseu2d3o@pengutronix.de>
References: <20201013082132.661993-1-u.kleine-koenig@pengutronix.de>
 <20201013082132.661993-2-u.kleine-koenig@pengutronix.de>
 <20201110202537.fyldrnhqewtppjkw@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f7qjda3pzpokbatz"
Content-Disposition: inline
In-Reply-To: <20201110202537.fyldrnhqewtppjkw@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--f7qjda3pzpokbatz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 10, 2020 at 09:25:37PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Oct 13, 2020 at 10:21:31AM +0200, Uwe Kleine-K=F6nig wrote:
> > When a driver keeps a clock prepared (or enabled) during the whole
> > lifetime of the driver, these helpers allow to simplify the drivers.
>=20
> I'd really like to make use of these helpers, so it would be great if
> you could take a look and tell me if you like my approach.

This is still the case but unfortunately I didn't get any feedback since
October 13. Is this still on your list of things to review?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f7qjda3pzpokbatz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/gausACgkQwfwUeK3K
7AmbUgf/ancR3QmOvPc3gLtPEN5FSE25YO9ceMs2y4JYfMA0T39xWvPkGIXSanD6
PkNoMEEm3kFg13Ocw3V89ipBNLghrpFlGa+rQD3DNefOuUoxYaqgU+2XC/fYdsXU
r298zkb0AOTgweKjE62qtYN/TzaCtxaqo7xHspsNdEYAyX9H+HIyKuaYDZ1XnNOF
rGxmImr/b/3hcJJBLLCHz+ZXaUMTV56iFB2/hYQ/AfoPDwHwsX4q+MfDX+G5QeT4
gGnZnjFhyA2Odid+CFoafP1goE4jvarztNxtfRGEbc7g78R7uxzpWAFyoXfqdli1
l2AgNkQyKXtmHhHYBYyHB5w2ykFH3Q==
=HFHV
-----END PGP SIGNATURE-----

--f7qjda3pzpokbatz--
