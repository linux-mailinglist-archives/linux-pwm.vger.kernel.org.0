Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA46C2F47E7
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 10:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbhAMJnM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 04:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhAMJnM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 04:43:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2AC061786
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jan 2021 01:42:31 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzcfa-0006Js-N5; Wed, 13 Jan 2021 10:42:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzcfL-0002YO-A8; Wed, 13 Jan 2021 10:42:11 +0100
Date:   Wed, 13 Jan 2021 10:42:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] gpio: mvebu: make pwm .get_state closer to
 idempotent
Message-ID: <20210113094207.rh4u7zo7wf64p7uw@pengutronix.de>
References: <cover.1610529002.git.baruch@tkos.co.il>
 <1d376a3500e11d8fd2ecaf9ca345977f011079af.1610529002.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhwbnicy5okq5jkw"
Content-Disposition: inline
In-Reply-To: <1d376a3500e11d8fd2ecaf9ca345977f011079af.1610529002.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yhwbnicy5okq5jkw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2021 at 11:22:43AM +0200, Baruch Siach wrote:
> Round up the result of division in period/duty_cycle calculation to make
> the result closer to idempotent.

Maybe:

Round up the divisions in .get_state() to make applying the read out
configuration idempotent in most cases as .apply rounds down.

> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Other than that:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yhwbnicy5okq5jkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+wGwACgkQwfwUeK3K
7AnWIQf/Qx8t1FUfpewVasD2TqeWdPKyYDLuPplQjt7C2YXvER+xYusEERrV7zth
zNZ+1RYWJkNo+tpIKCH74kmm0qXm6aKauNB1L3Fb0j+lybDyKmwuu8iCXPo1ZTQJ
/BqqGepqDHEG45U73KwbplTZ6OI95R4XRSmft9rr6AqmWQ27SQI98wGd8UYDxjZy
LBHSERJ47bXJFVFVPbAzssFROuB6G7/LX9Orae7e6xkqElOfqyM8Mw8sC2d9zYXd
qOGeYHeXiKGVsAhWv512YzI0zqas/mgMPbBsHZlTgzY6W6a26ysC1PbHctPNmgMX
eKuO20tEcltYiPmxMW0iryzrwgYJcw==
=JPRR
-----END PGP SIGNATURE-----

--yhwbnicy5okq5jkw--
