Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E861B355083
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhDFKIN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbhDFKIM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 06:08:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C068C06174A
        for <linux-pwm@vger.kernel.org>; Tue,  6 Apr 2021 03:08:04 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTicn-0000Ih-L1; Tue, 06 Apr 2021 12:07:57 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTicm-0004j3-7j; Tue, 06 Apr 2021 12:07:56 +0200
Date:   Tue, 6 Apr 2021 12:07:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [v3,PATCH 1/3] pwm: mtk_disp: clear the clock operations
Message-ID: <20210406100756.ijthlp2j3a3eygdt@pengutronix.de>
References: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
 <1617703062-4251-2-git-send-email-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="af63drcvcndnf3ct"
Content-Disposition: inline
In-Reply-To: <1617703062-4251-2-git-send-email-rex-bc.chen@mediatek.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--af63drcvcndnf3ct
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 06, 2021 at 05:57:40PM +0800, Rex-BC Chen wrote:
> Remove the clk_prepare from mtk_disp_pwm_probe.
> Remove the clk_unprepare from mtk_disp_pwm_remove.
>=20
> After using atomic API and get_state() function which are implemented
> in PATCH [2/3], [3/3],

Refering to the following patches as 2/3 and 3/3 doesn't make sense once
these patches are applied to a tree.

> clk_prepare/clk_unprepare are useless in probe/remove function.
> So we remove clk_prepare/clk_unprepare in probe/remove fuinction.

Does the driver still work with only this patch applied? If not, please
rearrange and order this patch after the conversion to the atomic API.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--af63drcvcndnf3ct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBsMvkACgkQwfwUeK3K
7Ak6aAf9H1Hh1pupjsfSXeA1E7ELdVBhmy24h4j6m4zEM5wT8FAgdrYnnX04fAhV
qY6CquneoPnm5BvZp2CXMukAi67J0kL0C6APkjh3hpHfElyd8a//gsGID9uZ4hIj
S7EmQEWjGBg9unsnUJdyWrUHipA4XGktfoSGSUIFIPZjQDEmOxqPaYm9dHrSt92w
ukZ2PzqxCDIZqilIgijo3w2BARAe3n0w0pzWbB/hwjsF8a/bhCDI3ynkc45G5D2d
nPNBv6YTQaxKcxbpn13nF4RSxUKh43T7nN79KFY7xnA6fokm+hRoZV8Rjn2/kQiO
TZ0OO1o+NqYosUQWAJZp6kdMQ6zIaA==
=6z2O
-----END PGP SIGNATURE-----

--af63drcvcndnf3ct--
