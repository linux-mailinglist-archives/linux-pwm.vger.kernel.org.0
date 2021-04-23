Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9C368DEB
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 09:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDWHaX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 03:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHaW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 03:30:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3CC061574
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 00:29:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZqG0-0003oX-QE; Fri, 23 Apr 2021 09:29:44 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZqG0-0005S0-7X; Fri, 23 Apr 2021 09:29:44 +0200
Date:   Fri, 23 Apr 2021 09:29:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Clarify documentation about pwm_get_state()
Message-ID: <20210423072944.sthzll5srdxnglnk@pengutronix.de>
References: <20210422071212.1647352-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yu54elebck2hf675"
Content-Disposition: inline
In-Reply-To: <20210422071212.1647352-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yu54elebck2hf675
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 09:12:12AM +0200, Uwe Kleine-K=F6nig wrote:
> There is a difference between the last requested state and the last
> implemented state. Clearify that pwm_get_state() returns the former.

This patch is obsolete. This used to be a part of my patch "pwm: Rename
pwm_get_state() to better reflect its semantic"
(https://lore.kernel.org/r/20210406073036.26857-1-u.kleine-koenig@pengutron=
ix.de)
and Thierry already picked the Documentation part.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yu54elebck2hf675
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCCd2QACgkQwfwUeK3K
7Anxgwf+KCvvFygnxnlsLxD0PECNF8IUWNLmMW62kTlsqdhQToRNM758fPmJFB68
dmtDBDj0ALxo/z4nH7VdmL+E6rLdrBQOGn1l1hiaEhxt0yDjF8zzcfswnfxVW1oq
v36TFeg+i14nohwuo2PU6nDbdUWEse27kQf73ON+79s8uiwwyuhff7wAxT9SofdY
hC8fO2rKodnpSf+dxHz9vinR3PIzjxaw3rb/tHzOuM+RZ/bdUd8qNYMmTASB9+uF
v/cEps3GtsjmyaHmDRODLX4xAoze5wyqhKRhbd4diWE7mBNHkmjOpRDf5WjY3yvg
hO7PsIWcpFbjGyzG1RVYv+nh/Cq9zg==
=EpES
-----END PGP SIGNATURE-----

--yu54elebck2hf675--
