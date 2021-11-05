Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1918444624C
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Nov 2021 11:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKEKnN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Nov 2021 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhKEKnJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Nov 2021 06:43:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1970C061714
        for <linux-pwm@vger.kernel.org>; Fri,  5 Nov 2021 03:40:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miwdy-0006fX-CC; Fri, 05 Nov 2021 11:40:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miwdw-0006uo-7K; Fri, 05 Nov 2021 11:40:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miwdw-0002qU-5y; Fri, 05 Nov 2021 11:40:20 +0100
Date:   Fri, 5 Nov 2021 11:40:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     daniel.thompson@linaro.org, lee.jones@linaro.org,
        jingoohan1@gmail.com, thierry.reding@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6] backlight: lp855x: Switch to atomic PWM API
Message-ID: <20211105104017.65ysrdy5nzccfzmo@pengutronix.de>
References: <YYQfThRqabp4A7Dz@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ci2ykdunk5cwiced"
Content-Disposition: inline
In-Reply-To: <YYQfThRqabp4A7Dz@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ci2ykdunk5cwiced
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 04, 2021 at 02:58:38PM -0300, Ma=EDra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
>=20
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>

LGTM,

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ci2ykdunk5cwiced
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGFCg4ACgkQwfwUeK3K
7AkWNQf/SKHSeiYd9w//qWXwmgc6r1QNVz5DIhFauWP9fpTyPfv4KUilZmt18t7E
iN+Z/4YSC+8LUj88zqTBYawZoE+DkluxSa5eVq6Uis3yynM5eEfVJVU4yyBdNJ+B
cEr3NAK0sLb49ZenYACy0MImHiDFSjTI7OPu/RBknIHsD2doU/N6kYbBI0ZxCPw/
OXbO7xH/4VMms11B+CLX6usMMh8e/yRGvVBN/y3OrjY2dY1Pl8yzKxV738slKkGi
w2Bn0Zb5pDN+fVJVUBK7mUAzp3MjA3t8QQL0L4TtJ6nvhpOWvqEGC8rVMeVfDebW
PwQqcIYSc3hRkYdQqaNkC6WwMWIfxg==
=ggPo
-----END PGP SIGNATURE-----

--ci2ykdunk5cwiced--
