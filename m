Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855C7938C3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Sep 2023 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjIFJrq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Sep 2023 05:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjIFJrl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Sep 2023 05:47:41 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5CCFA
        for <linux-pwm@vger.kernel.org>; Wed,  6 Sep 2023 02:47:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdp8G-00005F-KE; Wed, 06 Sep 2023 11:47:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdp8F-004OZp-Ei; Wed, 06 Sep 2023 11:47:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdp8E-00GoSs-Nx; Wed, 06 Sep 2023 11:47:30 +0200
Date:   Wed, 6 Sep 2023 11:47:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] pwm: lpc32xx: remove handling of PWM channels
Message-ID: <20230906094730.w2igbdq75jms266o@pengutronix.de>
References: <20230717155257.2568627-1-u.kleine-koenig@pengutronix.de>
 <20230724140032.g7vriv72uuvxbohd@pengutronix.de>
 <20230728092329.i43omkxgkryui6ku@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pbwlft3iku4dnoxg"
Content-Disposition: inline
In-Reply-To: <20230728092329.i43omkxgkryui6ku@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pbwlft3iku4dnoxg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Jul 28, 2023 at 11:23:29AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Jul 24, 2023 at 04:00:32PM +0200, Uwe Kleine-K=F6nig wrote:
> > As noted by Dan Carpenter in
> > https://lore.kernel.org/linux-pwm/919cac5d-491e-4534-baed-bf813181192d@=
moroto.mountain
> > lpc32xx->chip.pwms is NULL before devm_pwmchip_add() is called so this
> > patch fixes a null pointer exception.
> >=20
> > Maybe add the following to the commit log:
> >=20
> > 	Even though I wasn't aware at the time when I forward ported that patc=
h,
> > 	this fixes a null pointer dereference as lpc32xx->chip.pwms is NULL
> > 	before devm_pwmchip_add() is called.
> >=20
> > 	Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 	Fixes: 3d2813fb17e5 ("pwm: lpc32xx: Don't modify HW state in .probe() =
after the PWM chip was registered")
>=20
> You (probably with b4's help) picked up the Fixes line. The description
> and also the Reported-by was not picked up, though.
>=20
> IMHO adding the missed bits would be beneficial.

I'd consider it important that this is added before you send the PR to
Linus for this cycle. Is this still on your radar?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pbwlft3iku4dnoxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT4SrEACgkQj4D7WH0S
/k4YmQf/bzf2AqMF3DLwFBfbXfbShLDBCUIUFMUW1rrXjs6SWMo/AT0KDMVjHB8D
5CKoRsFrHkmVd5RXlcdRVRMFF0rLVMO82WG4wvly5Jglj5CilfVTXpdRj3uByiVI
XuZhgJtFjIuxZ3NQXhqU6mMtnXhRyTnsw8s4P+2LqRjiTbtMkHesdYkq4eDf1mbr
Rc3CsoeyKxUfSUS9FxvRdoBHGaBnQsZ3jWm+avZcgYzYtOsAHuSSGeXZWHwrit89
J+ERjSQ1RMfRQuTh656EP6Ei4RsRZCrSqSkRrZScSp4xZd+/Vtxe8mmR66PcPvsj
vergh3hCi0KxLy7j+AK4BnqfsKHkEQ==
=dYG0
-----END PGP SIGNATURE-----

--pbwlft3iku4dnoxg--
