Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE563BFA58
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jul 2021 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhGHMj0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jul 2021 08:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhGHMj0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jul 2021 08:39:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3503C061574
        for <linux-pwm@vger.kernel.org>; Thu,  8 Jul 2021 05:36:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1TGj-0002ZE-Fd; Thu, 08 Jul 2021 14:36:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1TGh-0003Hy-Je; Thu, 08 Jul 2021 14:36:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1TGh-00085v-If; Thu, 08 Jul 2021 14:36:39 +0200
Date:   Thu, 8 Jul 2021 14:36:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Baolin Wang <baolin.wang@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>, kernel@pengutronix.de,
        Orson Zhai <orsonzhai@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH 0/5] pwm: Ensure configuring period and duty_cycle isn't
 wrongly skipped
Message-ID: <20210708123639.vrck33kc534yrnsq@pengutronix.de>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sylzshedl32pjjne"
Content-Disposition: inline
In-Reply-To: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sylzshedl32pjjne
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Jul 01, 2021 at 10:27:50AM +0200, Uwe Kleine-K=F6nig wrote:
> Geert Uytterhoeven found a regression in one of my patches. The same
> problem exists in several further commits. The respective drivers are
> fixed in this series.
>=20
> The affected commits for the first patch is already in v5.4, so this
> patch should maybe backported to stable.
> The others are in Thierry's for-next branch only.

These four broken patches were now included in your pull request to
Linus for v5.14-rc1 but these fixes were not. I wonder that the
regression Geert reported made you back out the offending commit but you
didn't care for the four identical problems in pwm-spear, pwm-tiecap,
pwm-berlin and pwm-ep93xx. Did you miss this series?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sylzshedl32pjjne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDm8U4ACgkQwfwUeK3K
7An6TQf7Bxv/ao6f+LZt7LQKvssT1ao9Iny/JDAwdfm7av7Exz7mdkA+MYt5Z1K5
hZQaJavpt7QznXaHT6n5wkIjFPCx0D+KW9epVYOE0/60dlrGZdaBEMAbVVqkQt0q
rJmyxGgTHPPrnCzltI7IiOMM7XlxA9pwARqPuAvsb42H7cf6Fxwnm7Qczz+uRA6v
BM/cNjzn8QMu64RiH62ke5e+/qHnPK3kjTzebnfLywTOts8O49y3+vbXasbyalRN
OX0JYpLB61b4Ywxumw2OlC0kYVdKGEZEqAfZgOUR0TkGFvJ3Usl/+RxwDYCeYqI2
04OgDIFQChmBgdOMzyrONRoVSm4spg==
=ZHB7
-----END PGP SIGNATURE-----

--sylzshedl32pjjne--
