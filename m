Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4B356312
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348723AbhDGFeP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 01:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbhDGFeL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 01:34:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B32EC06174A
        for <linux-pwm@vger.kernel.org>; Tue,  6 Apr 2021 22:34:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU0pB-0001Io-V4; Wed, 07 Apr 2021 07:33:57 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU0pB-0001OP-Kc; Wed, 07 Apr 2021 07:33:57 +0200
Date:   Wed, 7 Apr 2021 07:33:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 4/8] dt-bindings: pwm: Support new
 PWM_STAGGERING_ALLOWED flag
Message-ID: <20210407053357.ok62rqpgyqou53m3@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-4-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oh3ghnp277i26zr3"
Content-Disposition: inline
In-Reply-To: <20210406164140.81423-4-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oh3ghnp277i26zr3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 06:41:36PM +0200, Clemens Gruber wrote:
> Add the flag and corresponding documentation for the new PWM staggering
> mode feature.
>=20
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

For the record, I don't like this and still prefer to make this
staggering explicit for the consumer by expanding struct pwm_state with
an .offset member to shift the active phase in the period.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oh3ghnp277i26zr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBtREIACgkQwfwUeK3K
7AkrsAf+OaJKUcsZitVBF3rsCQ1vLgPmMjFUpsau7W7di+bxtk2vSlBaLVdo77FS
KlU/YTrndouRwnwktCwXL3ec8c2czSmZpUzHip++DauYz5VaQqvupmipF4mX8UYz
A9NUDioyyGuksGrAC+L5yNv+C5/tx+8f8E7AN0hBNUISJXZqciIxvOjQQmPmTv6B
N0W6oiykNWhIVj3AlHK8rikhI1X0ZYdBplYyItwRRqgBkpf2hzAbid8MmIybvHXW
ZNa2ieD2ojXAF9dnSTy7fmkFMzVzYiHMOymMGRmLKMxdPktvmCSae5swNIYugrfQ
vmxX6xfmzsqaCWwqacE84jTn2qL/bg==
=YGX7
-----END PGP SIGNATURE-----

--oh3ghnp277i26zr3--
