Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1131263A32E
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Nov 2022 09:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiK1IfI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Nov 2022 03:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiK1IfG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2022 03:35:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735CF17AB5
        for <linux-pwm@vger.kernel.org>; Mon, 28 Nov 2022 00:35:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZbS-0006zr-L5; Mon, 28 Nov 2022 09:35:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZbP-000mPo-0P; Mon, 28 Nov 2022 09:34:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZbO-000sPB-Uc; Mon, 28 Nov 2022 09:34:58 +0100
Date:   Mon, 28 Nov 2022 09:34:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 2/2] drivers: pinctrl: renesas: Add RZ/G2L POEG driver
 support
Message-ID: <20221128083458.dxj3vsxpxa2xyxap@pengutronix.de>
References: <20221111194059.718154-1-biju.das.jz@bp.renesas.com>
 <20221111194059.718154-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ex4m54enwiwrlrh"
Content-Disposition: inline
In-Reply-To: <20221111194059.718154-3-biju.das.jz@bp.renesas.com>
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


--7ex4m54enwiwrlrh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2022 at 07:40:59PM +0000, Biju Das wrote:
> The output pins of the RZ/G2L general PWM timer (GPT) can be disabled
> by using the port output enabling function for the GPT (POEG).
>=20
> This patch adds basic support using s/w control through sysfs=20
> to enable/disable output from GPT.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

PSA: There is nothing in this patch that is relevant for PWMs, so I'm
marking it as "handled-elsewhere" in the PWM patchwork. I guess the
series was sent to the PWM list to give some context for the series "Add
support for linking gpt with poeg"
(https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D327828&state=
=3D*)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7ex4m54enwiwrlrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEcq8ACgkQwfwUeK3K
7AmdlAgAkfsScIb7tA0S4ihxTBvBI+fu8xIGm8CCLVHEO64YX9JPA8fjO/ltTLix
LYEFPbJub89P+5oMWVOowwP1RzoxFmWL8+rE4iIc/FqvQWGvUDViEEiYO0cE6N4J
KvFT2tO/6FE+2jbqnMYeJXw/yvVy2//hunpwDnN49cEhWMAJ35SFQK15aqiDYjns
Pi321KgWFI63Vrz97Olz2caq5JCG3c4BkcbASB2c2GH/1gqDCiWSaDhHkdosvTWd
QMOtwFy/mDqtLaXkXjzLGqj4CeYuz2NhJ/hoVplmyGuSYlrEJbe6y/rpR4z4YhMe
YMIVpgxCc4pNe7BAOZ4Thp5Fs0qXAQ==
=VL0y
-----END PGP SIGNATURE-----

--7ex4m54enwiwrlrh--
