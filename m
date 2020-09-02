Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0821125A62D
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 09:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBHMq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBHMq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 03:12:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5974C061244
        for <linux-pwm@vger.kernel.org>; Wed,  2 Sep 2020 00:12:45 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMwf-0003Xt-QX; Wed, 02 Sep 2020 09:12:37 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMwY-0007zI-Bc; Wed, 02 Sep 2020 09:12:30 +0200
Date:   Wed, 2 Sep 2020 09:12:30 +0200
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
Subject: Re: [PATCH 1/6] pwm: bcm2835: Simplify with dev_err_probe()
Message-ID: <20200902071230.6qfjiwt2fodlpe4a@pengutronix.de>
References: <20200826144747.9436-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="psu4zpohrt2wcrrk"
Content-Disposition: inline
In-Reply-To: <20200826144747.9436-1-krzk@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--psu4zpohrt2wcrrk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 04:47:42PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--psu4zpohrt2wcrrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9PRdsACgkQwfwUeK3K
7AkPsAgAiyyLPB/J+8+YDWXP+vSRdR1hRrNf7uDQqdZXlgJw6KwronTBpl1icHjy
JSnUWDvqfNunOY+gmKH7uzk3J3dDIEfgP+KV4ywjIqezdv2FN2rzk7p8aFNCpDLu
xkpzC+wkjYTE3TmtO/WxNLB+3awRKdhRV+TTFA6ou5JdtPHPUyr+NfEhfV8Mj0tq
mmBBPugtfFPv3+R9Rjz296rxeCZSUYwMXPCI+743154sja+NaoOusmLxd1qOmkeE
bZ/0Zq1tEjH+6mezwI5QBQDRmjkHQ3XhFbPOWvBhUabUtW2sCS5AQm9iUCuMO00j
yoadlHq9HwLTEVjT+1zfaJa3KF2q3g==
=y6tG
-----END PGP SIGNATURE-----

--psu4zpohrt2wcrrk--
