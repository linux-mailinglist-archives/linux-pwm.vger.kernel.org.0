Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65735B820E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Sep 2022 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiINHdR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Sep 2022 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiINHdQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 03:33:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570626FA05
        for <linux-pwm@vger.kernel.org>; Wed, 14 Sep 2022 00:33:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYMtS-00076d-Ep; Wed, 14 Sep 2022 09:33:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYMtS-000eOy-63; Wed, 14 Sep 2022 09:33:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYMtQ-000lNc-69; Wed, 14 Sep 2022 09:33:08 +0200
Date:   Wed, 14 Sep 2022 09:33:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Message-ID: <20220914073305.4zorbsve75raiygd@pengutronix.de>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
 <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d4hlshwof6wtcph6"
Content-Disposition: inline
In-Reply-To: <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d4hlshwof6wtcph6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 04:16:01PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Rob,
> >=20
> > On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
> > > On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> > > > Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> > > > on a rk3588 platform.
> > > >=20
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > ---
> > > > No driver changes required.
> > > > ---
> > > >  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > >=20
> > > Running 'make dtbs_check' with the schema in this patch gives the
> > > following warnings. Consider if they are expected or the schema is
> > > incorrect. These may not be new warnings.
> > >=20
> > > Note that it is not yet a requirement to have 0 warnings for dtbs_che=
ck.
> > > This will change in the future.
> >=20
> > Is this a list of *new* warnings, or is the report (somewhat) orthogonal
> > to the actual change and you just used the opportunity that someone
> > touched the pwm-rockchip binding to point out that there is some cleanup
> > to do?
> >=20
> > > Full log is available here: https://patchwork.ozlabs.org/patch/
> >=20
> > Hm, that gives me a 404.
>=20
> This is an existing problem with the rv1108 binding.
> The rk3588 does not have pwm interrupts.

I thought so, so:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d4hlshwof6wtcph6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMhg64ACgkQwfwUeK3K
7AkzOQf/UlE4uRbME2zQ6MnFx1BbofJkGfho9rOJJtyCBopDKAYsf+bqwxmNKeL/
JJn+OhgKkFgnnqDuhcxp/ObXO8s6hgc7bswXYjYLZ0suDQOnA6DaScHnuJdecNyY
p9dmbYoGxtwI1LjGifz1J8DyC3Y9v2jZi6sd6hV10RGf4W9KYzWNUzwbm9U9LZQG
G2aCxu5ilXJYhkPoUItBEzlGIyuhh9mcZ9viwPlPsC2Bf220DKVUE+wqfajFSeQ1
rkteqmsJYIGQJuCleX/gEgnCy5XoCG3J3XkiVOwoYE5S0eSlMB/WAD4PH72ViTwi
blpiE1JnAMoGaXeTLz7p8Ngd48dfJA==
=I5Ps
-----END PGP SIGNATURE-----

--d4hlshwof6wtcph6--
