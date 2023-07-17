Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15E27566CA
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jul 2023 16:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGQOtt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Jul 2023 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQOtt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jul 2023 10:49:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5A4B2
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jul 2023 07:49:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLPXg-0006W8-DH; Mon, 17 Jul 2023 16:49:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLPXf-000A0Y-E2; Mon, 17 Jul 2023 16:49:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLPXe-005cMq-PU; Mon, 17 Jul 2023 16:49:38 +0200
Date:   Mon, 17 Jul 2023 16:49:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] gpio: mvebu: Make use of devm_pwmchip_add
Message-ID: <20230717144938.wxv37qzziq2bwrmc@pengutronix.de>
References: <20230717142743.2555739-1-u.kleine-koenig@pengutronix.de>
 <ZLVSyzMPio+jh7O5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmzlehpmq5mxgofg"
Content-Disposition: inline
In-Reply-To: <ZLVSyzMPio+jh7O5@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jmzlehpmq5mxgofg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 05:40:11PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 04:27:43PM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> > Note that irq_domain_remove() also isn't called so there is another
> > resource leak introduced by 812d47889a8e ("gpio/mvebu: Use
> > irq_domain_add_linear")
>=20
> I believe it's only theoretical issue as quite likely GPIO will be used a=
nd
> hence one can't unbound it. Or unbound is unconditional? In that case we
> have much bigger issue in the kernel.

You might want to test

	echo f1018100.gpio > /sys/bus/platform/drivers/mvebu-gpio/unbind

(where f1018100.gpio is the name of one of links in
/sys/bus/platform/drivers/mvebu-gpio#) and if that succeeds you should
consider

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a68f682aec01..620ab247abff 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1306,6 +1306,7 @@ static struct platform_driver mvebu_gpio_driver =3D {
 	.driver		=3D {
 		.name		=3D "mvebu-gpio",
 		.of_match_table =3D mvebu_gpio_of_match,
+		.suppress_bind_attrs =3D true,
 	},
 	.probe		=3D mvebu_gpio_probe,
 	.suspend        =3D mvebu_gpio_suspend,

which prevents that path and so the leak (by not providing
/sys/bus/platform/drivers/mvebu-gpio/unbind).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jmzlehpmq5mxgofg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS1VQEACgkQj4D7WH0S
/k7G+gf+K9X7IfWw5N5oyGhveTqGlA8s/v0u4njUFiDM7thEqbEaBYhdFyls2WS2
APxcqgQHlmZq8yrEayM909Dmtbcxtcf/GV77+T8WU46n5ySzqCFnhZL0alP1GhPq
L3VfgolTmahbbusGmPIU2YVtyHpoSZ18NmxYuFvKOy1/eZ7TnzxF0/UxlldzXjt9
i3JcJb/vtFwq5IySMLwDnO8s9AflS1LGqf77/i3gzA7mYMOVeNIfvIY44oyWQZ+3
8X/AIgkjTy2z4vJYtIGt0Pr/KGduXVMEAR43hM/sD3QS1sRZPZ2Ri23T24oh9AA/
eB9dLwG/OcU/JwHQt33AhizFspdylA==
=DseA
-----END PGP SIGNATURE-----

--jmzlehpmq5mxgofg--
