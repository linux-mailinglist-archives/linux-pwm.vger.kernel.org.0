Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B083329427
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 22:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhCAVtl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 16:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhCAVrR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 16:47:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E91C061794
        for <linux-pwm@vger.kernel.org>; Mon,  1 Mar 2021 13:46:36 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGqN8-0003SB-9r; Mon, 01 Mar 2021 22:46:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGqN7-0000nv-O8; Mon, 01 Mar 2021 22:46:33 +0100
Date:   Mon, 1 Mar 2021 22:46:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 4/7] pwm: pca9685: Reset registers to POR state in
 probe
Message-ID: <20210301214633.5xgxwtxuodrb3nyn@pengutronix.de>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <20201215212228.185517-4-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yqu7abjqlmsekdag"
Content-Disposition: inline
In-Reply-To: <20201215212228.185517-4-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yqu7abjqlmsekdag
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Tue, Dec 15, 2020 at 10:22:25PM +0100, Clemens Gruber wrote:
> Reset the prescale and ON/OFF registers to their POR default state in
> the probe function. Otherwise, the PWMs could still be active after a
> watchdog reset and reboot, etc.

My memories are swapped out because it's already so long ago I looked
into this series. I thought it was already said that taking over the
configured state in probe is the nice thing to do?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yqu7abjqlmsekdag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA9YLYACgkQwfwUeK3K
7AlFPgf/XsTyreMD0eEAB771UDAiWVBDvvto9r2YZ9JmdwElc8i6itG3hH24hIpd
BRIedAPTMoTkj0XdDCusO9Rz7zu1zmbNEoDnGll7i+c4PDffMx7RIPloCZMD+dpF
f/3Ox2PTAO6N9bkFLaFlFgXUiNAGzMA18yDbJOz1rVV3DDi5sn2kqRAOBJN1BlJa
PERKV1Y9Rk1DxqQbti4fcE4yy3zAUIZf7Cs9qO5/h/MYWfElpMgspkDjCKqIemWh
E0DLGv9bJrso0XP9QeV+//sJgSMQlL64+sxEfs1RaI6aIchm2eW9qij6rNENGNqH
EjUTIhByrS60paYrVjE5SmnGyc7DrA==
=Xn5c
-----END PGP SIGNATURE-----

--yqu7abjqlmsekdag--
