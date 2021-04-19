Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCDA364A93
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Apr 2021 21:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhDST3w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Apr 2021 15:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbhDST3v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Apr 2021 15:29:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9626C06174A
        for <linux-pwm@vger.kernel.org>; Mon, 19 Apr 2021 12:29:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lYZa2-0004Ky-2T; Mon, 19 Apr 2021 21:29:10 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lYZa0-0006jm-Tw; Mon, 19 Apr 2021 21:29:08 +0200
Date:   Mon, 19 Apr 2021 21:29:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: Fix duty cycle calculation in .get_state()
Message-ID: <20210419192908.w2crmmiermdjenrf@pengutronix.de>
References: <20210418205747.1488248-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k66s6ncyuy7fwkep"
Content-Disposition: inline
In-Reply-To: <20210418205747.1488248-1-uwe@kleine-koenig.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--k66s6ncyuy7fwkep
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Apr 18, 2021 at 10:57:47PM +0200, Uwe Kleine-K=F6nig wrote:
> -		tmp =3D (u64)cdty * NSEC_PER_SEC;
> +		tmp =3D (u64)(cdty - cprd) * NSEC_PER_SEC;

This is wrong, it must be cprd - cdty. I will send a fixed patch
together with another patch that improves precision of _apply.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k66s6ncyuy7fwkep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB92gEACgkQwfwUeK3K
7Am2Fwf/XiQ3NJ9Emphh9kHY3YMPedMfj01nZj5OwpXqT3Q26SLbVwe5P0m0pxCa
l4nsnFPLnbVVDTlM5UgQ6jvfIpusv5dTCcWCzPeM4+CUbuyH1KEuLFuAgUjS9Xz2
M/8xZ3se3wZx7zDAxmFSXboWt+rt2zfgPncvGruRIXUehdDTGZBdlryS/DxHGge2
h+VaxftJLi/8D+JKordF7PoDMnd9FkYmJcypeZ42iN9LGkr6I6+9Ps0OkRoVvWm+
2Cr8OyzGfCRJOHxIHRI0DR8Vb+zyQV4kvx6XKQbLpnsufY5z7zJiGIY83E69/HlK
paFKaKLgpXn166yM12imXUWyyNmL9g==
=OPWL
-----END PGP SIGNATURE-----

--k66s6ncyuy7fwkep--
