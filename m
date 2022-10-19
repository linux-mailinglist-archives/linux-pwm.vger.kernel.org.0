Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43496603AA6
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Oct 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJSHaW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Oct 2022 03:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJSHaT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Oct 2022 03:30:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B8537F4
        for <linux-pwm@vger.kernel.org>; Wed, 19 Oct 2022 00:30:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3Wp-0004Xd-NQ; Wed, 19 Oct 2022 09:30:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3Wo-0003xa-QG; Wed, 19 Oct 2022 09:30:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3Wo-00917E-3s; Wed, 19 Oct 2022 09:30:14 +0200
Date:   Wed, 19 Oct 2022 09:30:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: pxa: Remove pxa_pwm_enable/disable
Message-ID: <20221019073013.fndbvhkdbhsgatky@pengutronix.de>
References: <20221003015546.202308-1-doug@schmorgal.com>
 <20221003015546.202308-2-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kg4e3lnx3ylyr5p3"
Content-Disposition: inline
In-Reply-To: <20221003015546.202308-2-doug@schmorgal.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kg4e3lnx3ylyr5p3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 06:55:42PM -0700, Doug Brown wrote:
> These functions are only acting as wrappers for clk_prepare_enable and
> clk_disable_unprepare now, so remove them to simplify the driver.
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kg4e3lnx3ylyr5p3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNPp4AACgkQwfwUeK3K
7AlJdAf/cNQz6dnPjpi7p80hspsFXC/Zx1M6nZVPdQK02VLiWiOJVDQ7ujh/fkB6
1PN/EfPvjfM2eI6Wy2HdkK9Moy2chxie0zmFbhA67i6SXWVD6KsRuJTA3lq+pfLw
RECla7J/z2alrOVZH7a8rQYdx0xbeBcqfwEIkF0zTe49/pROh7EhMDylp5nj5afz
0wKhXQYJhMnHZ4fIXKGSA3kqKzedIwtbkOWT0spGDImH5EJ1LN257Kfuxt+0HY6y
Yrll/vxR9zySHu1UNmPFXanGBXEgF729E6Ogammwe/zf+j+cQBeRnEHYiFs8cZBa
egoOPUMJcvCl1CDNisi1fhvgtJ8fXQ==
=Amt8
-----END PGP SIGNATURE-----

--kg4e3lnx3ylyr5p3--
