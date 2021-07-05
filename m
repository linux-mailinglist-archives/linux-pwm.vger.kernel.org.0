Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32213BBD5B
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jul 2021 15:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhGENNw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Jul 2021 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGENNw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jul 2021 09:13:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE3C061574
        for <linux-pwm@vger.kernel.org>; Mon,  5 Jul 2021 06:11:15 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0ONV-0005gO-T9; Mon, 05 Jul 2021 15:11:13 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0ONT-0003H1-QZ; Mon, 05 Jul 2021 15:11:11 +0200
Date:   Mon, 5 Jul 2021 15:11:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH 1/2] pwm: stm32-lp: Don't modify HW state in .remove
 callback
Message-ID: <20210705131111.4gb5x6ln5sfby3qf@pengutronix.de>
References: <20210505162843.188901-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqwdj2jqhghphm34"
Content-Disposition: inline
In-Reply-To: <20210505162843.188901-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sqwdj2jqhghphm34
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

this thread is marked as "Rejected" in patchwork without a word of you.
Did this happen on purpose? Assuming it did: I would welcome a word from
you in such a case. From my POV the patch set is still fine and should
be applied.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sqwdj2jqhghphm34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDjBOsACgkQwfwUeK3K
7AnxfQf/Ss/WERduvowZ7ewoAx+Efw5WQJwkbOQyRdrZf+J/QTg66MhyRKvOV33B
BT/9iI2SMJhE+fv9vUDeSuWWWN226otLWzkh9VA9Necs2UH9t1yNt78LxixsIZlh
3tPeO6Qde/3/pTdfGUdqRYbH+Iq50V3oJySZbaPFwhYsoFzoBrppnH1kYTpp8e5s
zSjpc9r84fBzjm9mQFrKZ7eqCw1r2jaja8B2jLAK0ub+VOCB6FieHMlbJfVkvwYQ
nQ+Jgs7NWXY5brCXGo5CgIbenv9IVPbAqZBLKn57j/gWhTr1HY/rsA2n9an6uBzD
khC0PA3oHMN4QFx8hXbJhb+98O7HzQ==
=6AOg
-----END PGP SIGNATURE-----

--sqwdj2jqhghphm34--
