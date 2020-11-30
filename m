Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46162C85E8
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 14:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgK3Nwa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 08:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgK3Nwa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Nov 2020 08:52:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD7BC0613D2
        for <linux-pwm@vger.kernel.org>; Mon, 30 Nov 2020 05:51:50 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjjaf-0004G2-9c; Mon, 30 Nov 2020 14:51:41 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjjaW-0005Ft-Aa; Mon, 30 Nov 2020 14:51:32 +0100
Date:   Mon, 30 Nov 2020 14:51:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] gpio: mvebu: fix potential user-after-free on probe
Message-ID: <20201130135130.rynozhii4yfxtmdh@pengutronix.de>
References: <c27a61d66a9ec4e52e0d1820ce9528ffa18ca539.1606743203.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgzvyorglz6jroky"
Content-Disposition: inline
In-Reply-To: <c27a61d66a9ec4e52e0d1820ce9528ffa18ca539.1606743203.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xgzvyorglz6jroky
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2020 at 03:33:23PM +0200, Baruch Siach wrote:
> When mvebu_pwm_probe() fails IRQ domain is not released. Move
> mvebu_pwm_probe() before IRQ domain registration.

And now if something with IRQ domain registration fails the pwm stuff
isn't freed?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xgzvyorglz6jroky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/E+N8ACgkQwfwUeK3K
7AmtiAf/TGD7iUvEMnSQDJnSbql4vYUXWxtZyPURXCgLQd65gwCMS6Ci+FM7gjwZ
8kDl77iq1LaOfCEZexol9TnvxwdlYEcvdUxybvA/lJDseo3sIxzG6Lt2Wm2Tf+sX
sElXY+/dsKCKz7WVtnXQPcRBQTKNyOdseopnaU6qMDdEHT/Q6MknpnCMkDHxIfTh
crJgNQkU1aQevmuwIpnGDs6kuzsHpEMpcMxMY83VzUpY+0CwB+yL2yjgkt3Qifw3
ERH+jqsiaJXGvloIHntCDMVcH4CZ0C4L+Jlehdysv/+D6VN/DSwiTu4kAzo2WXDX
gmB1SAjG7p7SgWtwUh7CajOgaSU84w==
=gN0J
-----END PGP SIGNATURE-----

--xgzvyorglz6jroky--
