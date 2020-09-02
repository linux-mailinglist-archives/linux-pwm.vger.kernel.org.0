Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044A325A636
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 09:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIBHOI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIBHOI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 03:14:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B1C061244
        for <linux-pwm@vger.kernel.org>; Wed,  2 Sep 2020 00:14:08 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMxw-0003yr-OC; Wed, 02 Sep 2020 09:13:56 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMxw-0007za-AF; Wed, 02 Sep 2020 09:13:56 +0200
Date:   Wed, 2 Sep 2020 09:13:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/6] pwm: sifive: Simplify with dev_err_probe()
Message-ID: <20200902071356.5qxsit745xnpcq7g@pengutronix.de>
References: <20200826144747.9436-1-krzk@kernel.org>
 <20200826144747.9436-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vqfietzmphnlidcc"
Content-Disposition: inline
In-Reply-To: <20200826144747.9436-4-krzk@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vqfietzmphnlidcc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 04:47:45PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vqfietzmphnlidcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9PRjEACgkQwfwUeK3K
7Am3ngf9EhzuqEYogHP66J3qLjiTZkLGOydaBY1+zWND5h733JJpu6S3D0ZvDeba
5qQ9BhpSTfMTZBwRWmKsXkR+JQ/L7r5pm+qT4c6Qt4tiX3BK42XaIkmgXBsnN6se
S/fo1GCr6sKTrQFmBoynaZA2qo6+ECDAclJVy0/Od14DivhkCd2FPNfOjIsNWun8
na90Bhbwtvd+RZtGnec5Z49Jy5dL5eonWXidiKT5diOSBWgOapB08LrNxbAtIbPT
kmY9maP6NYl+Iwdo39siN0Rw1Pe6NWtDti8VD+8GIr7TxBrcUbI3etANaFg1XXQY
1ZsWNC3Szpru4KUooANUfwLuE0kE1w==
=8ydu
-----END PGP SIGNATURE-----

--vqfietzmphnlidcc--
