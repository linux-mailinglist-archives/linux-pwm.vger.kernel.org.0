Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E87171795D
	for <lists+linux-pwm@lfdr.de>; Wed, 31 May 2023 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjEaIBJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 May 2023 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjEaIAF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 May 2023 04:00:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F51132
        for <linux-pwm@vger.kernel.org>; Wed, 31 May 2023 00:59:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Gjp-0003UE-OC; Wed, 31 May 2023 09:59:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Gjn-0043Za-Fr; Wed, 31 May 2023 09:59:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Gjm-009kON-DJ; Wed, 31 May 2023 09:59:18 +0200
Date:   Wed, 31 May 2023 09:59:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: imx: add i.MX8QXP compatible
Message-ID: <20230531075918.3xtylhqrjfsnk7wp@pengutronix.de>
References: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="swgqlbfrowows64z"
Content-Disposition: inline
In-Reply-To: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--swgqlbfrowows64z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 10:21:07AM +0200, Alexander Stein wrote:
> i.MX8QXP compatible is missing in the list, add it.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--swgqlbfrowows64z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR2/lUACgkQj4D7WH0S
/k4v6wf/SSWY138xApCdaZKv9WSQj5sOliF3TovHROZEkJ/YSfxJUpSRxxn2tB9V
+QpyLJLS0yFXjzGqWXbhx5EGgIlZacwVaDftSqkbe6QLK1icALon3YWTkdoQ3PWB
ILtCTOmlz788oG6bJuDVSOSdkdgALSpDNA4A/0LgGekDg91KF/mt4U9H5X3RVLuJ
0LT7Pc7W1cg9N9crxwvYnFG+NQNLkupNKqmFBNpwgPqc/7NHEskXK0oxzXM+dITp
VFGfrxy03PoS+okalCzRq7EucoVN3RKroe/ev9xd6nj4aQkbjUY/KKS5tc0Vw7Pm
Kf4OlVCo9SLNlOhJYdIAEat2H39y8g==
=eXGj
-----END PGP SIGNATURE-----

--swgqlbfrowows64z--
