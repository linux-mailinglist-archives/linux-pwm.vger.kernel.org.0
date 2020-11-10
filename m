Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE362AE0A0
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKJUZr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 15:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJUZr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 15:25:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A38C0613D1
        for <linux-pwm@vger.kernel.org>; Tue, 10 Nov 2020 12:25:47 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcaCz-0001ol-KH; Tue, 10 Nov 2020 21:25:41 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcaCy-0007Ab-Qy; Tue, 10 Nov 2020 21:25:40 +0100
Date:   Tue, 10 Nov 2020 21:25:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: provide new devm helpers for prepared and
 enabled clocks
Message-ID: <20201110202537.fyldrnhqewtppjkw@pengutronix.de>
References: <20201013082132.661993-1-u.kleine-koenig@pengutronix.de>
 <20201013082132.661993-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vja2ao7c3lrfyvsg"
Content-Disposition: inline
In-Reply-To: <20201013082132.661993-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vja2ao7c3lrfyvsg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Oct 13, 2020 at 10:21:31AM +0200, Uwe Kleine-K=F6nig wrote:
> When a driver keeps a clock prepared (or enabled) during the whole
> lifetime of the driver, these helpers allow to simplify the drivers.

I'd really like to make use of these helpers, so it would be great if
you could take a look and tell me if you like my approach.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vja2ao7c3lrfyvsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+q9z4ACgkQwfwUeK3K
7AlqfAf+IjbADZjFZFkkzkx614oDoA3yTUUbGi/0f1FFniQH+XxC1pdJ0f/3GDo6
WNU0b9K65aYN3d+KseUkhxcaqEfOM8Wi5RJeYXCJfaEuzJ7PpN7XLcvi0Q7IddJz
ShBcknshTmiWPAi31mxSl/M2rRkH33S7m+dvxTaw1hLhZb05HHxX+GhOD4svyiyO
syBMwMpTE8pez+0C9VMh0+T242YDHqWrlEGUxI/TZG7aGXMtibniSLXz//zR1Zoz
QcaY8fFSOtmjrJDReE0AgQXcYaou5F8vYcqKarSf/NF3VCjCXjiOWaR3Loo2M8w1
ApNFRqDiEMf/iTJFl99jmRStrDBd9Q==
=NUx6
-----END PGP SIGNATURE-----

--vja2ao7c3lrfyvsg--
