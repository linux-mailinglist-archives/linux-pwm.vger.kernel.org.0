Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2072F741D
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 09:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbhAOIOB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Jan 2021 03:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbhAOIOA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Jan 2021 03:14:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFAEC061575
        for <linux-pwm@vger.kernel.org>; Fri, 15 Jan 2021 00:13:20 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0KER-0002OM-3c; Fri, 15 Jan 2021 09:13:19 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0KEQ-0004MF-Pw; Fri, 15 Jan 2021 09:13:18 +0100
Date:   Fri, 15 Jan 2021 09:13:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] pwm: pwm-gpio: Generic GPIO bit-banged PWM driver
Message-ID: <20210115081318.ig76unyfp3fqhu5z@pengutronix.de>
References: <20201222213325.2656124-1-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3ghc5pfz3gmajep"
Content-Disposition: inline
In-Reply-To: <20201222213325.2656124-1-angelo.compagnucci@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--e3ghc5pfz3gmajep
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

there are currently two patches with the same goal ready for review on
the linux-pwm list:

  - https://lore.kernel.org/r/20201211170432.6113-1-nicola.dilieto@gmail.com
  - https://lore.kernel.org/r/20201222213325.2656124-1-angelo.compagnucci@g=
mail.com
    (i.e. this one)

In my eyes the former is the better one, so @Angelo: Maybe you can join
forces with Nicola and work on his patch set.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e3ghc5pfz3gmajep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmABTpsACgkQwfwUeK3K
7Amz/wf/Z+xWDLS0ymdqeNIic23ARaFVjQYqfCTpNrkiGHImXsPLFmJwBhFfa8hh
Sj/zfSpJJhYoO8EWFVXN//PVolBbIa+28aFN3B7F3Bgy3YB9OahchQU5YX96W7Uf
PE1smmexr/uNF4T7uKrkqyvp1zWVNT/bwslSeFruaYLI43kuMeLbOeqvWBSXC189
SwPBImL8Qft30jZdtPE3DeZUFiGWPpd7noL1wBbduBLzrP2IjhyC5nMBfbkLB0Pw
qb1dbfYKjW3YnHQCNvhmAYWKnS8EocjG736SEcT11r0s1tXX9RCHEeigTaenyUai
gu9s/G4D1XLpugbEb3OpN7eul/s9cQ==
=KIOT
-----END PGP SIGNATURE-----

--e3ghc5pfz3gmajep--
