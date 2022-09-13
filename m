Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C175B6A64
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Sep 2022 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIMJMO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Sep 2022 05:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiIMJMN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Sep 2022 05:12:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA45B5809C
        for <linux-pwm@vger.kernel.org>; Tue, 13 Sep 2022 02:12:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY1xf-0000rp-TU; Tue, 13 Sep 2022 11:12:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY1xg-000SoJ-6q; Tue, 13 Sep 2022 11:12:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY1xd-000YrN-Qf; Tue, 13 Sep 2022 11:12:05 +0200
Date:   Tue, 13 Sep 2022 11:12:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Message-ID: <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ayq25s2e3amakfxs"
Content-Disposition: inline
In-Reply-To: <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
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


--ayq25s2e3amakfxs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
> On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> > Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> > on a rk3588 platform.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > No driver changes required.
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>=20
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>=20
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.

Is this a list of *new* warnings, or is the report (somewhat) orthogonal
to the actual change and you just used the opportunity that someone
touched the pwm-rockchip binding to point out that there is some cleanup
to do?

> Full log is available here: https://patchwork.ozlabs.org/patch/

Hm, that gives me a 404.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ayq25s2e3amakfxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMgSV8ACgkQwfwUeK3K
7Alq5QgAmOfz+nd/dPgkG496zmEYMnmf/JKWgKSLv7Za3H3D3b2lcrSIMq9ELHjz
n3K3IxrpSMlUnbBYfIczZujgnQtmgJIfwdQ58E77dqaF5U3xXNQwrDm8AVns2LlA
zt5YY+PuTFINuk/fM7BXHoKZlqw5vJwMb52avAkndKddXEFuS+KCR4e9eRHpd1J0
Ma7Gwoz9EHvLg7uag9pbkyeEUG3Pnd3U+d90q3rd+byShxyNECLltESxW6+HySXf
Je3LGm4VOnBmrobESRXIx50LS6LD3N5+kmnIKVBWb7b7lkVCmmPgT4CyzMasv4BA
nMSmE4ylP9K3ZONkIS2/0i/hkuRIhA==
=2uq6
-----END PGP SIGNATURE-----

--ayq25s2e3amakfxs--
