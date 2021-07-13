Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910A23C6CE4
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhGMJKp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhGMJKo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jul 2021 05:10:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5F5C0613DD
        for <linux-pwm@vger.kernel.org>; Tue, 13 Jul 2021 02:07:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3EOL-0005ka-Gm; Tue, 13 Jul 2021 11:07:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3EOJ-0006XN-9L; Tue, 13 Jul 2021 11:07:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3EOJ-0001PE-7i; Tue, 13 Jul 2021 11:07:47 +0200
Date:   Tue, 13 Jul 2021 11:07:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     fabrice.gasnier@foss.st.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] divide by 3*sizeof(u32) when computing array_size
Message-ID: <20210713090747.ragr5vuwrezhjmgl@pengutronix.de>
References: <20210712231910.GA1831270@pc>
 <20210713063053.qqttzxlopvpnadj3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pyqa4oiecyo2qrwd"
Content-Disposition: inline
In-Reply-To: <20210713063053.qqttzxlopvpnadj3@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pyqa4oiecyo2qrwd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

one more thing: If and when you resend a reworked patch, please start
the Subject with

	pwm: stm32:

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pyqa4oiecyo2qrwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDtV98ACgkQwfwUeK3K
7AkRwwgAmJ/1yynASv2Azd29sjKfOKK+gUPbIJiekzqV/FHJjaLBoKs4u49xE7RB
v8voj2ip4L34+1pzYW2p7JwLRPM7WZWwKmaRKJw4niU+ol8N4QMG3j6Uq9H3HixR
QGM6ugV8pXEV3+bevyCUjUwTX1sRQkUwONTHzC9onJBT+Lj6HK/dQUt02m/Xv59A
iy0yww3r9UxTV3Z6mVzKhT4WoiYOX9KbtM8RJNetFv4DqkF5OeSXxtxM3dykOoRf
DqG2nlMSH7VYOsiAa9sSRPQvh+gxljhB4RDPyOvr96R4X1tZlI1ljWIrc5rXsRrg
FMiejlQJYn9c/6EzSGs9hb1da6j1jQ==
=Knxe
-----END PGP SIGNATURE-----

--pyqa4oiecyo2qrwd--
