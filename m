Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681113AF138
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jun 2021 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFURFG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Jun 2021 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhFURFC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jun 2021 13:05:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D84C051C49
        for <linux-pwm@vger.kernel.org>; Mon, 21 Jun 2021 09:40:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvMym-0001uD-HX; Mon, 21 Jun 2021 18:40:56 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvMyi-000422-O5; Mon, 21 Jun 2021 18:40:52 +0200
Date:   Mon, 21 Jun 2021 18:40:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tony Prisk <linux@prisktech.co.nz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: vt8500: Drop if with an always false condition
Message-ID: <20210621164052.tsjogbj23raec6kx@pengutronix.de>
References: <20210621130458.118530-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="skaxgl2zi4vojgho"
Content-Disposition: inline
In-Reply-To: <20210621130458.118530-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--skaxgl2zi4vojgho
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

for the record: There is no need to wait for a reply by Tony Prisk, his
address created a bounce (SMTP error from remote mail server after RCPT
TO:<linux@prisktech.co.nz>: 550 relay not permitted)

Checking my archives I alread got such a result back in March, so this
doesn't seem to be a temporal problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--skaxgl2zi4vojgho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDQwREACgkQwfwUeK3K
7AlGzAgAno4EjiKygmZ5u6j5uo+WIY3oghTaviq9BsQZzVxud/DMz7rrF+LCFdPk
eIiQ2NKV/RIdvUSwPF3GklTMrght9tWw2P6n6VnEsFFf9LKXlJC5t/v49c2NgAkW
Y7Hvy//NHdP7C6uww1zcDLsW4l3rHZfmRpHbNFpZTYrGNVFhyjp7iDQzRLLpiBR1
Skezuzl1n5Dr5iVqx4jajmSOPP0wjqKnPTvkOKuBa2zlSqmZ71cK0/mnQRE7UvMc
K7MenQUCqxcreNTGpT7kaSTvWmcSoMDLaAdcTB695PcAoqaNfEByMw75FYZDSAIz
vm46Uvq57GR3G/go0+zvAiO2lvia+Q==
=pyLZ
-----END PGP SIGNATURE-----

--skaxgl2zi4vojgho--
