Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8F2F4567
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 08:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAMHjI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 02:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbhAMHjH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 02:39:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00095C061786
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 23:38:26 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzajX-00082I-Fx; Wed, 13 Jan 2021 08:38:23 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzajW-0003bK-Vh; Wed, 13 Jan 2021 08:38:22 +0100
Date:   Wed, 13 Jan 2021 08:38:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 5/7] pwm: rockchip: rockchip_pwm_probe(): Remove
 unneeded goto target
Message-ID: <20210113073822.37og4yhxiem2j7ju@pengutronix.de>
References: <cover.1608735481.git.simon@simonsouth.net>
 <0637b8ebea49b30e5e675385225d59d028077421.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqwgwgugwdz66k4x"
Content-Disposition: inline
In-Reply-To: <0637b8ebea49b30e5e675385225d59d028077421.1608735481.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eqwgwgugwdz66k4x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2020 at 11:01:07AM -0500, Simon South wrote:
> Eliminate the remaining goto target in rockchip_pwm_probe() by moving the
> code that follows it to the point where it is invoked.
>=20
> The target no longer serves any purpose as the error-handling portions of
> this function no longer share any recovery steps.

If you adapt patch 4 as I suggested, this patch becomes obsolete.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eqwgwgugwdz66k4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+o2wACgkQwfwUeK3K
7An3aAf+OOubUjwdA7fnEnUfDg74Osw7XAolVEIywwpFfGeuGHMZ9ZSscB0iVPP/
do88ld0zbEGxK/htBRNVVIx1KHpyMC/jRpapR8Vl73whPSEl+YIpk8/3KYp1XvEJ
lzHIqp60HOoBzyVrn+z0plaHLlmf2AwfUCS424N5IjGP2GGCS0BGnGMy7oeTQStv
32LXd4dL4rfV1W5nNTUv/V0vYI/lwh+SOcZ4CKHy4282Kdm8KnRRnmQQhlNjbOrl
C3SvZHSjtZvV3PY2Z6E7wRxq+8x+7z2SmBuodlVgOiWLeRtkHFEWfI64QrD9b5Al
yedh0zhBbgvtFpVIumMbdhThEwki+A==
=i1nK
-----END PGP SIGNATURE-----

--eqwgwgugwdz66k4x--
