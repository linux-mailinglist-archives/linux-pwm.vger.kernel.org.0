Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1DE79A456
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Sep 2023 09:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjIKHTp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Sep 2023 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjIKHTo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Sep 2023 03:19:44 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5FCD1
        for <linux-pwm@vger.kernel.org>; Mon, 11 Sep 2023 00:19:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfbCc-0003Rt-OL; Mon, 11 Sep 2023 09:19:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfbCc-005Ugm-BH; Mon, 11 Sep 2023 09:19:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfbCb-000bT0-LW; Mon, 11 Sep 2023 09:19:21 +0200
Date:   Mon, 11 Sep 2023 09:19:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     patchwork-bot+chrome-platform@kernel.org,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH] pwm: Explicitly include correct DT includes
Message-ID: <20230911071921.6dhadiqmfpedqxvy@pengutronix.de>
References: <20230714174852.4062251-1-robh@kernel.org>
 <169440670019.22573.2422972280084635660.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bbuuoqwymefnkym6"
Content-Disposition: inline
In-Reply-To: <169440670019.22573.2422972280084635660.git-patchwork-notify@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bbuuoqwymefnkym6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 11, 2023 at 04:31:40AM +0000, patchwork-bot+chrome-platform@ker=
nel.org wrote:
> This patch was applied to chrome-platform/linux.git (for-kernelci)
> by Thierry Reding <thierry.reding@gmail.com>:
>=20
> On Fri, 14 Jul 2023 11:48:50 -0600 you wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those include
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - pwm: Explicitly include correct DT includes
>     https://git.kernel.org/chrome-platform/c/0a41b0c5d97a
>=20
> You are awesome, thank you!

It's a bit strange to get this notification given that this patch was
applied via the pwm tree and only made it into the
chrome-platform/linux.git repo via an update to v6.6-rc1.

It's not a big problem, but if such mail could be suppressed that would
be nice.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bbuuoqwymefnkym6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT+v3gACgkQj4D7WH0S
/k7XPQf/anQ6vlB0uEF5CmCQwzYikHQwTbvnK2tKGA9G3nw6wEIW8ss61ez4jFWZ
DQ75loTIlF91uC59ZDYxyaL2i2iZFnisMi1hvAbevBA2Z/3b6T5Bcl/prartKxGX
6IooL+RTaTgJKVwYqauIWIvO3/4synIpsF3YGlD8tZz4vyC4abTDaLPFFXfPE2vb
h+UVzRT6eQfK94R7W/pP2u9vPLgR6OPAsv6t/z1bXHMU0FokJaOzQSt1sfXaHxUa
tB8QnrbOQ1StunbalXmqBVdByNupbzAWJX6QipN4BjZ28w1HDs1XunFR/dRifmIo
lGmG8LVNpr1wKeDktDi68Mtphwtxcg==
=i3rg
-----END PGP SIGNATURE-----

--bbuuoqwymefnkym6--
