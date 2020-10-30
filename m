Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938312A0F59
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgJ3UVE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 16:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3UVE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 16:21:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4720AC0613CF
        for <linux-pwm@vger.kernel.org>; Fri, 30 Oct 2020 13:11:22 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kYak4-00017c-Ax; Fri, 30 Oct 2020 21:11:20 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kYak3-0001Wy-MW; Fri, 30 Oct 2020 21:11:19 +0100
Date:   Fri, 30 Oct 2020 21:11:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] pwm: lp3943: Dynamically allocate pwm chip base
Message-ID: <20201030201117.x5asfjxh7htwv35s@pengutronix.de>
References: <20201030134135.28730-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lx67b2e737v6sj34"
Content-Disposition: inline
In-Reply-To: <20201030134135.28730-1-lokeshvutla@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lx67b2e737v6sj34
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 07:11:35PM +0530, Lokesh Vutla wrote:
> When there are other pwm controllers enabled along with pwm-lp3943,
> pwm-lp3942 is failing to probe with -EEXIST error. This is because
> other pwm controller is probed first and assigned pwmchip 0 and
> pwm-lp3943 is requesting for 0 again. In order to avoid this, assign the
> chip base with -1, so that id is dynamically allocated.
>=20
> Fixes: af66b3c0934e ("pwm: Add LP3943 PWM driver")
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-k=F6nig@pengutronix.de>

With this patch applied only the pwm-ab8500 driver is left not using -1
for base.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lx67b2e737v6sj34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+cc2EACgkQwfwUeK3K
7AnkZQgAi/o3YwDU501EKDktgXEeNdF5I0thWm4dv6JY7LYO9/WKSlx/uxpy8SUi
8yBNHyEVFjPQ/but9ofkXhFpiHZNh7JJeNEvDtVp5l+j7JczCa7s/37LWh/IUldv
A01zeVXSxdcQOddfWWWiPFSp9RhHD7tztqxVkT3OKezIANmTxo3BHcyJAiadOcap
adaAR6ukE2aNCU+iKJ030QziHFX3Al/DIr6nv6ORCa+7p/yRg7KWt8wDspWUj2Gb
VjG7Akm2+Ek0RoWZmBicEe/ZwEDpCoEQ3WxWOutN7esrCTOISJm3Q8U+CWyqKqhn
OWvjyvqH3g/VlD1V6L9YCHPsdE1XKA==
=0s0w
-----END PGP SIGNATURE-----

--lx67b2e737v6sj34--
