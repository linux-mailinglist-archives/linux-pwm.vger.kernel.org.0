Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAF7668CC
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 11:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjG1J1H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjG1J0o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 05:26:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D61B8
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 02:23:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPJh6-0006kV-BJ; Fri, 28 Jul 2023 11:23:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPJh4-002fzO-M8; Fri, 28 Jul 2023 11:23:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPJh4-008Skf-1d; Fri, 28 Jul 2023 11:23:30 +0200
Date:   Fri, 28 Jul 2023 11:23:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] pwm: lpc32xx: remove handling of PWM channels
Message-ID: <20230728092329.i43omkxgkryui6ku@pengutronix.de>
References: <20230717155257.2568627-1-u.kleine-koenig@pengutronix.de>
 <20230724140032.g7vriv72uuvxbohd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7sndqjs2oli3ly6y"
Content-Disposition: inline
In-Reply-To: <20230724140032.g7vriv72uuvxbohd@pengutronix.de>
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


--7sndqjs2oli3ly6y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Jul 24, 2023 at 04:00:32PM +0200, Uwe Kleine-K=F6nig wrote:
> As noted by Dan Carpenter in
> https://lore.kernel.org/linux-pwm/919cac5d-491e-4534-baed-bf813181192d@mo=
roto.mountain
> lpc32xx->chip.pwms is NULL before devm_pwmchip_add() is called so this
> patch fixes a null pointer exception.
>=20
> Maybe add the following to the commit log:
>=20
> 	Even though I wasn't aware at the time when I forward ported that patch,
> 	this fixes a null pointer dereference as lpc32xx->chip.pwms is NULL
> 	before devm_pwmchip_add() is called.
>=20
> 	Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 	Fixes: 3d2813fb17e5 ("pwm: lpc32xx: Don't modify HW state in .probe() af=
ter the PWM chip was registered")

You (probably with b4's help) picked up the Fixes line. The description
and also the Reported-by was not picked up, though.

IMHO adding the missed bits would be beneficial.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7sndqjs2oli3ly6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTDiQsACgkQj4D7WH0S
/k6EpwgAibkclv7Yoj6lxwHwEtyV5pwH0UlAkcP07e4s0PpEZ1bTjwtrdR2Uixic
5LIATA1QfBbQQt7HDb4gneBPVFUjSJH7VnVNoJf3FgnJjOyOrnqXeyKYGvbtekiT
IxrQaTJBrpaw9gMKELKg8X2A+gSayTKOfatWPCD1/NTSUtbDwx8Kr4SKQdMPJJeA
K9mkRyZmwZzU4QcmR5OX1MtLNr6xH48bLQugc8i8wdqG1g53u2bJb/uevMOmYPWa
EK5zHgIb8xTfkyzEl1de0JUXm+8KcGIDA/pZslO0/br65JJMf+4DDgUE9RgzMPUE
c6s+GIrAEW0FvsUN3ixIebGMsDEvZw==
=5mUz
-----END PGP SIGNATURE-----

--7sndqjs2oli3ly6y--
