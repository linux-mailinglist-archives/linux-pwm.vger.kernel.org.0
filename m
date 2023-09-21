Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A747A9EA3
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Sep 2023 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjIUUGM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Sep 2023 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjIUUGB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Sep 2023 16:06:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C589198
        for <linux-pwm@vger.kernel.org>; Thu, 21 Sep 2023 12:59:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPq2-0004G9-Jg; Thu, 21 Sep 2023 21:59:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPq2-00803n-6d; Thu, 21 Sep 2023 21:59:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPq1-003iAo-Te; Thu, 21 Sep 2023 21:59:49 +0200
Date:   Thu, 21 Sep 2023 21:59:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: mxs: Document fsl,imx28-pwm
Message-ID: <20230921195950.v2kxdeb6qll5n4bu@pengutronix.de>
References: <20230921184348.290261-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uyozuakd6k32lup7"
Content-Disposition: inline
In-Reply-To: <20230921184348.290261-1-festevam@gmail.com>
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


--uyozuakd6k32lup7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 03:43:46PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> imx28 uses the same PWM block that is found on imx23.
>=20
> Add an entry for fsl,imx28-pwm.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uyozuakd6k32lup7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUMoLUACgkQj4D7WH0S
/k5Gkwf+I6vyxK+zHbSWo75PCteHXTUhDJ/L3PGqwHEiq6NzhnubAyAt+Ig/i2mW
a056oLmQcD+Zj9auEQXNKyX+2jzD9o7kTDb7/auaX/krpg6s9Pa+J9lochBIpp3l
cQmBmI/Uy3izqv/ZaMxuDP11sUu3Rf5YNaDwnShSxkoXYXpDZ/5Xx4I+J3B92HKc
I/YLPMy5NPdnEJj2IDrm/Mm1sm5G68ZMGzvuFnFanRsFBuwa9l3JQVnvNWGpTd2C
NATeLyB8AO1i3FD4R1i0es2+tS6Qb41AmvYQoXIvojWju/QUKKoqmyQCKQI9aVl1
2D5TM2KPvM3mGcuoL9n2qP85OMRXug==
=fSWK
-----END PGP SIGNATURE-----

--uyozuakd6k32lup7--
