Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3D6441F1
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Dec 2022 12:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiLFLRi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Dec 2022 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiLFLRg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Dec 2022 06:17:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225022E3
        for <linux-pwm@vger.kernel.org>; Tue,  6 Dec 2022 03:17:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2Vx7-00010A-FC; Tue, 06 Dec 2022 12:17:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2Vx6-002gSL-2N; Tue, 06 Dec 2022 12:17:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2Vx6-0030sJ-5x; Tue, 06 Dec 2022 12:17:32 +0100
Date:   Tue, 6 Dec 2022 12:17:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PULL] pwm changes for 6.2 for Thierry
Message-ID: <20221206111732.gljsxhrzlnbcv3bi@pengutronix.de>
References: <20221202183504.rhz5meomd4a4t7am@pengutronix.de>
 <20221202190306.rqzfpkgitgexxyg7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jj6xnwx46zyp7pd4"
Content-Disposition: inline
In-Reply-To: <20221202190306.rqzfpkgitgexxyg7@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jj6xnwx46zyp7pd4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 08:03:06PM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Dec 02, 2022 at 07:35:04PM +0100, Uwe Kleine-K=F6nig wrote:
> >       drm/bridge: ti-sn65dsi86: Propagate errors in .get_state() to the=
 caller
> >       leds: qcom-lpg: Propagate errors in .get_state() to the caller
>=20
> One thing I forgot to point out: I wasn't sure if I should include these
> two patches. They could just be dropped without harm. I kept them
> because I already touched these drivers anyhow in the change "pwm: Make
> .get_state() callback return an error code".

I updated the branch (reminder:

	https://git.pengutronix.de/git/ukl/linux pwm-6.2

) with some more Acks (and dropped a few duplicted S-o-b lines for
myself). Most notably Pavel acked the led changes to go via your tree.
Together with Doug's explanation about who cares for ti-sn65dsi86 I
think this is good as is.

The new hash is 0c6e9c1b0d9625f1202185048809a68fd506657f, there are no
source changes compared to the previous history.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jj6xnwx46zyp7pd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOPJMgACgkQwfwUeK3K
7Ak/3wf+MBL6flszZ7yUJyfiHC+ihj3lDQEHu7oo9gC0i1GBs2VSkD8qCwN4c08b
AAJ10vwaxnZIJYr0YoI0lJpISaVLWujX6g6Bz9QIPxCUWH7OkcmCLC9Skx5m/4Hs
zyA+TRZMhm0rzJiHEC69aIwa3NhLrngRKsh/afIOjNkbPiBvoOkxED5G4Gsg8SUk
WsR281YnjcxY0NLUPrY8WRu6W+O+XQDQsqZf15ZOZqdWHfMUhWnBWV4inIohLw0L
T8QVz1A6VgkeqskgxipHrDNoQfpt3t4ziOOKPkeUrs/+brT8KLNC2CUJMyxxRDI5
zrW6NUy4NEgQfBWN0lBY+w8GkipEPw==
=MTCj
-----END PGP SIGNATURE-----

--jj6xnwx46zyp7pd4--
