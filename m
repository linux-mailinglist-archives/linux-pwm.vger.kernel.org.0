Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5E35CAF1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbhDLQVf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbhDLQVf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 12:21:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC1C061574
        for <linux-pwm@vger.kernel.org>; Mon, 12 Apr 2021 09:21:17 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVzJL-0000fo-A8; Mon, 12 Apr 2021 18:21:15 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVzJK-0001No-W9; Mon, 12 Apr 2021 18:21:15 +0200
Date:   Mon, 12 Apr 2021 18:21:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/8] pwm: pca9685: Support hardware readout
Message-ID: <20210412162114.7yhfndb3cktynpme@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-2-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tmg3gsc2vxm7yox"
Content-Disposition: inline
In-Reply-To: <20210412132745.76609-2-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7tmg3gsc2vxm7yox
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Mon, Apr 12, 2021 at 03:27:39PM +0200, Clemens Gruber wrote:
> Implement .get_state to read-out the current hardware state.
>=20
> The hardware readout may return slightly different values than those
> that were set in apply due to the limited range of possible prescale and
> counter register values.
>=20
> Also note that although the datasheet mentions 200 Hz as default
> frequency when using the internal 25 MHz oscillator, the calculated
> period from the default prescaler register setting of 30 is 5079040ns.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7tmg3gsc2vxm7yox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB0c3cACgkQwfwUeK3K
7AnbGgf/V6ZeU3R88Yp5XPjfGoo7IZqSwfDZVZyK5hzg9gm76VrpUCLzGAg0BBbV
62eoMBBv6y7G7xMJboVc5A7tGcB8Pbu0pJOxhJQWT6DooteVy7kU5bxVG/Llm+b9
hgcWABfQBLWDVisYqY4qadcq1gNK5jfH3oSKyiUwz+T2WpL79CGuFTUqlXCRPvTz
Cuj1TZyOIi5DUNsMhaviwEys0WlHRdKth40oASNJsuTFhaZzX6hPHGGY0mZL814I
BJYlSON8avEGQOpNLYWQcCjT1go5Uoo4hYDjW4938os6WR5fiwrvR3KKj/gQEJYQ
+LZVSLjbrCRcx8EvNW1b/kiy42KETQ==
=vQZD
-----END PGP SIGNATURE-----

--7tmg3gsc2vxm7yox--
