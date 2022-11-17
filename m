Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C1F62DA26
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 13:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiKQMEQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 07:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbiKQMEO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 07:04:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F75D5EF81
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 04:04:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdcY-0008LW-Qn; Thu, 17 Nov 2022 13:03:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdcU-004qCu-Qu; Thu, 17 Nov 2022 13:03:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdcU-00HGer-Ov; Thu, 17 Nov 2022 13:03:50 +0100
Date:   Thu, 17 Nov 2022 13:03:50 +0100
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
Subject: Re: [PATCH 2/9] ARM: dts: suniv: f1c100s: add PWM node
Message-ID: <20221117120350.kreyg7an5dtuaudr@pengutronix.de>
References: <20221101141658.3631342-1-andre.przywara@arm.com>
 <20221101141658.3631342-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nykzmius3wydfoj4"
Content-Disposition: inline
In-Reply-To: <20221101141658.3631342-3-andre.przywara@arm.com>
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


--nykzmius3wydfoj4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 02:16:51PM +0000, Andre Przywara wrote:
> The Allwinner F1C100s family of SoCs contain a PWM controller compatible
> to the one used in the A20 chip.
> Add the DT node so that any users can simply enable it in their board
> DT.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I assume this patch will go via an architecture tree (i.e. not PWM).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nykzmius3wydfoj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2IyMACgkQwfwUeK3K
7Akl7AgAlCaC0HMsIKb2oLOmds8MmfyJ0SP9xMHZsX3upV7JTeQdunQ3Al1ZukgU
xSZKXXXmuiORfqLKKge5k6dTKovJHOu3Oyj9rAFR75rGR3TZnRBXsrOkXSSJeCEy
2P4GkTUw6rxyxWqq8pfAtuZsFzWjQ86/YRkvEbwDOxoOebZnRMLKLDxeYxD0wFg1
fPd3zRzj6sF+hgEx85zeDEgsb1j26v5f0XhH44J98JMdBpUAzyvjuhvV/RLoiU8O
/ESLt7LIyvz1m0F6bInxyHWOpqDd76z0HCgHrK1FPj6bAEl9siDkXDcVPJAtKaag
TzKdGk7pBXaH5s2Wx4kvd79I59+M5g==
=iuOn
-----END PGP SIGNATURE-----

--nykzmius3wydfoj4--
