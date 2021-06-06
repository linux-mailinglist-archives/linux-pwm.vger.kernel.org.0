Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5739D1AB
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Jun 2021 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhFFVdF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Jun 2021 17:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFFVdE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Jun 2021 17:33:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D9C061766
        for <linux-pwm@vger.kernel.org>; Sun,  6 Jun 2021 14:31:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq0MK-0004Mn-Ai; Sun, 06 Jun 2021 23:31:04 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq0ME-0005Io-NV; Sun, 06 Jun 2021 23:30:58 +0200
Date:   Sun, 6 Jun 2021 23:30:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Flavio Suligoi <f.suligoi@asem.it>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/7] pwm: core: Always require PWM flags to be provided
Message-ID: <20210606213054.bmqgs5hehbowa62d@pengutronix.de>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
 <20210531194947.10770-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nhpwy4vsiqbpl5ml"
Content-Disposition: inline
In-Reply-To: <20210531194947.10770-2-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nhpwy4vsiqbpl5ml
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, May 31, 2021 at 10:49:42PM +0300, Andy Shevchenko wrote:
> It makes little sense to make PWM flags optional since in case
> of multi-channel consumer the flags can be optional only for
> the last listed channel.

I think the same holds true for dt references.

> Thus always require PWM flags to be provided.

I'm not sure I want to follow that conclusion. Most consumers only need
a single PWM and then not providing flags is fine, isn't it? Or does
this change fix an error?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nhpwy4vsiqbpl5ml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC9PooACgkQwfwUeK3K
7Al5owf+OYpBUlr20vHA24UHWhu+gsClpK+8L8A6RESJMnFiTSsemRJr+eM4l3wx
xKsyoMxP0rCCi17voYm7gM/+hwKtMODz+AJFnItb8LoxqrGjld94dR5Xf66VqOiE
habNp+dYBMDJ4Ig1pTYLIHKp6ISonFqoH6EoHGE2dNd4neqYF1/WfcGfJJkLrA0C
Y2t552+7RWjjuBOgEsKW1iaNNMj0uiJlwnh16n6b0IMqrJ1sw6bjLwb5bKfbrKkE
gTNe7xSwPSdjsZ9Xvj78BsHjXG3VIVzWx24XDTTcoLzbiihyXEsnNhvtiPfWBT7e
rykeESezuepTBHcu8pl7CFamvSMLxw==
=GlHq
-----END PGP SIGNATURE-----

--nhpwy4vsiqbpl5ml--
