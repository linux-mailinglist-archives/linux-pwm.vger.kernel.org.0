Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76682FBFFF
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 20:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbhASTaG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 14:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbhASTXv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 14:23:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF51C061573
        for <linux-pwm@vger.kernel.org>; Tue, 19 Jan 2021 11:23:10 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1waj-0005sk-BM; Tue, 19 Jan 2021 20:23:01 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1wae-00083D-0W; Tue, 19 Jan 2021 20:22:56 +0100
Date:   Tue, 19 Jan 2021 20:22:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        david.wu@rock-chips.com, steven.liu@rock-chips.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 5/5] pwm: rockchip: Enable clock before calling
 clk_get_rate()
Message-ID: <20210119192255.jdhh3l64yp5whzzq@pengutronix.de>
References: <cover.1610976129.git.simon@simonsouth.net>
 <4924f18fea9b028cab92ad4e79d957f5cb336b9c.1610976129.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x6xuh3b7pchr56sb"
Content-Disposition: inline
In-Reply-To: <4924f18fea9b028cab92ad4e79d957f5cb336b9c.1610976129.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--x6xuh3b7pchr56sb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Simon,

On Tue, Jan 19, 2021 at 11:12:09AM -0500, Simon South wrote:
> The documentation for clk_get_rate() in include/linux/clk.h states the
> function's result is valid only for a clock source that has been
> enabled. However, the Rockchip PWM driver uses this function in two places
> to query the rate of a clock without first ensuring it is enabled.
>=20
> Fix this by modifying rockchip_pwm_get_state() and rockchip_pwm_apply() so
> they enable a device's PWM clock before querying its rate (in the latter
> case, the querying is actually done in rockchip_pwm_config()) and disable
> the clock again before returning.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Simon South <simon@simonsouth.net>

I already reviewed this patch in v3 and gave my

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

You make it a bit easier if you add the received tags for new
iterations.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x6xuh3b7pchr56sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAHMYwACgkQwfwUeK3K
7Am37Af/XYu+pcSn5VpL3qw+4p3oSMKyA7rfVzksQ2nEe0rkaLgD35n84d1+uG8I
aQik3B8P0JxmxreM0J/CJ+D2R+kWWfbc5/SbzTCCXDYdz7vwhBbA5ry+9RahzkII
2DAWLTd6t1/+N6WF94o1dqVntZ/GlFbq0r+xluL9+aNnirGUnAi4gJajCyB79rI4
PKxBZpMga/uEGHmNAVI+QnL7RSgGvjNGj7Anv3HyFZrh5yxyeDHZHac1NbO8y1V4
saqiT/iHE4jrj2XUH276cbbQld/ZEXfZTpdrjNw/eFDmZlhpVqsLMUwG2+h4NDO6
kErBTD07e0d4kV2j6ZWpRYB8x3X/xw==
=+wY0
-----END PGP SIGNATURE-----

--x6xuh3b7pchr56sb--
