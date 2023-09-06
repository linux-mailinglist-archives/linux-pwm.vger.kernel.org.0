Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B553A794044
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Sep 2023 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbjIFPXf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Sep 2023 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbjIFPXb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Sep 2023 11:23:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1D1989
        for <linux-pwm@vger.kernel.org>; Wed,  6 Sep 2023 08:23:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduMq-00035M-4j; Wed, 06 Sep 2023 17:22:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduMn-004SLV-58; Wed, 06 Sep 2023 17:22:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduMm-00Gted-8V; Wed, 06 Sep 2023 17:22:52 +0200
Date:   Wed, 6 Sep 2023 17:22:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     claudiu.beznea@tuxon.dev, thierry.reding@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH -next 0/2] pwm: Remove redundant of_match_ptr() macro
Message-ID: <20230906152252.k2jkjekhj2jhlkeb@pengutronix.de>
References: <20230810074258.2390629-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="joqgxqjwcnphyxyl"
Content-Disposition: inline
In-Reply-To: <20230810074258.2390629-1-ruanjinjie@huawei.com>
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


--joqgxqjwcnphyxyl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 03:42:56PM +0800, Ruan Jinjie wrote:
> Since these pwm drivers depend on CONFIG_OF, there is
> no need to wrap the macro of_match_ptr() here.
>=20
> Ruan Jinjie (2):
>   pwm: atmel: Remove redundant of_match_ptr()
>   pwm: omap-dmtimer: Remove redundant of_match_ptr()
>=20
>  drivers/pwm/pwm-atmel.c        | 2 +-
>  drivers/pwm/pwm-omap-dmtimer.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--joqgxqjwcnphyxyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT4mUsACgkQj4D7WH0S
/k6SNAf+K/GBjQBgmBmspxHuIkuouPXX2r1c+RKVspAS3O5kI6AeRwr45O1wG/nT
U2tjly96bHz1dnu0HdvArPQK/g4ZNLfNp+4wC5NX+S9R0eQxB/83Djmc00zoZTjc
zo1CWkgXsf/UDFRzYqiYQbiwvfSWn48vr5xZdO2GxvURngZDvd/Ak5YUUzfQmvst
ZtdYXPVUrWNr3KfJ2QpRYKBmUYq8sDfnceba3KFzkqPLtZWMBEzmZM+ph0QNoskM
13amtV1E236GhDyQpvGNLVnA6oMNxuTNfp9vy5yy0wHaxk2eoYr9eP9eDYFrvfLY
dGqPub47oulLdKBaUSmjAbXrylseeA==
=4jGr
-----END PGP SIGNATURE-----

--joqgxqjwcnphyxyl--
