Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF543FFFD
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJ2QEy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2QEy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 12:04:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B220BC061570
        for <linux-pwm@vger.kernel.org>; Fri, 29 Oct 2021 09:02:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgUKj-0001W9-3d; Fri, 29 Oct 2021 18:02:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgUKh-0006Al-1t; Fri, 29 Oct 2021 18:02:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgUKh-0003mh-0g; Fri, 29 Oct 2021 18:02:19 +0200
Date:   Fri, 29 Oct 2021 18:02:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car M3-W+ device tree
 bindings
Message-ID: <20211029160216.cggflsvqdggt62h3@pengutronix.de>
References: <622e5ac9a841e874f772e0d9d200200706914dac.1635337701.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2y6n5cp24bll7th4"
Content-Disposition: inline
In-Reply-To: <622e5ac9a841e874f772e0d9d200200706914dac.1635337701.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2y6n5cp24bll7th4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 02:29:22PM +0200, Geert Uytterhoeven wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Add device tree bindings for TPU found on R-Car M3-W+ SoCs.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

=46rom the PWM POV:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2y6n5cp24bll7th4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF8GwQACgkQwfwUeK3K
7Ak32Af/XUBSBteU5D4Q4RnsqT8ZzGypJMQPbYaxReT5D72Jr+iSGqCzlXGOMsSX
Wb8mHyrxIdFFK5gblw5doRTNLALhAbPxzCIq/9ntrW9f5D0RohuBFT8LiH+kiTW/
OS5yW+3gtVb6LASBFmTqI3uJiF7pFjZbMLpB7ejvesqX+NVMA58EdpkyXIxgBVZX
kfu48DR6XBbnobBudyFv017QCbDz7/4A+jpe5zgieOdC9iWyFDG/I6bbomwIEX61
hoscnuNEoSTzL5jS2O9zVmZH+QwRPySKsc6L6FsNdpc8JRWK/jQXM21/7vlOwsjr
s/qvmxQNmlzzVQyhyM+qW/tkWxLGBg==
=KKJF
-----END PGP SIGNATURE-----

--2y6n5cp24bll7th4--
