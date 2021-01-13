Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3965B2F4529
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 08:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbhAMHYq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 02:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhAMHYp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 02:24:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9BC061575
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 23:24:05 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzaVc-0006Yj-QS; Wed, 13 Jan 2021 08:24:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzaVa-00033W-MR; Wed, 13 Jan 2021 08:23:58 +0100
Date:   Wed, 13 Jan 2021 08:23:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/7] pwm: rockchip: Enable APB clock during register
 access while probing
Message-ID: <20210113072358.7ozcznyjyhuh2mt4@pengutronix.de>
References: <cover.1608735481.git.simon@simonsouth.net>
 <49ceda3def13f6186073745e99d7315c974bfa81.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bm5todtkkso6pnn6"
Content-Disposition: inline
In-Reply-To: <49ceda3def13f6186073745e99d7315c974bfa81.1608735481.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bm5todtkkso6pnn6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Simon,

On Wed, Dec 23, 2020 at 11:01:03AM -0500, Simon South wrote:
> Commit 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
> probing") modified rockchip_pwm_probe() to access a PWM device's registers
> directly to check whether or not the device is running, but did not also
> change the function to first enable the device's APB clock to be certain
> the device can respond. This risks hanging the kernel on systems with PWM
> devices that use more than a single clock.
>=20
> Avoid this by enabling the device's APB clock before accessing its
> registers (and disabling the clock when register access is complete).
>=20
> Fixes: 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while prob=
ing")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Trent Piepho <tpiepho@gmail.com>
> Signed-off-by: Simon South <simon@simonsouth.net>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bm5todtkkso6pnn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+oAsACgkQwfwUeK3K
7AmGCwf+Kf7kFu7rEDsPuXQ0t/Mv+Ml4/sd2e7dUbGs8vnSZ8y8YpNxUAHnPpiF0
4ZtrSpCim5ZOZ93c2H3IUoMrqN8XBx6TIqYfffpmp6Zi8pibJerrr8mg2kxM7mMb
SnX6uIj/WZds6Y2goMdTjuYuj5Yw2nNozNFttMu/iO3n+f5YAdcqXZ0w9sVSdrgK
6jOLukSKnJRIE2i5D/fL1zIn1yY2LgotzmxW6Q5TUtFsLXryr94XAjaQ95HsmBGJ
dMiGwqRqyA6OIF5fXBa4EZTubxJ2VEGVMT8HKTTEk7PxVbZYzv3PbbBjzsDTodQy
u9BQbOl+c7/tcSbXwq702pEFlSDAmA==
=YfRY
-----END PGP SIGNATURE-----

--bm5todtkkso6pnn6--
