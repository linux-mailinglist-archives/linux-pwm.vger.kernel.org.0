Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6B6295A0
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 11:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiKOKTw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 05:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiKOKTv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 05:19:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B6E13D5B
        for <linux-pwm@vger.kernel.org>; Tue, 15 Nov 2022 02:19:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1out2S-0004Zs-0S; Tue, 15 Nov 2022 11:19:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1out2M-004QA1-Lx; Tue, 15 Nov 2022 11:19:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1out2M-00GlgE-O7; Tue, 15 Nov 2022 11:19:26 +0100
Date:   Tue, 15 Nov 2022 11:19:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 02/10] ARM: dts: suniv: f1c100s: add PWM node
Message-ID: <20221115101926.dldj6ralahdzhj7k@pengutronix.de>
References: <20221107005433.11079-1-andre.przywara@arm.com>
 <20221107005433.11079-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lxwt463hioqp4pnu"
Content-Disposition: inline
In-Reply-To: <20221107005433.11079-3-andre.przywara@arm.com>
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


--lxwt463hioqp4pnu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 12:54:25AM +0000, Andre Przywara wrote:
> The Allwinner F1C100s family of SoCs contain a PWM controller compatible
> to the one used in the A20 chip.
> Add the DT node so that any users can simply enable it in their board
> DT.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I checked "by hand" that this matches the modified binding in patch
01/10.=20

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I assume the whole series will go in via a tree different from the PWM
tree? While this is Thierry's area of maintenance, I'd be surprised if
he had concerns about that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lxwt463hioqp4pnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNzZ6sACgkQwfwUeK3K
7AkfMQgAnGZLbY2KDdJo+eSPu2lbPN2t+rPkFSrwzxYE8QAqxSxSdYk03ufzCM+M
0mkVEhyDwd72Ly17nYewlEtpuPYBr3zd8n+u3YeHxEL8JMz4+Ae25H2+t2hvWx6X
l5m/xHBnBo+4/u2QKJfuoduPeER1N92JBJEL1oy0ulAZ3iTRMuxmQn/FqtO7Tce7
zQTKNb8/LMfbfQZM4YgasWAu0vnRjmvjyEip0WP5AGHEyzAHxcCROu2Dea+4kaEP
Ngh2KzKWu8MwdxTe9ewcLlvhmsD4OlVM5MVtIU3p82kHn6mfzzerYsidTuMBDWfj
ayxajd3hkG96nTnz9WhF9aRXuxUwhw==
=mcM9
-----END PGP SIGNATURE-----

--lxwt463hioqp4pnu--
