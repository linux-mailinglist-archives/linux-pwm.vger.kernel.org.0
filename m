Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCE34D44F
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhC2Pvu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhC2Pvp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 11:51:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0B0C061574
        for <linux-pwm@vger.kernel.org>; Mon, 29 Mar 2021 08:51:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQuB3-0006wI-6c; Mon, 29 Mar 2021 17:51:41 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQuB2-00015v-Eu; Mon, 29 Mar 2021 17:51:40 +0200
Date:   Mon, 29 Mar 2021 17:51:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210329155140.4gjtsw2qbpylv77z@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-2-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v4ybh3c4vqbu2ghd"
Content-Disposition: inline
In-Reply-To: <20210329125707.182732-2-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--v4ybh3c4vqbu2ghd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Mon, Mar 29, 2021 at 02:57:02PM +0200, Clemens Gruber wrote:
> The hardware readout may return slightly different values than those
> that were set in apply due to the limited range of possible prescale and
> counter register values.

This is fine and for most hardware that's not preventable. My
requirement here is that=20

	.get_state(pwm, &state);
	.apply_state(pwm, &state);

doesn't yield any changes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--v4ybh3c4vqbu2ghd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBh94kACgkQwfwUeK3K
7AlRowf/Q90UI142a9noeyN0kCYojz+YUqe+s2Tv40n1ZmLKQz60m4UC94CxERro
JJTA7hFA7xXgmUNzzI8sp159PQ6Pcc1ZTMmojZ5LCox2KBB/EAqzV+HxLwAqJY/o
mFd1MzejkslcqMjujiRyfHeW9ZFZt3FW3ffiEvxrKIHsDsXinhhLCGjqpIihPmq3
8mxF99EbXV5xzNbX02or9WqM1pUaHBK+L9tjSy3KVqrPMeP9pYSg3zlIHH2B3oxA
z80a/2h6GhNsXihz4jaJmY8Up1XLI8t3AVBCE4Sc0ei3fBEriR1EJScXiQVEFyEq
LRrg318Yic6Qwzg9vZOHpPpOKyGCLQ==
=kQFu
-----END PGP SIGNATURE-----

--v4ybh3c4vqbu2ghd--
