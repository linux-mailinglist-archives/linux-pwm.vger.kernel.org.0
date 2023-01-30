Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845AF6817B6
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jan 2023 18:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjA3Rfx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Jan 2023 12:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbjA3Rfh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2023 12:35:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048993A590
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jan 2023 09:34:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pMY3P-0006Mb-La; Mon, 30 Jan 2023 18:34:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pMY3P-001W3u-3X; Mon, 30 Jan 2023 18:34:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pMY3N-00H83d-Ew; Mon, 30 Jan 2023 18:34:49 +0100
Date:   Mon, 30 Jan 2023 18:34:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel: drop unused header
Message-ID: <20230130173449.b4szm5lgz54j3jje@pengutronix.de>
References: <20210909080903.307314-1-u.kleine-koenig@pengutronix.de>
 <77464f22-7017-9200-e965-e3e3c8baf2a6@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpep75v24mmorf5s"
Content-Disposition: inline
In-Reply-To: <77464f22-7017-9200-e965-e3e3c8baf2a6@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cpep75v24mmorf5s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Mon, Jan 30, 2023 at 06:29:34PM +0100, Nicolas Ferre wrote:
> On 09/09/2021 at 10:09, Uwe Kleine-K=F6nig wrote:
> > Since commit 52eaba4cedbd ("pwm: atmel: Rework tracking updates pending
> > in hardware") the driver doesn't make use of mutexes any more, so the
> > header defining these doesn't need to be included.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> It looks like this (trivial) patch was forgotten for some time even if Ac=
ked
> by several of us: aka ping.

Hmm, it's in the mainline since 5.16-rc1 as commit 6f897a108508.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cpep75v24mmorf5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPX/7YACgkQwfwUeK3K
7AlFHAf/SDvX9BCfXeJit+nxDUZkYX0TFmFvLW8+28Jo7+ldpAmOa2MjW5UezJ8Z
uzGrWXfE50RuEyMJWboOAGHTC6QSifqmrKSlkh44ba3FI3t+ZIildl+uceuelxJQ
WzC/NAJW7ewZH6HnP/cJO1hQSVgfGWAUR0+mp6uE2hctt3qbtGtSpP2LGEwVIndw
dVgoA/eKJDsyNJcxi0OE+iupN0+vapm6wgWSV9b+460QvK8wAYSMqUxHSnxe+oYf
TGOo0GEgHRSqxMrC5UzOhdbTjh1NxjC6pWwLm5OR7leyeG7u8esIbaoO0HNyM0gE
oqlU0ZMk4hmqGs/aW3ZD7mZ//5aT7g==
=xdd2
-----END PGP SIGNATURE-----

--cpep75v24mmorf5s--
