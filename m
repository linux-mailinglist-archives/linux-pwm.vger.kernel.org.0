Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7777C7C7E6B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 09:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjJMHMq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMHMq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 03:12:46 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42659A9
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 00:12:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrCLi-0006cS-Ag; Fri, 13 Oct 2023 09:12:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrCLg-001LHW-Fe; Fri, 13 Oct 2023 09:12:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrCLg-00FOqd-6A; Fri, 13 Oct 2023 09:12:40 +0200
Date:   Fri, 13 Oct 2023 09:12:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pwm: samsung: Document new member .channel in struct
 samsung_pwm_chip
Message-ID: <20231013071240.d4d5cnr25q4ezatv@pengutronix.de>
References: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ff4z2vkwr6lxehao"
Content-Disposition: inline
In-Reply-To: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ff4z2vkwr6lxehao
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Oct 12, 2023 at 11:02:29PM +0200, Uwe Kleine-K=F6nig wrote:
> My earlier commit reworking how driver data is tracked added a new
> member to struct samsung_pwm_chip but failed to add matching
> documentation. Make up leeway.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310130404.uQ33q5Dk-lkp@i=
ntel.com/
> Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data=
")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I forgot to mention: Feel free to squash this into 4c9548d24c0d. I guess
you have to rewrite your for-next anyhow as the commits you took from my
PR and rebased on your for-next lack your S-o-b.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ff4z2vkwr6lxehao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUo7ecACgkQj4D7WH0S
/k5ZuQf+KolNeWfl7PqqToTN0zx7clRq0BvbqOyuVGvxoRUS49GUO3Gck4xNU+pJ
+ff3Ba9LrUbaIi4zt21sWc7Fv2LSGGCtkf99486xA18aJ/FNeLk+MXGnS/jNNB5Q
3y3ZhOUIcdV4T3SrCkYdL0/14jILGlDFINw/18xEYVrFg+drkRbRQinDkOIbW3Ep
vRAeVy9IiCyR/MUDVMSvkZXUacXkyBvfCxYrDW59DzyPVElj9Hdz7oMGIsl8wua/
Lm9cMQ+K5YrUGSNJWLnTTy2Ycykyo75iU89J0wyIaaM6NUD03K4RsOfmFv7VuGej
1lD5813SS/iWPwSv6SJ3Yr3B1BuDuQ==
=o57V
-----END PGP SIGNATURE-----

--ff4z2vkwr6lxehao--
