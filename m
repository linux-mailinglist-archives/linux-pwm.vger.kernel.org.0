Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA21D344707
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 15:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCVOWh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVOW3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 10:22:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0450FC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 07:22:29 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOLRq-0003oj-UF; Mon, 22 Mar 2021 15:22:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOLRq-0007Nf-IM; Mon, 22 Mar 2021 15:22:26 +0100
Date:   Mon, 22 Mar 2021 15:22:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] clk: provide new devm helpers for prepared and
 enabled clocks
Message-ID: <20210322142226.n7qa4rijdhsqoqgf@pengutronix.de>
References: <20210301135053.1462168-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5phyeawdahq2t3cm"
Content-Disposition: inline
In-Reply-To: <20210301135053.1462168-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5phyeawdahq2t3cm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 01, 2021 at 02:50:50PM +0100, Uwe Kleine-K=F6nig wrote:
> Uwe Kleine-K=F6nig (3):
>   clk: generalize devm_clk_get() a bit
>   clk: Provide new devm_clk_helpers for prepared and enabled clocks
>   pwm: atmel: Simplify using devm_clk_get_prepared()
>=20
>  drivers/clk/clk-devres.c | 96 +++++++++++++++++++++++++++++++++-------
>  drivers/pwm/pwm-atmel.c  | 15 +------
>  include/linux/clk.h      | 87 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 168 insertions(+), 30 deletions(-)

can I get some feedback on this series please? The idea is on the list
since October last year with absolutely no maintainer feedback.

I think it's a good idea and not too hard to review, so I wonder what is
stopping you.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5phyeawdahq2t3cm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYqB8ACgkQwfwUeK3K
7AlcLwf+MO9wU66kI2KeEmjWTjbBNyavpby/rc/RzbJBTlUBEA+WMpbfUsZCslhW
kYjEEdrVqJ5WnR15w/17Y5fcu6eP2McQ1gaEhYFtseU27HNy2xZ4VABnRRrtzdbX
NJsWJrhFWVMQtGe1YXsfLFY5BdsbzJcSdhs3YY9tPUaeJMIzz3QyNEp2eVVtQZZ8
eEggpUA/2Xz57sdS4ILGs9+QEk4y3rK1+1IERQHu3USuenA2U7KhqG3CZ2tVj+AE
OJvOpHfmDxSEVI9MmwP5YhKYWKCbjisug3ucdjStk47ERe28t5U8c+0RBbv8xPY5
JqKOm+ZNH6JOZYaKRd6ycYpjeXtZTQ==
=AvXV
-----END PGP SIGNATURE-----

--5phyeawdahq2t3cm--
