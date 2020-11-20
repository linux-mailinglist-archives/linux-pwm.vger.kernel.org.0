Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B305F2BA482
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Nov 2020 09:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgKTIV6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Nov 2020 03:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgKTIV6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Nov 2020 03:21:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E6C0613CF
        for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2020 00:21:57 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kg1g1-0004Fh-12; Fri, 20 Nov 2020 09:21:53 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kg1g0-0001qS-2X; Fri, 20 Nov 2020 09:21:52 +0100
Date:   Fri, 20 Nov 2020 09:21:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: pca9685: Add staggered-outputs property
Message-ID: <20201120082150.kyihkhphph7wosfz@pengutronix.de>
References: <20201118174515.278067-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdrzd4q5h23swz6o"
Content-Disposition: inline
In-Reply-To: <20201118174515.278067-1-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sdrzd4q5h23swz6o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 06:45:15PM +0100, Clemens Gruber wrote:
> The pca9685 driver supports a new staggered-outputs property for reduced
> current surges and EMI. This adds documentation for the new DT property.

Maybe point out the commit that added this support here?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sdrzd4q5h23swz6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+3fJsACgkQwfwUeK3K
7Amg+wf/Yp2pTPi09r9IdGKW4/HX6II80fBE4LrCgC+0YysxuUrD9ytZFmrZty9g
UnNJiCR8S/KmUrSzqAEo2PQqbbUxgGHQXCVdzoRSmKqatXnTqlzNbE2F9qvxd4TZ
rRTtzKSP2SvtwIRPs22md3MQdTOoCzxrKevae86veV9dX+Lw+eInPOuqYZhk8w7X
gS9x/uEPm7ofoZAUGdCCFOIAqBPYN+mJXzTu5ldCW5ysFZ25bHeXYBgUkNb2HsdV
48dEKYRmTia7Fli8CqAfVQbt/Y+FqKp2stcLnXkrEkpXT0zKNG/8QmjW0CRT+LHc
PBckPXVrd4QM5F4gGjw6SKye9FDPMA==
=isjr
-----END PGP SIGNATURE-----

--sdrzd4q5h23swz6o--
