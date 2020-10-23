Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC529698D
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Oct 2020 08:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372230AbgJWGMI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Oct 2020 02:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372229AbgJWGMG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Oct 2020 02:12:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97877C0613D2
        for <linux-pwm@vger.kernel.org>; Thu, 22 Oct 2020 23:12:06 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kVqIe-00047x-IK; Fri, 23 Oct 2020 08:11:40 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kVqIc-0007Pm-9n; Fri, 23 Oct 2020 08:11:38 +0200
Date:   Fri, 23 Oct 2020 08:11:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Kamil Debski <kamil@wypas.org>
Subject: Re: [PATCH 1/4] MAINTAINERS: move Kamil Debski to credits
Message-ID: <20201023061136.cjhpuh5lye6sclf6@pengutronix.de>
References: <20201016151528.7553-1-krzk@kernel.org>
 <20201022191314.plesyizmczgdmodr@pengutronix.de>
 <20201022200925.GA2525@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64of3vfnxriskdjj"
Content-Disposition: inline
In-Reply-To: <20201022200925.GA2525@kozik-lap>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--64of3vfnxriskdjj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Thu, Oct 22, 2020 at 10:09:25PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Oct 22, 2020 at 09:13:14PM +0200, Uwe Kleine-K=F6nig wrote:
> > this series doesn't seem to be applied and looking at the list of people
> > this mail was sent "To:" it's not obvious who is expected to take it. I
> > assume it is not for us linux-pwm guys and will tag it as
> > "not-applicable" in our patchwork.
>=20
> All of the patches, including the one here, touch actually multiple
> subsystems, so if this is OK with you, I could take them through
> Samsung SoC.

I don't object. And I failed to find where pwm is touched (I assume I
didn't look carefully enough).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--64of3vfnxriskdjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+SdBUACgkQwfwUeK3K
7AkxRQf7B5uGR0Tf8DzE82B5Uy0nOOhk7weuNjW+IHxy78ekhlyQxfjS0sJ0rYc9
Z6G2m0AmEmMmDVq8u0FHZ9u6viBuXKfQ4CqlNd2UiR7olagr61pGbrSxjIwgIDA4
zSEbNILuUqqenjp6m0FGSP6HUNfUbF6pNI0XWnZELus0wST2fdIUH508b4gtlTYX
9wRzn7EMA1jzzZtqP1okoAa2C1B2CQvXXdD3YUByJruBhXGRpJ3rf26S6wW9r59x
snDtRxeFWYxgPWbyehWse1Il0R5LgdBAYfdFK0NNFG2EltMzB8vstGKpd9AEI2ka
Yn6pL8rsDumxeUoXxlK2dPArdLZwuw==
=RZQR
-----END PGP SIGNATURE-----

--64of3vfnxriskdjj--
