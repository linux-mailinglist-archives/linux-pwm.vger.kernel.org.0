Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325A138D65C
	for <lists+linux-pwm@lfdr.de>; Sat, 22 May 2021 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhEVP2c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 May 2021 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhEVP2c (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 May 2021 11:28:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA942C061574
        for <linux-pwm@vger.kernel.org>; Sat, 22 May 2021 08:27:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lkTWr-0001Sy-Pe; Sat, 22 May 2021 17:27:05 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lkTWq-0007uA-VR; Sat, 22 May 2021 17:27:04 +0200
Date:   Sat, 22 May 2021 17:27:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Patches for next merge window?
Message-ID: <20210522152702.xhmidizdqnih5bpf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lmtoczk5frtrjgd5"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lmtoczk5frtrjgd5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

is there already an ETA when you will pick patches for your next branch?

Patchwork contains several patches that I consider ready, most
prominently my "pwm: Simplify drivers with of_pwm_n_cells =3D 3" series
that you wanted to apply shortly after v5.12-rc1 to have it in next for
a long period.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lmtoczk5frtrjgd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCpIsIACgkQwfwUeK3K
7AnXIwf+I7p7tfE+Qf6s/nCw6r+jnVjQg6Xka6OylaDClsYr/8+USVetIT3kAX62
7AJ7y45i9SGgXr4czfNM7HHUbMx+si74SIs2SV+KXf2WKes2TXNCl5qrXUaJWElJ
/VJQlaLGJNSpDM+z/TMzTu5ctkoKCii5aqN6ziz6IYpFUv21T3lRVOpK5ZhplCbg
R7NQ6sqIySXI7UtdQO+3E95CbPJ2Rb4IqeC29tmZSHYW0lQ9PBkslv4rVhP6z4LW
m5e1VIqQJWekCakkk8g+v8T9LDhoCU+g3GwzXwmSHa6Cckx3rUtYujf01r6ay0Tj
IFRpbR1Eri9VbXYOU7dgjEql+PdSAA==
=0O99
-----END PGP SIGNATURE-----

--lmtoczk5frtrjgd5--
