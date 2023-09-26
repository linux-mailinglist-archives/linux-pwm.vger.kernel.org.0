Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BCB7AE858
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Sep 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjIZIxt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Sep 2023 04:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZIxs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Sep 2023 04:53:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041ECDD
        for <linux-pwm@vger.kernel.org>; Tue, 26 Sep 2023 01:53:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql3p4-0005wb-AJ; Tue, 26 Sep 2023 10:53:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql3p3-00945a-Cn; Tue, 26 Sep 2023 10:53:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql3p3-004v36-3L; Tue, 26 Sep 2023 10:53:37 +0200
Date:   Tue, 26 Sep 2023 10:53:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] backlight: pwm_bl: Disable PWM on shutdown and suspend
Message-ID: <20230926085336.czgrztefbrstzbw7@pengutronix.de>
References: <20230926084612.2074692-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ro2xmibwou7jbzrx"
Content-Disposition: inline
In-Reply-To: <20230926084612.2074692-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ro2xmibwou7jbzrx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 10:46:12AM +0200, Uwe Kleine-K=F6nig wrote:
> Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
> per backlight toggle") calling pwm_backlight_power_off() doesn't disable
> the PWM any more. However this is necessary to suspend because PWM
> drivers usually refuse to suspend if they are still enabled.
>=20
> Also adapt shutdown to disable the PWM for similar reasons.
>=20
> Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per back=
light toggle")
> Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> Tested-by: Aisheng Dong <asheng.dong@nxp.com>

The two email addresses should actually be identical, the first one is
the right one. (Failure introduced by
https://lore.kernel.org/dri-devel/DB9PR04MB8477D4BBF1B31035789DA08680869@DB=
9PR04MB8477.eurprd04.prod.outlook.com
and picked up by b4.) Lee, can you fixup or should I resend?

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ro2xmibwou7jbzrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUSnBAACgkQj4D7WH0S
/k7WRwf/dDvCWEj1/FZjZuftRTudNH5aYZhao+yFHsI9uQuvf/PLyPG3vfZA0Qk4
URqDl1t9VHxqXecZBVjn00ymGJWMckdlldfEHNeXZVkZEOc12mUmhvZO+IChSzjy
/ToNGWiPdExYacOsb4ik8yJd6T4Q8KqtHSl1oAQEpvHYuUZw1m58ZeYJe4AWCz6s
TawOMN6cLAVpnHZDWVn0IoaQ0v5BDg8gim85FQok1wCY8ClLh+JSTw2YeV3DDTMS
lSj6xRnU7VyzOZrkrU4EQnkrI8Cqg8hwAKLH5XWVes+1Cn2F7eAqxv7YmdVoC4UO
0pRys4XYeYpdAHI2rHefNPO/TclY3w==
=SNgM
-----END PGP SIGNATURE-----

--ro2xmibwou7jbzrx--
