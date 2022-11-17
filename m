Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B592662DA2D
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 13:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiKQMFc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 07:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbiKQMFb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 07:05:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B6697EA
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 04:05:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovddt-00004u-CQ; Thu, 17 Nov 2022 13:05:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovddr-004qDM-MR; Thu, 17 Nov 2022 13:05:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovddr-00HGfE-Oa; Thu, 17 Nov 2022 13:05:15 +0100
Date:   Thu, 17 Nov 2022 13:05:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: pwm: allwinner,sun4i-a10: Add F1C100s
 compatible
Message-ID: <20221117120515.i7vzdpa77r7ygcpn@pengutronix.de>
References: <20221101141658.3631342-1-andre.przywara@arm.com>
 <20221101141658.3631342-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7onye5iizwfwdbu"
Content-Disposition: inline
In-Reply-To: <20221101141658.3631342-2-andre.przywara@arm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--m7onye5iizwfwdbu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 02:16:50PM +0000, Andre Przywara wrote:
> The PWM controller in the Allwinner F1C100s series of SoCs is the same
> as in the A20 SoCs, so allow using that as the fallback name.
>=20
> Join the V3s compatible string in an enum on the way.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Similar to patch #2 I assume this will not go via the PWM tree and so
mark the patch as handled-elsewhere in the PWM patchwork.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m7onye5iizwfwdbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2I3gACgkQwfwUeK3K
7AlY7Qf/a8NRTQjZReKlvl3uz8NPSl8gjkBCpUY3UoHOnQTbTsnQPke4/VieByvO
/P5k+ur3xUYiIHCDXIXD4g91NwJeTZbPPnRI+4ay/NxKq+JjL5RJXBcAqYqTkown
fVVWue1XCiVPsT6V413HnTD0ceaNa+HikZaQ3pUykbepRO9N7WMInsH7f0vBQnu+
QUZmd6iVGEo6nJn+Mhs12Ayc12fz8Q2c20pINthyriUHulvUy5xguPnHr5SYvubp
1z1mx1SZKyorUueL0ixNZn4U9C7WYhnBbqp/1S8Enx7yIiHrZyhLQXFlFmRcyAZl
/Pb/fodT1Vs/97anua8ZO14Vw1jTCg==
=JEnp
-----END PGP SIGNATURE-----

--m7onye5iizwfwdbu--
