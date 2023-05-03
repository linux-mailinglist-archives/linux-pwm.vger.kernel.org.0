Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C366F5FFE
	for <lists+linux-pwm@lfdr.de>; Wed,  3 May 2023 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjECUYt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 May 2023 16:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjECUYt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 May 2023 16:24:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02B83DD
        for <linux-pwm@vger.kernel.org>; Wed,  3 May 2023 13:24:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1puJ1i-0005fz-7Y; Wed, 03 May 2023 22:24:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1puJ1g-000uKP-NG; Wed, 03 May 2023 22:24:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1puJ1f-0013Mf-Rp; Wed, 03 May 2023 22:24:35 +0200
Date:   Wed, 3 May 2023 22:24:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: pwm-meson: fix handling of period/duty if greater
 than UINT_MAX
Message-ID: <20230503202435.qbifdbl5a7soj3kx@pengutronix.de>
References: <1d1a8ede-e789-bc4d-2dcd-9d06d2df4061@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fluqfvpoezloyp5b"
Content-Disposition: inline
In-Reply-To: <1d1a8ede-e789-bc4d-2dcd-9d06d2df4061@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fluqfvpoezloyp5b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

On Wed, May 03, 2023 at 09:58:17PM +0200, Heiner Kallweit wrote:
> state->period/duty are of type u64, and if their value is greater than
> UINT_MAX, then the cast to uint will cause problems. Fix this by
> changing the type of the respective local variables to u64.
>=20
> Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally=
")
> Cc: stable@vger.kernel.org
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks!
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fluqfvpoezloyp5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRSwwIACgkQj4D7WH0S
/k50Sgf9EUWXO3l8kCIMdkm7aFMBe7XeGeanIn6U09GFEX4nY/VIIuBmGBJgnPbY
OYE/f2t2xq51gQqssP/XM/jpxYPEzay6xbvn6Yf4Y1+FGx6qMkmxP1c5MgBGz8ch
kTqyxNuy7MMk1BmexxffUytJpRh/YIn0v+s+dXx6OJJWwmfhRhDm35hMDMrPI778
qCBaoyRJBEdv/TulmkMdjQ+I9BFyio9C766hlfcOeD82CUYts1QYwdS48mpRFmu4
ttDVQS+uC1ZhY9yf2S4T15jsaR5g5Df2EzzyN/8eJQrhP8FwCVHMd0ydyZxguBvN
BXqyME/XiuY8NvvHQAor5xLRt1idQQ==
=enU3
-----END PGP SIGNATURE-----

--fluqfvpoezloyp5b--
