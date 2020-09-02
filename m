Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025CC25A62F
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 09:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgIBHND (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 03:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBHNB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 03:13:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C655C061244
        for <linux-pwm@vger.kernel.org>; Wed,  2 Sep 2020 00:13:01 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMww-0003mp-NT; Wed, 02 Sep 2020 09:12:54 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMww-0007zO-9f; Wed, 02 Sep 2020 09:12:54 +0200
Date:   Wed, 2 Sep 2020 09:12:54 +0200
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
Subject: Re: [PATCH 2/6] pwm: jz4740: Simplify with dev_err_probe()
Message-ID: <20200902071254.jp5wttf4mafu4vx2@pengutronix.de>
References: <20200826144747.9436-1-krzk@kernel.org>
 <20200826144747.9436-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="giyrzo5o5nql4osl"
Content-Disposition: inline
In-Reply-To: <20200826144747.9436-2-krzk@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--giyrzo5o5nql4osl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 04:47:43PM +0200, Krzysztof Kozlowski wrote:
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

--giyrzo5o5nql4osl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9PRfMACgkQwfwUeK3K
7AmA5wf6AyWGyofSMkZ7PZu9I86Q3K/xO/j4YDCDmBxM2xaoR7TxzMTlykocaAsX
5SZRzj5EAdiKzAXkLK+MItmdaS4cTJiEXiuOiqCx9VP0U9SaUh7RQxmWIW991E4w
ILq46UI4S01uWlfML8xsY+gBI36dvES4H89DHJ9qdgByHXiCak+d7zeqdaZ5pH9l
ISX03DrainYjS9Fcz6sUoefidT0i/pO249zRxNcepwh7Dt7/5SlT999yY7DfuH0g
OSCPe1c1SRbaexGfM6f629DDsBuiqlP4Ve0H28MHN7KQzfnlovwRHvBtyX0Wx6vQ
1G3sbH841cpFwlv+WdrLowKPL2gG+g==
=4ubX
-----END PGP SIGNATURE-----

--giyrzo5o5nql4osl--
