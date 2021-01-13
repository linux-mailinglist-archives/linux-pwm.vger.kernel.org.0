Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7C2F4538
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 08:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbhAMHcM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 02:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMHcM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 02:32:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488AC061575
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 23:31:32 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzacp-0007SI-0e; Wed, 13 Jan 2021 08:31:27 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzacn-0003Kr-RX; Wed, 13 Jan 2021 08:31:25 +0100
Date:   Wed, 13 Jan 2021 08:31:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 2/7] pwm: rockchip: rockchip_pwm_probe(): Remove
 superfluous clk_unprepare()
Message-ID: <20210113073125.tmrdy4g3eanwib5y@pengutronix.de>
References: <cover.1608735481.git.simon@simonsouth.net>
 <fe86b3ad145c5df3b16b09a83769f078bb4a9d1f.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u2aypliebvi7mkea"
Content-Disposition: inline
In-Reply-To: <fe86b3ad145c5df3b16b09a83769f078bb4a9d1f.1608735481.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--u2aypliebvi7mkea
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Simon,

On Wed, Dec 23, 2020 at 11:01:04AM -0500, Simon South wrote:
> If rockchip_pwm_probe() fails to register a PWM device it calls
> clk_unprepare() for the device's PWM clock, without having first disabled
> the clock and before jumping to an error handler that also unprepares
> it.

The "without having first disabled the clock" part is wrong without the
first patch. I suggest to swap the order of the first and second patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u2aypliebvi7mkea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+ocoACgkQwfwUeK3K
7AlmJgf9EyraVtNyxfarVEjBYdpjtMKzSO85S95LjJ1WXcAISuykepRbirLEbl4o
2qo7WVi60Dfl4KJli37Ho/kYvifaSN8rxUO9QWxDKCvb3ikDGC+gvtkutWN4oyaI
Ecp65uEQiWPPIEk/aevts6bqfEaB2XfsaVRtx8o9vrmSEKC2dc56BYKGGkjH7QzN
/+bS5GHrYIgP8dR6b9MpNL5FntcWnIWOjRZmPdd6YBtlz3wduEUeSLnR0ilMLtcJ
gxWoolQL+c9dhs2yxda5nSrdKZeRXyGndh41fsmNJU3/T43Xvv0EJzUAMneThRqw
7HVBwq/rbIbIgXfdHPSZI/vFruFQNQ==
=18uE
-----END PGP SIGNATURE-----

--u2aypliebvi7mkea--
