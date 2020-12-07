Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DDB2D1C99
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 23:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLGWBJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 17:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLGWBJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 17:01:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F793C061794
        for <linux-pwm@vger.kernel.org>; Mon,  7 Dec 2020 14:00:28 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmOYU-0005UQ-M0; Mon, 07 Dec 2020 23:00:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmOYT-0002KS-IE; Mon, 07 Dec 2020 23:00:25 +0100
Date:   Mon, 7 Dec 2020 23:00:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kgzo6tw3hr33sb3c"
Content-Disposition: inline
In-Reply-To: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kgzo6tw3hr33sb3c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 08:36:27PM +0100, Clemens Gruber wrote:
> The switch to the atomic API goes hand in hand with a few fixes to
> previously experienced issues:
> - The duty cycle is no longer lost after disable/enable (previously the
>   OFF registers were cleared in disable and the user was required to
>   call config to restore the duty cycle settings)
> - If one sets a period resulting in the same prescale register value,
>   the sleep and write to the register is now skipped
> - The prescale register is now set to the default value in probe. On
>   systems without CONFIG_PM, the chip is woken up at probe time.
>=20
> The hardware readout may return slightly different values than those
> that were set in apply due to the limited range of possible prescale and
> counter register values. If one channel is reconfigured with new duty
> cycle and period, the others will keep the same relative duty cycle to
> period ratio as they had before, even though the per-chip / global
> frequency changed. (The PCA9685 has only one prescaler!)

This is not acceptable, if you have two PWM outputs and a consumer
modifies one of them the other must change. So if this chip only
supports a single period length of all channels, the first consumer
enabling a channel defines the period to be used. All later consumers
must live with that. (Also the first must be denied modifying the period
if a second consumer has enabled its PWM.)

> Note that although the datasheet mentions 200 Hz as default frequency
> when using the internal 25 MHz oscillator, the calculated period from
> the default prescaler register setting of 30 is 5079040ns.

That means the datasheet is lax because 5079040ns corresponds to
196.88760080645162 Hz but it calls that 200 Hz, right?

I didn't look in the patch in detail, but get the impression it is more
complicated than necessary. For example adding improved PM behaviour
should probably go into a separate patch, also adding the .get_state
callback should be split out.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kgzo6tw3hr33sb3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/OpfYACgkQwfwUeK3K
7AmjxQgAoR9O07VK5t7mM0Uqh+ln6vQ588Tg1ZdUxJNXA+BIiBgFXdz+0IMHQloZ
xXysQ9tkGH0SkbHtv9SNCGCLSbeJWcNAUiPv903ITTT8+My8I2NjcKJMI5C17UlO
tNkgbLqC20GFoHcspLt5C2t2HWEqgDrX+8em89mz0fB4uIjWDUxWbVdJfMybqnIR
RXziTzNE7QQq1BsB4Us6QtN0VYzzkxpvVNxZ0ZkhHmaM7ZhV6D06O5+kA/Czh6Lm
JB3D8ukqHhv9ci4qCg+205v4u279vzDzohGCzdBNfQjD4AwVX2Cy/nNzUuZzXgIj
3TCoW8MfJUFULY7mqD4mhyd6zt8SHQ==
=LzsU
-----END PGP SIGNATURE-----

--kgzo6tw3hr33sb3c--
