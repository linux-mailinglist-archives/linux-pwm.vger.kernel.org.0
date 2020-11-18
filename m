Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D292E2B7E8C
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKRNsv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 08:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKRNsv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 08:48:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D145FC0613D4
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 05:48:50 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfNpI-0003AT-Vd; Wed, 18 Nov 2020 14:48:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfNpI-0008Td-DW; Wed, 18 Nov 2020 14:48:48 +0100
Date:   Wed, 18 Nov 2020 14:48:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Soham Biswas <sohambiswas41@gmail.com>
Cc:     thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: core: Use octal permission
Message-ID: <20201118134846.ddghymkn2ldallnl@pengutronix.de>
References: <20201117175452.26914-1-sohambiswas41@gmail.com>
 <20201118104730.4270-1-sohambiswas41@gmail.com>
 <20201118124312.wk6cmnktxefn7k7m@pengutronix.de>
 <CAMmt7ePTtM1hj6C4dgYO2o-A1C9C7NdnJHsnqSUir13ZjeEXTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vu343jntuqqimxti"
Content-Disposition: inline
In-Reply-To: <CAMmt7ePTtM1hj6C4dgYO2o-A1C9C7NdnJHsnqSUir13ZjeEXTg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vu343jntuqqimxti
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 07:11:35PM +0530, Soham Biswas wrote:
> Sure will do that. Sorry for the inconvenience, I am a bit new to the
> process of emailing patches. Should I mark the next patch as v3?

Yes, just pass -v3 to git-format-patch or git-send-email.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vu343jntuqqimxti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+1JjwACgkQwfwUeK3K
7AmrRQf44jl3byaPFhXvbf5iEMszTzaj+xEqVyvAPpC9H7NCK6jK3sdSQ9XJunXN
OxwaiEkhjBjlGUKZRcLKiX2vcFmkz00AtlED/u4cELBucyLC3JRUoeJdKmc1yroE
8QPoGe1Ba29JWJPjBhZseDlYletxbBVg0fhkNio8dTGd86ybvPLFukqXyyW5hT/7
HFZ6gd8R6xQgzD5XjXL1wY5LGn+u9O52tHXTJV6Dq3CDsI6XtujNIn8ceDiIya/e
dDfCYyhaXIOhNV8kcJnbdYzQ7wOKF0go8OG1FJu36E87I3tT3R7KZqAITbbVN21r
FOc0dP0X7F//k2b4LGmFz1kW2HEr
=nIs5
-----END PGP SIGNATURE-----

--vu343jntuqqimxti--
