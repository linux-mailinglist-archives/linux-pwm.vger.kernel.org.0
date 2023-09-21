Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F447A9FFC
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Sep 2023 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjIUUam (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Sep 2023 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjIUU3P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Sep 2023 16:29:15 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B224878
        for <linux-pwm@vger.kernel.org>; Thu, 21 Sep 2023 13:08:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPxq-0005Uu-N9; Thu, 21 Sep 2023 22:07:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPxo-00807b-W1; Thu, 21 Sep 2023 22:07:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPxo-003ido-Hi; Thu, 21 Sep 2023 22:07:52 +0200
Date:   Thu, 21 Sep 2023 22:07:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 2/3] dt-bindings: pwm: mxs: Document the clocks property
Message-ID: <20230921200752.c3bibaeibezppzis@pengutronix.de>
References: <20230921184348.290261-1-festevam@gmail.com>
 <20230921184348.290261-2-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mbioodsp7x3pf27k"
Content-Disposition: inline
In-Reply-To: <20230921184348.290261-2-festevam@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mbioodsp7x3pf27k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 21, 2023 at 03:43:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> The 'clocks' property is mandatory for the PWM to operate.
>=20
> Document it.

Indeed the driver does:

        mxs->clk =3D devm_clk_get(&pdev->dev, NULL);
        if (IS_ERR(mxs->clk))
                return PTR_ERR(mxs->clk);

so this is in line with the implementation.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mbioodsp7x3pf27k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUMopMACgkQj4D7WH0S
/k763gf/f8hPSXuAE/en6e4D/ydT2bEatfpYLmxAbSlXjECV7eM/RX/zE9V8rhc3
TLqG0e3JbWRU1JnFeHNYdF5vYXdJ22lpmfvLFWL0EWjT3Tzcp+d49TLYn/57BeGh
euauY8e+8jEW8c217iEnuAijGKmj66C0IbsZNQU01ACC4SwJ7FiufEHw9WLprX8V
loE0dDd+aJRi5QISznqAQYzmqj84J5JHlKewWQeAY8pEHDsA5+gwjvShQ6LCXyJL
emFX484vT8Ns8f9Fwlms7EPWMYvSs5CcC00r/qB3eprAtW8rOjRSBYlxylvn2W7l
gxBIKDqm8gf/J1fC0XRHC8P4wwmltA==
=ifJ4
-----END PGP SIGNATURE-----

--mbioodsp7x3pf27k--
