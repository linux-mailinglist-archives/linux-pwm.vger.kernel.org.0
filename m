Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FB439F1D
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Oct 2021 21:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhJYTRa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 15:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhJYTR2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 15:17:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD8C061225
        for <linux-pwm@vger.kernel.org>; Mon, 25 Oct 2021 12:15:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mf5Qy-0002TC-A6; Mon, 25 Oct 2021 21:15:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mf5Qx-0003UP-7b; Mon, 25 Oct 2021 21:14:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mf5Qx-0002b5-6B; Mon, 25 Oct 2021 21:14:59 +0200
Date:   Mon, 25 Oct 2021 21:14:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 3/3] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
Message-ID: <20211025191459.flhyrjgql3z2bwqo@pengutronix.de>
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
 <20211025170925.3096444-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4slazjvqhfh4scsn"
Content-Disposition: inline
In-Reply-To: <20211025170925.3096444-3-bjorn.andersson@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4slazjvqhfh4scsn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 25, 2021 at 10:09:25AM -0700, Bjorn Andersson wrote:
> The SN65DSI86 provides the ability to supply a PWM signal on GPIO 4,
> with the primary purpose of controlling the backlight of the attached
> panel. Add an implementation that exposes this using the standard PWM
> framework, to allow e.g. pwm-backlight to expose this to the user.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4slazjvqhfh4scsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF3Ai8ACgkQwfwUeK3K
7AkkDgf8C0WLBUS6WV9nMw6e3yWDIqZWXJg9UOhhEP+8ZzVDLSGSp6C0a83QbL8P
ePPUMTIX44rsdkDZaTk+7TPAucGi+RahrFHRh+kzesg9I7N8pdX7VpL06PaK7ha5
ufckLAAIv875cJa2YlmqGCesN3ydqISoYUNuSqgqZB8ApHBq2VyDkTeHVLXS44Mb
6ByGOnuoNy5U6tunqHuNTASKaGHbT31JLJYdLmODCaHpy0CHwPeMMPO0K5mxDHUM
mHHP/Teh95dOWSnH/GHdROO22aiPTw8FnXpoQn2ORm8kdfYv/xDXbQVqsUHKjnbl
9KavbJEMVsJnXZb6FoNCYAfZ4EXPuQ==
=YQqA
-----END PGP SIGNATURE-----

--4slazjvqhfh4scsn--
