Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AAE314BBD
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Feb 2021 10:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBIJfe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Feb 2021 04:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhBIJdZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Feb 2021 04:33:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C37EC06178B
        for <linux-pwm@vger.kernel.org>; Tue,  9 Feb 2021 01:32:39 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l9PNs-0005dm-Rs; Tue, 09 Feb 2021 10:32:36 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l9PNs-00082D-79; Tue, 09 Feb 2021 10:32:36 +0100
Date:   Tue, 9 Feb 2021 10:32:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: provide new devm helpers for prepared and
 enabled clocks
Message-ID: <20210209093236.iycxhgrbc3drp2c4@pengutronix.de>
References: <20201013082132.661993-1-u.kleine-koenig@pengutronix.de>
 <20201013082132.661993-2-u.kleine-koenig@pengutronix.de>
 <20201110202537.fyldrnhqewtppjkw@pengutronix.de>
 <20201221092918.3uuxfe4caseu2d3o@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g2ef6erhhx5bkaxj"
Content-Disposition: inline
In-Reply-To: <20201221092918.3uuxfe4caseu2d3o@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g2ef6erhhx5bkaxj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 21, 2020 at 10:29:18AM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 10, 2020 at 09:25:37PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Oct 13, 2020 at 10:21:31AM +0200, Uwe Kleine-K=F6nig wrote:
> > > When a driver keeps a clock prepared (or enabled) during the whole
> > > lifetime of the driver, these helpers allow to simplify the drivers.
> >=20
> > I'd really like to make use of these helpers, so it would be great if
> > you could take a look and tell me if you like my approach.
>=20
> This is still the case but unfortunately I didn't get any feedback since
> October 13. Is this still on your list of things to review?

I still didn't get any feedback here, still really like the implemented
idea and want to use it. Looking forward to your feedback

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g2ef6erhhx5bkaxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAiVrEACgkQwfwUeK3K
7AkznQgAnRsOGuewsFwro1fhYiEgE+8RXqktnum6eA0yDAxi0X+zPgqpRMKRsJZP
IvkccRN7SpG1L3GCU6JWtkHOjtRAwNWN7IJ3eDMNNm7/CwMwH1oVnjw2GGX8rf7J
5EYyu4glcm+EK6WpG0+YHxLXfi60Gyy1Ic9BlA05iRhFij0BC8iNwSeBjNgIw0E0
70CZQV0/MsCkG7m1PGX6aVestYZ2QjsucMwjcpBFugbPULjJaxUFpq3Xsf6pR7HW
2r6iMi/n7rJw5Tko8bo2VntnqianggTiQBuS7/pWoxP0ACl4ZxYNHJu7Q5Gjyxed
LpEoB499c9Gp9lDvle8OsmH/B4N52g==
=XplD
-----END PGP SIGNATURE-----

--g2ef6erhhx5bkaxj--
