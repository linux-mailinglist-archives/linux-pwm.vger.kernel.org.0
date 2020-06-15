Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EAF1F9BB0
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2020 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgFOPQT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Jun 2020 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOPQT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2020 11:16:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E06C061A0E
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jun 2020 08:16:19 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jkqqP-0003Xw-0b; Mon, 15 Jun 2020 17:16:17 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jkqqN-0008T9-KO; Mon, 15 Jun 2020 17:16:15 +0200
Date:   Mon, 15 Jun 2020 17:16:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: iqs620a: Use 64-bit division
Message-ID: <20200615151615.lbxajfkgzmdbmdva@taurus.defre.kleine-koenig.org>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pn5rhpjdzgafivym"
Content-Disposition: inline
In-Reply-To: <20200615141606.2814208-3-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pn5rhpjdzgafivym
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 04:16:06PM +0200, Thierry Reding wrote:
> The PWM framework is going to change the PWM period and duty cycles to
> be 64-bit unsigned integers. To avoid build errors on platforms that do
> not natively support 64-bit division, use explicity 64-bit division.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

LGTM,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pn5rhpjdzgafivym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7nkLsACgkQwfwUeK3K
7AlWHwf/dICNt57s5UZBXtembW54DPqqvCVw0lr4GNUtJE7S2lUR33/emNrjb8kN
WyDTQuDeHgYt7ELaXIuLEjTEu97kZyYOgl5bSQefsdfNMhnstvjPRELO3z80ZCoC
WQfuBkAS2G+MjjkopJnTi+k5F7JqBPGP7Vx7fsuQ3AvfBXkqSTGKzJLOwdTPghFB
yZ0XpNNN0J2qD5ZayA+kP5wd8faBSe5JLMOnIpmpAs0gNRF33vyE3hnunyV7QKpO
7Av1YFLti+pj1Wyc6mWv0kRVrSKnivrYWuYJ35M4Tu77KEU16hpRjclrtdV3yXDK
0vV88ZiTLuJHk9nrOcIHLITiKKIkLA==
=U0uY
-----END PGP SIGNATURE-----

--pn5rhpjdzgafivym--
