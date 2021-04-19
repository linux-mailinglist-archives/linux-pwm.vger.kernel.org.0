Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0161A363B6B
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Apr 2021 08:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhDSGYs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Apr 2021 02:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhDSGYr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Apr 2021 02:24:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25044C06174A
        for <linux-pwm@vger.kernel.org>; Sun, 18 Apr 2021 23:24:18 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lYNKE-0001CT-97; Mon, 19 Apr 2021 08:24:02 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lYNK8-0006Ew-S7; Mon, 19 Apr 2021 08:23:56 +0200
Date:   Mon, 19 Apr 2021 08:23:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210419062356.bfgkcdrceovdwkh5@pengutronix.de>
References: <20210419000007.1944301-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210419000007.1944301-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zgu4pc5obhcggw3s"
Content-Disposition: inline
In-Reply-To: <20210419000007.1944301-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zgu4pc5obhcggw3s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 09:00:07AM +0900, Nobuhiro Iwamatsu wrote:
> Add driver for the PWM controller on Toshiba Visconti ARM SoC.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for your endurance to improve the driver
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zgu4pc5obhcggw3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB9IfkACgkQwfwUeK3K
7AlgHwf+Nx79sbNY1GlGt+gijv/vJoNs1ZFqTScJnkczL704cUw0dg4phGRgFgb9
f89mQTXKNPKmRFvEs2NbWKWLQ4wuvLb5V8VIf1h/0BxfFzqhOKWNxjBDbkRAZjzp
02SfpghGEgFzGzOD0h/9CuwYCcb8kox51Vn4fkLYSvQGV1kvlBEVwAzgR3pXqzc9
6+cMBOgGdkuQqmjPAB9IrlDK0UzJAVbORkC5ATJFzyWIHKp+FI29sk6cPjrBUMmA
uMFRBW2LgEwCRZ/Vk0VXVdHIQhd2uW7gssU8E1F0ZB7ipnd7NnsdmXm/C60Pi7Yq
ICOagB8h0YuiptPdst7kTok8nEW5gA==
=Uaqc
-----END PGP SIGNATURE-----

--zgu4pc5obhcggw3s--
