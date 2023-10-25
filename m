Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2767D6AE5
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Oct 2023 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjJYMLR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Oct 2023 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjJYMLR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Oct 2023 08:11:17 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C12137
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 05:11:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvcj2-00027m-Ld; Wed, 25 Oct 2023 14:11:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvcj1-004Alg-Ii; Wed, 25 Oct 2023 14:11:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvcj1-005x1E-9S; Wed, 25 Oct 2023 14:11:03 +0200
Date:   Wed, 25 Oct 2023 14:11:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: samsung: Fix a bit test in
 pwm_samsung_resume()
Message-ID: <20231025121103.ptck4z62wvndgdlr@pengutronix.de>
References: <e031db45-add0-4da7-97fa-dee95ee936ad@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpelnl45zfbroznb"
Content-Disposition: inline
In-Reply-To: <e031db45-add0-4da7-97fa-dee95ee936ad@moroto.mountain>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zpelnl45zfbroznb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dan,

On Wed, Oct 25, 2023 at 02:57:34PM +0300, Dan Carpenter wrote:
> The PWMF_REQUESTED enum is supposed to be used with test_bit() and not
> used as in a bitwise AND.  In this specific code the flag will never be
> set so the function is effectively a no-op.
>=20
> Fixes: e3fe982b2e4e ("pwm: samsung: Put per-channel data into driver data=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

@Thierry: e3fe982b2e4e is currently in your for-next branch. So it would
be good to get Dan's patch into your PR for 6.7-rc1.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zpelnl45zfbroznb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU5BdYACgkQj4D7WH0S
/k5c4Qf8DMLh//DxSj4/1JTd7zwD+4SRK8uIst1TlaY4J5LAYvtuS71ekVCZRAWs
UmnHnCRph9cO0t/iO5ByLUpMCUkFl1pscve+VBq68SuMx+r75vMpbNjYkZkf0vRq
tvsJehuVargiPvCLhGPU0EEIh5NmnUPClt9PRWa64HpiSmJDy0iCk1hlmDIEzMtH
/rKqE2hj36QOuwEK/kv/YOVLQdlVU8SN+ZmNr8WjsA9Wyb+e/G6tWR2VIF3hiv35
s+k8JY9CBlIzO06pzjpvy7tqcgiAv4/klV2utLT2DXs+f1Pnlo1k8+ui8cpkiUKY
OyF69dT6Q1rHzu3CYI0BB1Vrcss1UA==
=2irA
-----END PGP SIGNATURE-----

--zpelnl45zfbroznb--
