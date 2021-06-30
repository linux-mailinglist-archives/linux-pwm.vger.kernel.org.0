Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE83B864F
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhF3Pih (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhF3Pih (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 11:38:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13170C061756
        for <linux-pwm@vger.kernel.org>; Wed, 30 Jun 2021 08:36:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lycFw-0005CI-LS; Wed, 30 Jun 2021 17:36:04 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lycFu-0003fc-Gl; Wed, 30 Jun 2021 17:36:02 +0200
Date:   Wed, 30 Jun 2021 17:36:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: ep93xx: Fix uninitialized variable bug in
 ep93xx_pwm_apply()
Message-ID: <20210630153600.327ff7vcrx76lw26@pengutronix.de>
References: <YNx1y8PlSLehZVIY@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vphn4jk3p3wcvnpg"
Content-Disposition: inline
In-Reply-To: <YNx1y8PlSLehZVIY@mwanda>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vphn4jk3p3wcvnpg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

this problem was found already earlier by Colin King:

	https://lore.kernel.org/r/20210629172253.43131-1-colin.king@canonical.com

I'm fine with either change.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vphn4jk3p3wcvnpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDcj10ACgkQwfwUeK3K
7AmM7wf/e97AoCAkzfOVrEkGepxK6NtmYvP59bREHrSkc6WWjRtwhe2PoHG/IzdH
aDSuq2c0fk3SAcfocPBHKg87iTOPR6sQb/f853pze5fdURgJy46DzcRT1bEjnXlf
0iSbHWiLmtYQVfidvopKrazQz/6OPxpm+1NLH6Qsia7YxZhaO/9XHJPQuXIQphq0
zfnr8jHnB25yuo32GCMb1lQg4poOVvLXpIY1IWME910jn8JT9/Ui8lUiN1bIkR9d
Hkksrq+KLHFa+opJLcLg2D9V8Y+gXycS3xmm0XU3EyUJrJc11ZPFiPgfGXl3i+Xr
ar3u5ALK5GVQG+QhxSQMC4AY/JJWIw==
=12r2
-----END PGP SIGNATURE-----

--vphn4jk3p3wcvnpg--
