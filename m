Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3454F2AFA20
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 22:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKKVB6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 16:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVB6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 16:01:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D6C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 13:01:57 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcxFY-00040p-2B; Wed, 11 Nov 2020 22:01:52 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcxFX-00061V-2F; Wed, 11 Nov 2020 22:01:51 +0100
Date:   Wed, 11 Nov 2020 22:01:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v15 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20201111210149.3eq3nh4ki5ocyfru@pengutronix.de>
References: <cover.1604555266.git.rahul.tanwar@linux.intel.com>
 <b91a46bee54984d5ff518c9fe56744c291b1ffa4.1604555266.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3wv7flk7x7fwvyn"
Content-Disposition: inline
In-Reply-To: <b91a46bee54984d5ff518c9fe56744c291b1ffa4.1604555266.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g3wv7flk7x7fwvyn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 05, 2020 at 01:49:40PM +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> This PWM controller does not have any other consumer, it is a
> dedicated PWM controller for fan attached to the system. Add
> driver for this PWM fan controller.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g3wv7flk7x7fwvyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+sUToACgkQwfwUeK3K
7AlrwAf+OYaCa2FmFmj3Splkji3o0Nz+Zd2Vy4k7pEaUXexTB5KIT85YGtivm8v7
ThOy33mBMkFhhci7+dr1YDW4cF/Qkwy5i5D4DSi8nOgvI/7zd8G86JSGyfXDYeOn
jDZGJspvH/OsuK6xyg9w9S4iY2xwf9KHrpHnJiopHbXJdpEGNM7P9tsClMU3i8Su
S0H1QPHhcEQf9MVsNjVly8o8qhfPZz/05r4dCqev1fUDL9DAJsnUYl2bJ80VfTK1
XHd0PUvm7Wr6Ko14qF6KUtknCl7G7mqwFzrfEs57D4YZ3oDMu35GrvO3VEXGFFKa
mnO1heHL4dWCskISHt4sC/WUFJalCw==
=uG/J
-----END PGP SIGNATURE-----

--g3wv7flk7x7fwvyn--
