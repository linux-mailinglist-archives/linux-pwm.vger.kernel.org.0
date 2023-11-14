Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CE7EAF52
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjKNLjo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 06:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLjn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 06:39:43 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964C9D9
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 03:39:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rlW-0006s8-2e; Tue, 14 Nov 2023 12:39:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rlU-008yw4-SK; Tue, 14 Nov 2023 12:39:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rlU-001K1A-HH; Tue, 14 Nov 2023 12:39:32 +0100
Date:   Tue, 14 Nov 2023 12:39:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] imx8qm/imx8qxp: Support for inverted PWM
Message-ID: <20231114113932.aqidxrmg4sajfsh5@pengutronix.de>
References: <20231106151326.812099-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tpesly76tzrmhhw3"
Content-Disposition: inline
In-Reply-To: <20231106151326.812099-1-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tpesly76tzrmhhw3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 04:13:23PM +0100, Alexander Stein wrote:
> this small series adds support for inverted PWM output i.MX8QM/QXP.
> Driver is already there, but #pwm-cells needs to be adjusted in DT.
> While at it, enforce the same #pwm-cells value for all compatibles.
> [...]
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 10 ++++------
>  arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |  2 +-
>  arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    |  8 ++++----
>  3 files changed, 9 insertions(+), 11 deletions(-)

What is the merge plan here? pwm or imx? For me both options are fine,
given this only touches bindings and arch/arm64, maybe it's more
suitable to be merged by Shawn?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tpesly76tzrmhhw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVTXHMACgkQj4D7WH0S
/k7LdAf+NnQYkQGnKrZvedYT3teoz1FJiDO3bUDuCnRckIIOznKn3cv/z085oM4K
ZC2vYSScAeGtICTJWFVREt+Dd81iSb0VymgNSzh92//FOUodhMm8ljq/EYRhUAkE
Lw0Fet7virGan3nz4cj07h1ZuFU+XweObNBF6Z6VhQSUjUY91ORj1UiGZdvcle8C
xJqX9kBGqHgBuMEFIqRqJAS1dRD4rAKbBw5E1x2sEi/aljj2XHlEC85ilJ8gXswU
cYsBwKUM1XuYXb5Qmy68azlrz3SafKsfaJcoflcVrhs0omZkDFfVqK9qY96GmlzY
LI6sJfBhkC1IJfb5vvPAtTIviDuJxA==
=USdg
-----END PGP SIGNATURE-----

--tpesly76tzrmhhw3--
