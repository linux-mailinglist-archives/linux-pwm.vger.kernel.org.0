Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3275EC6F
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jul 2023 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGXHYr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jul 2023 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjGXHYq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jul 2023 03:24:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88547E1
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2023 00:24:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNpvv-0006gf-Vh; Mon, 24 Jul 2023 09:24:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNpvv-001hdk-21; Mon, 24 Jul 2023 09:24:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNpvu-007Lg3-7u; Mon, 24 Jul 2023 09:24:42 +0200
Date:   Mon, 24 Jul 2023 09:24:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Explicitly include correct DT includes
Message-ID: <20230724072442.yb4fa3vkw34nojwn@pengutronix.de>
References: <20230714174852.4062251-1-robh@kernel.org>
 <20230717074352.dz3ex7fwi77loayc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qgjv7qoirny7mgrw"
Content-Disposition: inline
In-Reply-To: <20230717074352.dz3ex7fwi77loayc@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qgjv7qoirny7mgrw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Jul 17, 2023 at 09:43:52AM +0200, Uwe Kleine-K=F6nig wrote:
> Acked-by: Uwe Kleine-K=F6ng <u.kleine-koenig@pengutronix.de>

I mistyped my name and this made it into your for-next branch. It would
be great if you fixed it, e.g. using:

	FILTER_BRANCH_SQUELCH_WARNING=3D1 git filter-branch -f --msg-filter 'sed "=
s/ng <u.kl/nig <u.kl/"' linus/master..

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qgjv7qoirny7mgrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS+JzkACgkQj4D7WH0S
/k5Vygf+OLBx3GzJy5o99PmlpLHAyrGzuRnnyg+DZPKjDMo0IgZ+n9pHdG08tk0t
IKxdRkUUgjIScBAwphwY+XfMLfOZKggI45BjrRMk5CNUAAKer/nPAe4CEAdnbJEx
KLsdLlkYiJGbTryydCCgxh5mDvddBwmFcB2V8n/SHjtpwUxe3zHkfWW6O8+pA82p
xgATG5MH17N0RKG9BaIcGKPQuB0pAZd23arFjNp7v/PoVhIG3s6zbiLVD82j4BZ1
6PX4X6CVXbij6fAV7XEVjSLr19ue9ra6e9nycZZILjvUYC6ypCL2xLkw2dfhtL3z
Vv1vLbORoKKOg1ymFRTL9/U6knVGVQ==
=W8MP
-----END PGP SIGNATURE-----

--qgjv7qoirny7mgrw--
