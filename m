Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA9769A1C
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Jul 2023 16:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGaOvq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jul 2023 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjGaOvp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jul 2023 10:51:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB300DB
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jul 2023 07:51:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQUFA-0008Qa-6S; Mon, 31 Jul 2023 16:51:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQUF8-0009HZ-J9; Mon, 31 Jul 2023 16:51:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQUF7-009LwZ-L8; Mon, 31 Jul 2023 16:51:29 +0200
Date:   Mon, 31 Jul 2023 16:51:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: pwm: rockchip: Document rv1126-pwm
Message-ID: <20230731145129.mrrkb6tcuvlpmxan@pengutronix.de>
References: <20230731103518.2906147-1-jagan@edgeble.ai>
 <20230731103518.2906147-2-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pw7azdqrl3tex3z3"
Content-Disposition: inline
In-Reply-To: <20230731103518.2906147-2-jagan@edgeble.ai>
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


--pw7azdqrl3tex3z3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 04:05:06PM +0530, Jagan Teki wrote:
> Document pwm compatible for rv1126 which is fallback compatible
> of rk3328-pwm group.
>=20
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Should this go in via the pwm tree, or together with the other patches
via rockchip?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pw7azdqrl3tex3z3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTHynAACgkQj4D7WH0S
/k6Oswf+NrRkCSIkCjS0PNm/4XljpGTPt7t/xZod4oajzSRm5rrn5u9xsuToJ/Rw
maqCge4jIZj81PVgYgBxcL80AS7w8PEHeT3F42RH0Q55eG+rvfdrx31zp8ZYhejO
YyakgUW1zKinFx26KJYUGWOmqxBty4Kt2vFiTvMpJx2Pe8vWYJAOw/4KcSnveh73
uudNJPauEVLrz7j7QOxwr0sK6xiJacTjHsfbV0SxH5sW8tUW+6V5WaPwTKEjHwn6
l8q21z1pOdVJUh/xFTJI/NNf3CkZENPnA4ILEg4SJUF9azMe02kt2mIVESyol/Vs
UqDbmTn1ZulIygN86BUTCR10n+sCFQ==
=YcxI
-----END PGP SIGNATURE-----

--pw7azdqrl3tex3z3--
