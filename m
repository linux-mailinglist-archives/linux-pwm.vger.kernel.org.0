Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DC87EECE6
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Nov 2023 08:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjKQHol (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Nov 2023 02:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjKQHol (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Nov 2023 02:44:41 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652E1D52
        for <linux-pwm@vger.kernel.org>; Thu, 16 Nov 2023 23:44:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3tWf-00029F-4o; Fri, 17 Nov 2023 08:44:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3tWe-009czx-9j; Fri, 17 Nov 2023 08:44:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3tWe-002wBG-0a; Fri, 17 Nov 2023 08:44:28 +0100
Date:   Fri, 17 Nov 2023 08:44:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/1] backlight: pwm_bl: Use dev_err_probe
Message-ID: <20231117074427.q265i4y2sbvp4s55@pengutronix.de>
References: <20231117073316.2103162-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yskr37x5apjfzgbh"
Content-Disposition: inline
In-Reply-To: <20231117073316.2103162-1-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yskr37x5apjfzgbh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexander,

On Fri, Nov 17, 2023 at 08:33:16AM +0100, Alexander Stein wrote:
> Use dev_err_probe to simplify error paths. Also Let dev_err_probe handle

s/Let/let/

> the -EPROBE_DEFER case and also add an entry to

I'd s/also //

> /sys/kernel/debug/devices_deferred when deferred.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> [...]
> @@ -568,7 +570,7 @@ static int pwm_backlight_probe(struct platform_device=
 *pdev)
>  		ret =3D pwm_backlight_brightness_default(&pdev->dev, data,
>  						       state.period);
>  		if (ret < 0) {
> -			dev_err(&pdev->dev,
> +			dev_err_probe(&pdev->dev, ret,
>  				"failed to setup default brightness table\n");

Missing realign of the continuation line.

>  			goto err_alloc;
>  		}

Otherwise LGTM
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yskr37x5apjfzgbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVXGdoACgkQj4D7WH0S
/k52gQgAqzzkCjfGHhT2Ts6EMtM7m2g7hlDCJRLKdzBqq6OC/3WoAobPfbG3ZAtD
DIX7GQpU/6HgERd2N5RPPsG8l1wjGPkHxaZWam75s+dUnG1yOQ7ST1MGELWSVVmm
/Uv+DIgtulg0Tv5VjAh1Zve6Ce/+DqGrFgaAYM7qmSCUqnvbi33OiXJ18bf4fadZ
vkUqY64FSqv5lYJ48EoTkMvoz93wbkLTWF6Ss3qdHyOJn65wKx+BWeO/Fl5pkwlC
/NUGPX4i0gCHNlA4Q5d0QJqjyL6XJeP/cuD1SZ0E/xjDYvX3MuvitL+nbBiXVQXy
W1W9lCJ3ayvsiLuAWAaUUzhSMXKfOA==
=r2z0
-----END PGP SIGNATURE-----

--yskr37x5apjfzgbh--
