Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D5445B9E
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 22:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhKDV0x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhKDV0w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Nov 2021 17:26:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0AC061714
        for <linux-pwm@vger.kernel.org>; Thu,  4 Nov 2021 14:24:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mikDO-0002ig-IR; Thu, 04 Nov 2021 22:24:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mikDL-0005n2-VU; Thu, 04 Nov 2021 22:24:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mikDL-0000Zg-TO; Thu, 04 Nov 2021 22:24:03 +0100
Date:   Thu, 4 Nov 2021 22:23:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] media: ir-rx51: Switch to atomic PWM API
Message-ID: <20211104212340.4he7jo65ebh7tkg3@pengutronix.de>
References: <YYQrano1G7cBDf+v@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="putn6n2s35znedxu"
Content-Disposition: inline
In-Reply-To: <YYQrano1G7cBDf+v@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--putn6n2s35znedxu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 04, 2021 at 03:50:18PM -0300, Ma=EDra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
>=20
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for the quick update,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--putn6n2s35znedxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGET1gACgkQwfwUeK3K
7AkjNggAlTz0V2xr6wEX+jM1OgNyVO5kf6ErPj2qohxzps2qG4o+VWGJaOG9CVCB
eG0SkNwULvsYMX2nTqGiVmjl7Imb0IWWoBWwjLKMhQiwOVxVYj/wYm1UmIWnlrlN
S6TDerXstA0PwFf+yPWpa961ofDj7A9GO4XkvqkD99N6YVxF/7pi9SUhSYcBKOAu
HTmfgI4yxIApqRE0LLNPZB9tsMY+Tzn71AjjHlS1Fs3wfg7ESSyzG9ttwkS/BQS1
S9eiRHID7wl0G0pu/hEHEk/EUzvPCB6PnPDYyO8OZMj9E5CMXR0zYWhu808tUtrA
/3Z9C8eeGExTebbv3cX6qPS9OU1oNg==
=bTd9
-----END PGP SIGNATURE-----

--putn6n2s35znedxu--
